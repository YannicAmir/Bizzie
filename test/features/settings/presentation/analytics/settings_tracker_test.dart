import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/settings/presentation/analytics/settings_tracker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late SettingsTracker tracker;
  late MockIAnalyticsService mockAnalyticsService;

  setUp(() {
    mockAnalyticsService = MockIAnalyticsService();
    tracker = SettingsTracker(mockAnalyticsService);

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

  group('SettingsTracker', () {
    const String kScreenName = 'settings';

    group('logSettingsViewed', () {
      test('logSettingsViewed_triggered_logsCorrectEvent', () async {
        // act
        await tracker.logSettingsViewed();

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'settings_viewed',
            parameters: any(
              named: 'parameters',
              that: isA<Map<String, dynamic>>()
                  .having((p) => p['screen_name'], 'screen_name', kScreenName)
                  .having((p) => p['timestamp'], 'timestamp', isA<String>()),
            ),
          ),
        ).called(1);
      });

      test(
        'logSettingsViewed_analyticsServiceThrows_completesNormally',
        () async {
          // arrange
          when(
            () => mockAnalyticsService.logEvent(
              name: any(named: 'name'),
              parameters: any(named: 'parameters'),
            ),
          ).thenThrow(Exception('Analytics Failure'));

          // act & assert
          await expectLater(tracker.logSettingsViewed(), completes);
        },
      );
    });

    group('logNotificationsToggled', () {
      test('logNotificationsToggled_enabled_logsCorrectEvent', () async {
        // arrange
        const enabled = true;

        // act
        await tracker.logNotificationsToggled(enabled: enabled);

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'settings_notifications_toggled',
            parameters: any(
              named: 'parameters',
              that: isA<Map<String, dynamic>>()
                  .having((p) => p['enabled'], 'enabled', enabled)
                  .having((p) => p['screen_name'], 'screen_name', kScreenName)
                  .having((p) => p['timestamp'], 'timestamp', isA<String>()),
            ),
          ),
        ).called(1);
      });

      test(
        'logNotificationsToggled_analyticsServiceThrows_completesNormally',
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
            tracker.logNotificationsToggled(enabled: false),
            completes,
          );
        },
      );
    });

    group('logNotificationsPermissionDenied', () {
      test(
        'logNotificationsPermissionDenied_triggered_logsCorrectEvent',
        () async {
          // act
          await tracker.logNotificationsPermissionDenied();

          // assert
          verify(
            () => mockAnalyticsService.logEvent(
              name: 'settings_notifications_permission_denied',
              parameters: any(
                named: 'parameters',
                that: isA<Map<String, dynamic>>()
                    .having((p) => p['screen_name'], 'screen_name', kScreenName)
                    .having((p) => p['timestamp'], 'timestamp', isA<String>()),
              ),
            ),
          ).called(1);
        },
      );
    });

    group('logPasswordResetClicked', () {
      test('logPasswordResetClicked_triggered_logsCorrectEvent', () async {
        // act
        await tracker.logPasswordResetClicked();

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'settings_password_reset_clicked',
            parameters: any(
              named: 'parameters',
              that: isA<Map<String, dynamic>>()
                  .having((p) => p['screen_name'], 'screen_name', kScreenName)
                  .having((p) => p['timestamp'], 'timestamp', isA<String>()),
            ),
          ),
        ).called(1);
      });
    });

    group('logSignOutClicked', () {
      test('logSignOutClicked_triggered_logsCorrectEvent', () async {
        // act
        await tracker.logSignOutClicked();

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'settings_sign_out_clicked',
            parameters: any(
              named: 'parameters',
              that: isA<Map<String, dynamic>>()
                  .having((p) => p['screen_name'], 'screen_name', kScreenName)
                  .having((p) => p['timestamp'], 'timestamp', isA<String>()),
            ),
          ),
        ).called(1);
      });
    });

    group('logSignOutSuccess', () {
      test('logSignOutSuccess_triggered_logsCorrectEvent', () async {
        // act
        await tracker.logSignOutSuccess();

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'settings_sign_out_success',
            parameters: any(
              named: 'parameters',
              that: isA<Map<String, dynamic>>()
                  .having((p) => p['screen_name'], 'screen_name', kScreenName)
                  .having((p) => p['timestamp'], 'timestamp', isA<String>()),
            ),
          ),
        ).called(1);
      });
    });

    group('logSettingsLinkClicked', () {
      test('logSettingsLinkClicked_triggered_logsCorrectEvent', () async {
        // arrange
        const type = 'privacy_policy';

        // act
        await tracker.logSettingsLinkClicked(type: type);

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'settings_link_clicked',
            parameters: any(
              named: 'parameters',
              that: isA<Map<String, dynamic>>()
                  .having((p) => p['type'], 'type', type)
                  .having((p) => p['screen_name'], 'screen_name', kScreenName)
                  .having((p) => p['timestamp'], 'timestamp', isA<String>()),
            ),
          ),
        ).called(1);
      });
    });

    group('logSystemSettingsOpened', () {
      test('logSystemSettingsOpened_triggered_logsCorrectEvent', () async {
        // act
        await tracker.logSystemSettingsOpened();

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'settings_system_settings_opened',
            parameters: any(
              named: 'parameters',
              that: isA<Map<String, dynamic>>()
                  .having((p) => p['screen_name'], 'screen_name', kScreenName)
                  .having((p) => p['timestamp'], 'timestamp', isA<String>()),
            ),
          ),
        ).called(1);
      });
    });

    group('logSectorChangeViewed', () {
      test('logSectorChangeViewed_triggered_logsCorrectEvent', () async {
        // act
        await tracker.logSectorChangeViewed();

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'settings_sector_change_viewed',
            parameters: any(
              named: 'parameters',
              that: isA<Map<String, dynamic>>()
                  .having((p) => p['screen_name'], 'screen_name', kScreenName)
                  .having((p) => p['timestamp'], 'timestamp', isA<String>()),
            ),
          ),
        ).called(1);
      });
    });

    group('logSectorSelected', () {
      test('logSectorSelected_triggered_logsCorrectEvent', () async {
        // arrange
        const sector = 'Technology';

        // act
        await tracker.logSectorSelected(sector: sector);

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'settings_sector_selected',
            parameters: any(
              named: 'parameters',
              that: isA<Map<String, dynamic>>()
                  .having((p) => p['sector'], 'sector', sector)
                  .having((p) => p['screen_name'], 'screen_name', kScreenName)
                  .having((p) => p['timestamp'], 'timestamp', isA<String>()),
            ),
          ),
        ).called(1);
      });
    });

    group('logSectorUpdateSuccess', () {
      test(
        'logSectorUpdateSuccess_triggered_logsEventAndSetsProperty',
        () async {
          // arrange
          const sector = 'Technology';

          // act
          await tracker.logSectorUpdateSuccess(sector: sector);

          // assert
          verify(
            () => mockAnalyticsService.logEvent(
              name: 'settings_sector_update_success',
              parameters: any(
                named: 'parameters',
                that: isA<Map<String, dynamic>>()
                    .having((p) => p['sector'], 'sector', sector)
                    .having((p) => p['screen_name'], 'screen_name', kScreenName)
                    .having((p) => p['timestamp'], 'timestamp', isA<String>()),
              ),
            ),
          ).called(1);

          verify(
            () => mockAnalyticsService.setUserProperty(
              name: 'favorite_sector',
              value: sector,
            ),
          ).called(1);
        },
      );

      test(
        'logSectorUpdateSuccess_analyticsServiceThrows_completesNormally',
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
            tracker.logSectorUpdateSuccess(sector: 'Tech'),
            completes,
          );
        },
      );
    });

    group('logSectorUpdateFailure', () {
      test('logSectorUpdateFailure_triggered_logsCorrectEvent', () async {
        // arrange
        const sector = 'Technology';
        const error = 'Network Error';

        // act
        await tracker.logSectorUpdateFailure(sector: sector, error: error);

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'settings_sector_update_failure',
            parameters: any(
              named: 'parameters',
              that: isA<Map<String, dynamic>>()
                  .having((p) => p['sector'], 'sector', sector)
                  .having((p) => p['error'], 'error', error)
                  .having((p) => p['screen_name'], 'screen_name', kScreenName)
                  .having((p) => p['timestamp'], 'timestamp', isA<String>()),
            ),
          ),
        ).called(1);
      });
    });

    group('logEditProfileClicked', () {
      test('logEditProfileClicked_triggered_logsCorrectEvent', () async {
        // act
        await tracker.logEditProfileClicked();

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'settings_edit_profile_clicked',
            parameters: any(
              named: 'parameters',
              that: isA<Map<String, dynamic>>()
                  .having((p) => p['screen_name'], 'screen_name', kScreenName)
                  .having((p) => p['timestamp'], 'timestamp', isA<String>()),
            ),
          ),
        ).called(1);
      });
    });

    group('logFeedbackClicked', () {
      test('logFeedbackClicked_triggered_logsCorrectEvent', () async {
        // act
        await tracker.logFeedbackClicked();

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'settings_feedback_clicked',
            parameters: any(
              named: 'parameters',
              that: isA<Map<String, dynamic>>()
                  .having((p) => p['screen_name'], 'screen_name', kScreenName)
                  .having((p) => p['timestamp'], 'timestamp', isA<String>()),
            ),
          ),
        ).called(1);
      });
    });

    group('logMembershipClicked', () {
      test('logMembershipClicked_triggered_logsCorrectEvent', () async {
        // arrange
        const isSubscribed = true;

        // act
        await tracker.logMembershipClicked(isSubscribed: isSubscribed);

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'settings_membership_clicked',
            parameters: any(
              named: 'parameters',
              that: isA<Map<String, dynamic>>()
                  .having(
                    (p) => p['is_subscribed'],
                    'is_subscribed',
                    isSubscribed,
                  )
                  .having((p) => p['screen_name'], 'screen_name', kScreenName)
                  .having((p) => p['timestamp'], 'timestamp', isA<String>()),
            ),
          ),
        ).called(1);
      });
    });
  });
}
