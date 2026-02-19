import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/subscription/domain/enums/subscription_package_type.dart';
import 'package:bizzie/features/subscription/domain/enums/subscription_period_type.dart';
import 'package:bizzie/features/subscription/domain/models/analytics_purchase_params.dart';
import 'package:bizzie/features/subscription/presentation/analytics/paywall_analytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late MockAnalyticsService mockAnalyticsService;
  late PaywallAnalytics analytics;

  setUp(() {
    mockAnalyticsService = MockAnalyticsService();
    analytics = PaywallAnalytics(mockAnalyticsService);

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

  group('PaywallAnalytics', () {
    const tSource = PaywallSource.onboarding;

    test('logTriggered_standardCall_logsEventWithSource', () async {
      // arrange & act
      await analytics.logTriggered(source: tSource);

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: 'paywall_triggered',
          parameters: any(
            named: 'parameters',
            that: containsPair('source', tSource.name),
          ),
        ),
      ).called(1);
    });

    test('logGiftModalViewed_standardCall_logsEventWithSource', () async {
      // arrange & act
      await analytics.logGiftModalViewed(source: tSource);

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: 'paywall_gift_modal_viewed',
          parameters: any(
            named: 'parameters',
            that: containsPair('source', tSource.name),
          ),
        ),
      ).called(1);
    });

    group('logConversion', () {
      test(
        'logConversion_standardCall_logsEventAndSetsUserProperties',
        () async {
          // arrange & act
          await analytics.logConversion(
            source: tSource,
            value: 100.0,
            currency: 'USD',
            periodType: SubscriptionPeriodType.normal,
            isTrial: false,
          );

          // assert
          verify(
            () => mockAnalyticsService.logEvent(
              name: 'paywall_conversion',
              parameters: any(
                named: 'parameters',
                that: allOf(
                  containsPair('source', tSource.name),
                  containsPair('value', 100.0),
                  containsPair('period_type', 'normal'),
                  containsPair('is_trial', false),
                ),
              ),
            ),
          ).called(1);

          verify(
            () => mockAnalyticsService.setUserProperty(
              name: 'last_paywall_source',
              value: tSource.name,
            ),
          ).called(1);
        },
      );
    });

    group('logPurchaseSuccess', () {
      test(
        'logPurchaseSuccess_standardPurchase_logsConversionWithFullValueAndIsTrialFalse',
        () async {
          // arrange
          const tParams = AnalyticsPurchaseParams(
            productId: 'prod_1',
            packageType: SubscriptionPackageType.annual,
            periodType: SubscriptionPeriodType.normal,
            source: tSource,
            value: 239.99,
            currency: 'USD',
          );

          // act
          await analytics.logPurchaseSuccess(tParams);

          // assert
          verify(
            () => mockAnalyticsService.logEvent(
              name: 'paywall_conversion',
              parameters: any(
                named: 'parameters',
                that: allOf(
                  containsPair('value', 239.99),
                  containsPair('is_trial', false),
                ),
              ),
            ),
          ).called(1);
        },
      );
    });

    group('logTrialStarted', () {
      test(
        'logTrialStarted_trialStarted_logsConversionWithZeroValueAndIsTrialTrue',
        () async {
          // arrange
          const tParams = AnalyticsPurchaseParams(
            productId: 'prod_1',
            packageType: SubscriptionPackageType.annual,
            periodType: SubscriptionPeriodType.trial,
            source: tSource,
            value: 239.99,
            currency: 'USD',
          );

          // act
          await analytics.logTrialStarted(tParams);

          // assert
          verify(
            () => mockAnalyticsService.logEvent(
              name: 'paywall_conversion',
              parameters: any(
                named: 'parameters',
                that: allOf(
                  containsPair('value', 0.0),
                  containsPair('is_trial', true),
                  containsPair('period_type', 'trial'),
                ),
              ),
            ),
          ).called(1);

          verify(
            () => mockAnalyticsService.setUserProperty(
              name: 'onboarding_converted',
              value: 'true',
            ),
          ).called(1);
        },
      );
    });

    test('logDismissed_standardCall_logsEventWithSource', () async {
      // arrange & act
      await analytics.logDismissed(source: tSource);

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: 'paywall_dismissed',
          parameters: any(
            named: 'parameters',
            that: containsPair('source', tSource.name),
          ),
        ),
      ).called(1);
    });
  });
}
