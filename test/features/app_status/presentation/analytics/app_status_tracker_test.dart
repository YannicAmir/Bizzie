import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/app_status/domain/enums/app_status_type.dart';
import 'package:bizzie/features/app_status/presentation/analytics/app_status_tracker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late AppStatusTracker tracker;
  late MockAnalyticsService mockAnalyticsService;

  setUp(() {
    mockAnalyticsService = MockAnalyticsService();
    tracker = AppStatusTracker(mockAnalyticsService);

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

  group('AppStatusTracker', () {
    test(
      'logStatusBlocked_forceUpgrade_callsAnalyticsWithCorrectParams',
      () async {
        // arrange
        const type = 'force_upgrade';
        const minVersion = '2.0.0';

        // act
        await tracker.logStatusBlocked(type: type, minVersion: minVersion);

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'app_status_blocked',
            parameters: {
              'screen_name': 'app_status',
              'block_type': type,
              'min_version': minVersion,
            },
          ),
        ).called(1);
      },
    );

    test(
      'logStatusBlocked_maintenance_callsAnalyticsWithCorrectParams',
      () async {
        // arrange
        const type = 'maintenance';

        // act
        await tracker.logStatusBlocked(type: type);

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'app_status_blocked',
            parameters: {'screen_name': 'app_status', 'block_type': type},
          ),
        ).called(1);
      },
    );

    test(
      'updateStatusProperty_normal_callsSetUserPropertyWithSnakeCase',
      () async {
        // arrange
        const status = AppStatusType.normal;

        // act
        await tracker.updateStatusProperty(status);

        // assert
        verify(
          () => mockAnalyticsService.setUserProperty(
            name: 'app_status',
            value: 'normal',
          ),
        ).called(1);
      },
    );

    test(
      'updateStatusProperty_maintenance_callsSetUserPropertyWithSnakeCase',
      () async {
        // arrange
        const status = AppStatusType.maintenance;

        // act
        await tracker.updateStatusProperty(status);

        // assert
        verify(
          () => mockAnalyticsService.setUserProperty(
            name: 'app_status',
            value: 'maintenance',
          ),
        ).called(1);
      },
    );

    test(
      'updateStatusProperty_forceUpgrade_callsSetUserPropertyWithSnakeCase',
      () async {
        // arrange
        const status = AppStatusType.forceUpgrade;

        // act
        await tracker.updateStatusProperty(status);

        // assert
        verify(
          () => mockAnalyticsService.setUserProperty(
            name: 'app_status',
            value: 'force_upgrade',
          ),
        ).called(1);
      },
    );

    test(
      'updateStatusProperty_noInternet_callsSetUserPropertyWithSnakeCase',
      () async {
        // arrange
        const status = AppStatusType.noInternet;

        // act
        await tracker.updateStatusProperty(status);

        // assert
        verify(
          () => mockAnalyticsService.setUserProperty(
            name: 'app_status',
            value: 'no_internet',
          ),
        ).called(1);
      },
    );
  });
}
