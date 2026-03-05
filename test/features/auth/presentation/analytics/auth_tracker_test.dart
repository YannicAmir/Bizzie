import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/auth/domain/enums/auth_method.dart';
import 'package:bizzie/features/auth/domain/enums/auth_source.dart';
import 'package:bizzie/features/auth/presentation/analytics/auth_tracker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late MockAnalyticsService mockAnalyticsService;
  late AuthTracker sut;

  const kScreenName = 'auth';

  setUp(() {
    mockAnalyticsService = MockAnalyticsService();
    sut = AuthTracker(mockAnalyticsService);

    when(
      () => mockAnalyticsService.setUserId(any()),
    ).thenAnswer((_) async => {});
    when(
      () => mockAnalyticsService.setUserProperty(
        name: any(named: 'name'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((_) async => {});
    when(
      () => mockAnalyticsService.logEvent(
        name: any(named: 'name'),
        parameters: any(named: 'parameters'),
      ),
    ).thenAnswer((_) async => {});
  });

  group('AuthTracker', () {
    test('setUserId_validId_callsServiceWithId', () async {
      // arrange
      const uid = 'user-123';

      // act
      await sut.setUserId(uid);

      // assert
      verify(() => mockAnalyticsService.setUserId(uid)).called(1);
    });

    test('setUserId_nullId_callsServiceWithNull', () async {
      // arrange
      const String? uid = null;

      // act
      await sut.setUserId(uid);

      // assert
      verify(() => mockAnalyticsService.setUserId(null)).called(1);
    });

    group('Login Tracking', () {
      test('logLoginStarted_google_logsCorrectEventAndParams', () async {
        // act
        await sut.logLoginStarted(
          method: AuthMethod.google,
          source: AuthSource.landing,
        );

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'auth_login_started',
            parameters: {
              'method': 'google',
              'source': 'landing',
              'screen_name': kScreenName,
            },
          ),
        ).called(1);
      });

      test(
        'logLoginSuccess_apple_setsUserPropertiesAndLogsStandardEvent',
        () async {
          // act
          await sut.logLoginSuccess(
            method: AuthMethod.apple,
            source: AuthSource.onboarding,
          );

          // assert
          verify(
            () => mockAnalyticsService.setUserProperty(
              name: 'auth_method',
              value: 'apple',
            ),
          ).called(1);
          verify(
            () => mockAnalyticsService.setUserProperty(
              name: 'last_login_source',
              value: 'onboarding',
            ),
          ).called(1);
          verify(
            () => mockAnalyticsService.logEvent(
              name: 'login',
              parameters: {
                'method': 'apple',
                'source': 'onboarding',
                'screen_name': kScreenName,
              },
            ),
          ).called(1);
        },
      );

      test('logLoginFailure_email_logsCorrectEventWithErrorCode', () async {
        // arrange
        const errorCode = 'invalid-credential';

        // act
        await sut.logLoginFailure(
          method: AuthMethod.email,
          source: AuthSource.landing,
          error: errorCode,
        );

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'auth_login_failure',
            parameters: {
              'method': 'email',
              'source': 'landing',
              'error_code': errorCode,
              'screen_name': kScreenName,
            },
          ),
        ).called(1);
      });
    });

    group('Sign-Up Tracking', () {
      test('logSignUpStarted_email_logsCorrectEventAndParams', () async {
        // act
        await sut.logSignUpStarted(
          method: AuthMethod.email,
          source: AuthSource.onboarding,
        );

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'auth_signup_started',
            parameters: {
              'method': 'email',
              'source': 'onboarding',
              'screen_name': kScreenName,
            },
          ),
        ).called(1);
      });

      test(
        'logSignUpSuccess_email_setsUserPropertiesAndLogsStandardEvent',
        () async {
          // act
          await sut.logSignUpSuccess(
            method: AuthMethod.email,
            source: AuthSource.onboarding,
          );

          // assert
          verify(
            () => mockAnalyticsService.setUserProperty(
              name: 'auth_method',
              value: 'email',
            ),
          ).called(1);
          verify(
            () => mockAnalyticsService.setUserProperty(
              name: 'last_login_source',
              value: 'onboarding',
            ),
          ).called(1);
          verify(
            () => mockAnalyticsService.logEvent(
              name: 'sign_up',
              parameters: {
                'method': 'email',
                'source': 'onboarding',
                'screen_name': kScreenName,
              },
            ),
          ).called(1);
        },
      );

      test('logSignUpFailure_email_logsCorrectEventWithErrorCode', () async {
        // arrange
        const errorCode = 'email-already-in-use';

        // act
        await sut.logSignUpFailure(
          method: AuthMethod.email,
          source: AuthSource.onboarding,
          error: errorCode,
        );

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'auth_signup_failure',
            parameters: {
              'method': 'email',
              'source': 'onboarding',
              'error_code': errorCode,
              'screen_name': kScreenName,
            },
          ),
        ).called(1);
      });
    });

    group('Workflow Actions', () {
      test('logLogout_invoked_logsCorrectEvent', () async {
        // act
        await sut.logLogout();

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'auth_logout',
            parameters: {'screen_name': kScreenName},
          ),
        ).called(1);
      });

      test(
        'logPasswordResetRequested_forgotPassword_logsCorrectEventWithSource',
        () async {
          // act
          await sut.logPasswordResetRequested(
            source: AuthSource.forgotPassword,
          );

          // assert
          verify(
            () => mockAnalyticsService.logEvent(
              name: 'auth_password_reset_requested',
              parameters: {
                'source': 'forgot_password',
                'screen_name': kScreenName,
              },
            ),
          ).called(1);
        },
      );

      test('logAccountDeleted_invoked_logsCorrectEvent', () async {
        // act
        await sut.logAccountDeleted();

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'auth_account_deleted',
            parameters: {'screen_name': kScreenName},
          ),
        ).called(1);
      });
    });

    group('Parameter Mapping', () {
      test('logLoginStarted_allSources_mapsCorrectSnakeCaseStrings', () async {
        // This test iterates through all AuthSource values to verify mapping coverage
        for (final source in AuthSource.values) {
          // arrange
          final expectedString = switch (source) {
            AuthSource.landing => 'landing',
            AuthSource.onboarding => 'onboarding',
            AuthSource.settings => 'settings',
            AuthSource.sessionExpired => 'session_expired',
            AuthSource.forgotPassword => 'forgot_password',
            AuthSource.createAccount => 'create_account',
          };

          // act
          await sut.logLoginStarted(method: AuthMethod.google, source: source);

          // assert
          verify(
            () => mockAnalyticsService.logEvent(
              name: 'auth_login_started',
              parameters: {
                'method': 'google',
                'source': expectedString,
                'screen_name': kScreenName,
              },
            ),
          ).called(1);
        }
      });
    });
  });
}
