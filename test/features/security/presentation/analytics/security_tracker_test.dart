import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/security/domain/enums/security_analytics_enums.dart';
import 'package:bizzie/features/security/presentation/analytics/security_tracker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late SecurityTracker tracker;
  late MockIAnalyticsService mockAnalyticsService;

  setUp(() {
    mockAnalyticsService = MockIAnalyticsService();
    tracker = SecurityTracker(mockAnalyticsService);

    when(
      () => mockAnalyticsService.logEvent(
        name: any(named: 'name'),
        parameters: any(named: 'parameters'),
      ),
    ).thenAnswer((_) async {});

    when(
      () => mockAnalyticsService.setUserProperty(
        name: any(named: 'name'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((_) async {});
  });

  group('SecurityTracker', () {
    group('logThreatDetected', () {
      test('logThreatDetected_validThreat_logsCorrectEvent', () async {
        // arrange
        const type = SecurityThreatType.simulator;
        const isCritical = true;

        // act
        await tracker.logThreatDetected(type: type, isCritical: isCritical);

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'security_threat_detected',
            parameters: any(
              named: 'parameters',
              that: isA<Map<String, dynamic>>()
                  .having(
                    (p) => p['threat_type'],
                    'threat_type',
                    type.analyticsValue,
                  )
                  .having((p) => p['is_critical'], 'is_critical', isCritical)
                  .having(
                    (p) => p['screen_name'],
                    'screen_name',
                    'security_lockout',
                  )
                  .having((p) => p['timestamp'], 'timestamp', isA<String>()),
            ),
          ),
        ).called(1);
      });

      test(
        'logThreatDetected_analyticsServiceThrows_completesNormally',
        () async {
          // arrange
          when(
            () => mockAnalyticsService.logEvent(
              name: any(named: 'name'),
              parameters: any(named: 'parameters'),
            ),
          ).thenThrow(Exception('Analytics Failure'));

          // act & assert
          await expectLater(
            tracker.logThreatDetected(
              type: SecurityThreatType.simulator,
              isCritical: false,
            ),
            completes,
          );
        },
      );
    });

    group('logLockoutViewed', () {
      test('logLockoutViewed_triggered_logsCorrectEvent', () async {
        // act
        await tracker.logLockoutViewed();

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'security_lockout_viewed',
            parameters: any(
              named: 'parameters',
              that: isA<Map<String, dynamic>>()
                  .having(
                    (p) => p['screen_name'],
                    'screen_name',
                    'security_lockout',
                  )
                  .having((p) => p['timestamp'], 'timestamp', isA<String>()),
            ),
          ),
        ).called(1);
      });

      test(
        'logLockoutViewed_analyticsServiceThrows_completesNormally',
        () async {
          // arrange
          when(
            () => mockAnalyticsService.logEvent(
              name: any(named: 'name'),
              parameters: any(named: 'parameters'),
            ),
          ).thenThrow(Exception('Analytics Failure'));

          // act & assert
          await expectLater(tracker.logLockoutViewed(), completes);
        },
      );
    });

    group('logLockoutAction', () {
      test('logLockoutAction_validAction_logsCorrectEvent', () async {
        // arrange
        const action = SecurityLockoutAction.closeApp;

        // act
        await tracker.logLockoutAction(action);

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'security_lockout_action',
            parameters: any(
              named: 'parameters',
              that: isA<Map<String, dynamic>>()
                  .having((p) => p['action'], 'action', action.analyticsValue)
                  .having(
                    (p) => p['screen_name'],
                    'screen_name',
                    'security_lockout',
                  )
                  .having((p) => p['timestamp'], 'timestamp', isA<String>()),
            ),
          ),
        ).called(1);
      });

      test(
        'logLockoutAction_analyticsServiceThrows_completesNormally',
        () async {
          // arrange
          when(
            () => mockAnalyticsService.logEvent(
              name: any(named: 'name'),
              parameters: any(named: 'parameters'),
            ),
          ).thenThrow(Exception('Analytics Failure'));

          // act & assert
          await expectLater(
            tracker.logLockoutAction(SecurityLockoutAction.closeApp),
            completes,
          );
        },
      );
    });

    group('setSecurityThreatProperty', () {
      test('setSecurityThreatProperty_validType_setsCorrectProperty', () async {
        // arrange
        const type = SecurityThreatType.hooks;

        // act
        await tracker.setSecurityThreatProperty(type);

        // assert
        verify(
          () => mockAnalyticsService.setUserProperty(
            name: 'device_security_threat',
            value: type.analyticsValue,
          ),
        ).called(1);
      });

      test('setSecurityThreatProperty_nullType_clearsProperty', () async {
        // act
        await tracker.setSecurityThreatProperty(null);

        // assert
        verify(
          () => mockAnalyticsService.setUserProperty(
            name: 'device_security_threat',
            value: null,
          ),
        ).called(1);
      });

      test(
        'setSecurityThreatProperty_analyticsServiceThrows_completesNormally',
        () async {
          // arrange
          when(
            () => mockAnalyticsService.setUserProperty(
              name: any(named: 'name'),
              value: any(named: 'value'),
            ),
          ).thenThrow(Exception('Analytics Failure'));

          // act & assert
          await expectLater(
            tracker.setSecurityThreatProperty(SecurityThreatType.hooks),
            completes,
          );
        },
      );
    });
  });
}
