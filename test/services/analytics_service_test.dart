import 'package:bizzie/services/analytics_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {}

void main() {
  late AnalyticsService analyticsService;
  late MockFirebaseAnalytics mockFirebaseAnalytics;

  setUp(() {
    mockFirebaseAnalytics = MockFirebaseAnalytics();
    analyticsService = AnalyticsService(mockFirebaseAnalytics);
  });

  group('AnalyticsService', () {
    group('logEvent', () {
      test(
        'logEvent_withParameters_logsWithTimestampAndSanitizedBooleans',
        () async {
          // arrange
          const eventName = 'test_event';
          final parameters = {
            'string_param': 'value',
            'int_param': 42,
            'bool_param': true,
          };

          when(
            () => mockFirebaseAnalytics.logEvent(
              name: any(named: 'name'),
              parameters: any(named: 'parameters'),
            ),
          ).thenAnswer((_) async => {});

          // act
          await analyticsService.logEvent(
            name: eventName,
            parameters: parameters,
          );

          // assert
          verify(
            () => mockFirebaseAnalytics.logEvent(
              name: eventName,
              parameters: any(
                named: 'parameters',
                that: isA<Map<String, Object>>()
                    .having((p) => p['timestamp'], 'timestamp', isNotNull)
                    .having((p) => p['bool_param'], 'bool_param', 'true')
                    .having((p) => p['string_param'], 'string_param', 'value'),
              ),
            ),
          ).called(1);
        },
      );

      test('logEvent_withoutParameters_logsWithOnlyTimestamp', () async {
        // arrange
        const eventName = 'test_event_no_params';

        when(
          () => mockFirebaseAnalytics.logEvent(
            name: any(named: 'name'),
            parameters: any(named: 'parameters'),
          ),
        ).thenAnswer((_) async => {});

        // act
        await analyticsService.logEvent(name: eventName);

        // assert
        verify(
          () => mockFirebaseAnalytics.logEvent(
            name: eventName,
            parameters: any(
              named: 'parameters',
              that: isA<Map<String, Object>>()
                  .having((p) => p['timestamp'], 'timestamp', isNotNull)
                  .having((p) => p.length, 'length', 1),
            ),
          ),
        ).called(1);
      });
    });

    group('setUserProperty', () {
      test('setUserProperty_validInput_callsFirebaseAnalytics', () async {
        // arrange
        const name = 'user_type';
        const value = 'premium';

        when(
          () => mockFirebaseAnalytics.setUserProperty(
            name: any(named: 'name'),
            value: any(named: 'value'),
          ),
        ).thenAnswer((_) async => {});

        // act
        await analyticsService.setUserProperty(name: name, value: value);

        // assert
        verify(
          () => mockFirebaseAnalytics.setUserProperty(name: name, value: value),
        ).called(1);
      });
    });

    group('logScreenView', () {
      test(
        'logScreenView_withOverride_callsFirebaseAnalyticsWithOverride',
        () async {
          // arrange
          const screenName = 'Home';
          const screenClassOverride = 'HomeView';

          when(
            () => mockFirebaseAnalytics.logScreenView(
              screenName: any(named: 'screenName'),
              screenClass: any(named: 'screenClass'),
            ),
          ).thenAnswer((_) async => {});

          // act
          await analyticsService.logScreenView(
            screenName: screenName,
            screenClassOverride: screenClassOverride,
          );

          // assert
          verify(
            () => mockFirebaseAnalytics.logScreenView(
              screenName: screenName,
              screenClass: screenClassOverride,
            ),
          ).called(1);
        },
      );

      test(
        'logScreenView_noOverride_callsFirebaseAnalyticsWithDefaultFlutter',
        () async {
          // arrange
          const screenName = 'Home';

          when(
            () => mockFirebaseAnalytics.logScreenView(
              screenName: any(named: 'screenName'),
              screenClass: any(named: 'screenClass'),
            ),
          ).thenAnswer((_) async => {});

          // act
          await analyticsService.logScreenView(screenName: screenName);

          // assert
          verify(
            () => mockFirebaseAnalytics.logScreenView(
              screenName: screenName,
              screenClass: 'Flutter',
            ),
          ).called(1);
        },
      );
    });

    group('setUserId', () {
      test('setUserId_validInput_callsFirebaseAnalytics', () async {
        // arrange
        const userId = 'user_123';

        when(
          () => mockFirebaseAnalytics.setUserId(id: any(named: 'id')),
        ).thenAnswer((_) async => {});

        // act
        await analyticsService.setUserId(userId);

        // assert
        verify(() => mockFirebaseAnalytics.setUserId(id: userId)).called(1);
      });
    });

    group('setAnalyticsCollectionEnabled', () {
      test(
        'setAnalyticsCollectionEnabled_validInput_callsFirebaseAnalytics',
        () async {
          // arrange
          const enabled = true;

          when(
            () => mockFirebaseAnalytics.setAnalyticsCollectionEnabled(any()),
          ).thenAnswer((_) async => {});

          // act
          await analyticsService.setAnalyticsCollectionEnabled(enabled);

          // assert
          verify(
            () => mockFirebaseAnalytics.setAnalyticsCollectionEnabled(enabled),
          ).called(1);
        },
      );
    });
  });
}
