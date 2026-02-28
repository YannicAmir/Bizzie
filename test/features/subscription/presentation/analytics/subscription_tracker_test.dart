import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/subscription/domain/enums/subscription_period_type.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:bizzie/features/subscription/presentation/analytics/subscription_tracker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late MockAnalyticsService mockAnalytics;
  late SubscriptionTracker tracker;

  setUp(() {
    mockAnalytics = MockAnalyticsService();
    tracker = SubscriptionTracker(mockAnalytics);
  });

  group('SubscriptionTracker', () {
    group('syncSubscriptionProperties', () {
      test('syncSubscriptionProperties_notSubscribed_setsNoneType', () async {
        // arrange
        final status = SubscriptionStatus.initial();
        when(
          () => mockAnalytics.setUserProperty(
            name: any(named: 'name'),
            value: any(named: 'value'),
          ),
        ).thenAnswer((_) async => {});

        // act
        await tracker.syncSubscriptionProperties(status);

        // assert
        verify(
          () => mockAnalytics.setUserProperty(
            name: 'is_subscribed',
            value: 'false',
          ),
        ).called(1);
        verify(
          () => mockAnalytics.setUserProperty(
            name: 'subscription_type',
            value: 'none',
          ),
        ).called(1);
      });

      test('syncSubscriptionProperties_onTrial_setsFreeTrialType', () async {
        // arrange
        final status = SubscriptionStatus.initial().copyWith(
          isSubscribed: true,
          periodType: SubscriptionPeriodType.trial,
        );
        when(
          () => mockAnalytics.setUserProperty(
            name: any(named: 'name'),
            value: any(named: 'value'),
          ),
        ).thenAnswer((_) async => {});

        // act
        await tracker.syncSubscriptionProperties(status);

        // assert
        verify(
          () => mockAnalytics.setUserProperty(
            name: 'is_subscribed',
            value: 'true',
          ),
        ).called(1);
        verify(
          () => mockAnalytics.setUserProperty(
            name: 'subscription_type',
            value: 'free_trial',
          ),
        ).called(1);
      });

      test(
        'syncSubscriptionProperties_annualPlan_setsFullPriceYearly',
        () async {
          // arrange
          final status = SubscriptionStatus.initial().copyWith(
            isSubscribed: true,
            activePlanId: 'io.getbizzie.annual.full',
          );
          when(
            () => mockAnalytics.setUserProperty(
              name: any(named: 'name'),
              value: any(named: 'value'),
            ),
          ).thenAnswer((_) async => {});

          // act
          await tracker.syncSubscriptionProperties(status);

          // assert
          verify(
            () => mockAnalytics.setUserProperty(
              name: 'subscription_type',
              value: 'full_price_yearly',
            ),
          ).called(1);
        },
      );

      test(
        'syncSubscriptionProperties_discountAnnualPlan_setsDiscountYearly',
        () async {
          // arrange
          final status = SubscriptionStatus.initial().copyWith(
            isSubscribed: true,
            activePlanId: 'io.getbizzie.annual.discount',
          );
          when(
            () => mockAnalytics.setUserProperty(
              name: any(named: 'name'),
              value: any(named: 'value'),
            ),
          ).thenAnswer((_) async => {});

          // act
          await tracker.syncSubscriptionProperties(status);

          // assert
          verify(
            () => mockAnalytics.setUserProperty(
              name: 'subscription_type',
              value: 'discount_yearly',
            ),
          ).called(1);
        },
      );

      test('syncSubscriptionProperties_monthlyPlan_setsMonthly', () async {
        // arrange
        final status = SubscriptionStatus.initial().copyWith(
          isSubscribed: true,
          activePlanId: 'io.getbizzie.monthly.full',
        );
        when(
          () => mockAnalytics.setUserProperty(
            name: any(named: 'name'),
            value: any(named: 'value'),
          ),
        ).thenAnswer((_) async => {});

        // act
        await tracker.syncSubscriptionProperties(status);

        // assert
        verify(
          () => mockAnalytics.setUserProperty(
            name: 'subscription_type',
            value: 'monthly',
          ),
        ).called(1);
      });

      test(
        'syncSubscriptionProperties_unknownSubscribedPlan_setsActiveSubscriber',
        () async {
          // arrange
          final status = SubscriptionStatus.initial().copyWith(
            isSubscribed: true,
            activePlanId: 'some_weird_id',
          );
          when(
            () => mockAnalytics.setUserProperty(
              name: any(named: 'name'),
              value: any(named: 'value'),
            ),
          ).thenAnswer((_) async => {});

          // act
          await tracker.syncSubscriptionProperties(status);

          // assert
          verify(
            () => mockAnalytics.setUserProperty(
              name: 'subscription_type',
              value: 'active_subscriber',
            ),
          ).called(1);
        },
      );

      test(
        'syncSubscriptionProperties_analyticsServiceThrows_logsErrorAndDoesNotCrash',
        () async {
          // arrange
          final status = SubscriptionStatus.initial();
          when(
            () => mockAnalytics.setUserProperty(
              name: any(named: 'name'),
              value: any(named: 'value'),
            ),
          ).thenThrow(Exception('Analytics error'));

          // act & assert
          await expectLater(
            tracker.syncSubscriptionProperties(status),
            completes,
          );
        },
      );
    });
  });
}
