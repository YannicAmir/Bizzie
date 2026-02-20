import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:bizzie/core/enums/paywall_source.dart';

import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_event.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_state.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_offering.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:bizzie/features/subscription/domain/usecases/watch_subscription_status_use_case.dart';
import 'package:bizzie/features/subscription/domain/usecases/refresh_subscription_status_use_case.dart';
import 'package:bizzie/features/subscription/domain/usecases/get_offerings_use_case.dart';
import 'package:bizzie/features/subscription/domain/usecases/purchase_subscription_use_case.dart';
import 'package:bizzie/features/subscription/domain/usecases/restore_purchases_use_case.dart';
import 'package:bizzie/features/subscription/domain/usecases/sync_identity_use_case.dart';
import 'package:bizzie/features/subscription/domain/usecases/sync_subscription_use_case.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_event.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_state.dart';
import 'package:bizzie/features/subscription/presentation/analytics/paywall_analytics.dart';
import 'package:bizzie/features/subscription/domain/enums/subscription_package_type.dart';
import 'package:bizzie/features/subscription/domain/models/analytics_purchase_params.dart';
import 'package:bizzie/features/subscription/domain/enums/subscription_period_type.dart';
import 'package:bizzie/features/subscription/domain/enums/paywall_type.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:fake_async/fake_async.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_step.dart';
import 'package:bizzie/features/onboarding/presentation/analytics/onboarding_tracker.dart';

class MockWatchSubscriptionStatusUseCase extends Mock
    implements WatchSubscriptionStatusUseCase {}

class MockRefreshSubscriptionStatusUseCase extends Mock
    implements RefreshSubscriptionStatusUseCase {}

class MockSyncIdentityUseCase extends Mock implements SyncIdentityUseCase {}

class MockPurchaseSubscriptionUseCase extends Mock
    implements PurchaseSubscriptionUseCase {}

class MockRestorePurchasesUseCase extends Mock
    implements RestorePurchasesUseCase {}

class MockGetOfferingsUseCase extends Mock implements GetOfferingsUseCase {}

class MockSyncSubscriptionUseCase extends Mock
    implements SyncSubscriptionUseCase {}

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class MockPaywallAnalytics extends Mock implements PaywallAnalytics {}

class MockOnboardingTracker extends Mock implements OnboardingTracker {}

void main() {
  late MockWatchSubscriptionStatusUseCase mockWatchStatus;
  late MockRefreshSubscriptionStatusUseCase mockRefreshStatus;
  late MockSyncIdentityUseCase mockSyncIdentity;
  late MockPurchaseSubscriptionUseCase mockPurchase;
  late MockRestorePurchasesUseCase mockRestore;
  late MockGetOfferingsUseCase mockGetOfferings;
  late MockSyncSubscriptionUseCase mockSyncSubscription;
  late MockAuthBloc mockAuthBloc;
  late MockPaywallAnalytics mockAnalytics;
  late MockOnboardingTracker mockOnboardingTracker;
  late StreamController<bool> isSubscribedController;

  final tAnnualPackage = SubscriptionPackage(
    id: 'annual_id',
    identifier: 'annual_plus',
    productId: 'io.getbizzie.bizzieapp.plus.annual.full.dev',
    packageType: SubscriptionPackageType.annual,
    title: 'Annual Plus',
    description: 'Annual Plus description',
    priceString: '\$99.00',
    price: 99.0,
    currencyCode: 'USD',
  );

  final tMonthlyPackage = SubscriptionPackage(
    id: 'monthly_id',
    identifier: 'monthly_plus',
    productId: 'io.getbizzie.bizzieapp.plus.monthly.full.dev',
    packageType: SubscriptionPackageType.monthly,
    title: 'Monthly Plus',
    description: 'Monthly Plus description',
    priceString: '\$9.99',
    price: 9.99,
    currencyCode: 'USD',
  );

  final tDiscountPackage = SubscriptionPackage(
    id: 'discount_id',
    identifier: 'annual_plus_discount',
    productId: 'io.getbizzie.bizzieapp.plus.annual.discount.dev',
    packageType: SubscriptionPackageType.annual,
    title: 'Discounted Plus',
    description: 'Discounted description',
    priceString: '\$49.00',
    price: 49.0,
    currencyCode: 'USD',
  );

  final tOffering = SubscriptionOffering(
    identifier: 'default',
    serverDescription: 'Default offering',
    availablePackages: [tAnnualPackage, tMonthlyPackage, tDiscountPackage],
  );

  final tStatus = SubscriptionStatus.initial();
  final tSubscribedStatus = tStatus.copyWith(isSubscribed: true);

  setUpAll(() {
    registerFallbackValue(OnboardingStep.landing);
    registerFallbackValue(NoParams());
    registerFallbackValue(tAnnualPackage);
    registerFallbackValue(SubscriptionStatus.initial());
    registerFallbackValue(const Failure.server(''));
    registerFallbackValue(PaywallSource.unknown);
    registerFallbackValue(PaywallType.regular);
    registerFallbackValue(
      const AnalyticsPurchaseParams(
        productId: '',
        packageType: SubscriptionPackageType.unknown,
        periodType: SubscriptionPeriodType.unknown,
        source: PaywallSource.unknown,
      ),
    );
  });

  setUp(() {
    mockWatchStatus = MockWatchSubscriptionStatusUseCase();
    mockRefreshStatus = MockRefreshSubscriptionStatusUseCase();
    mockSyncIdentity = MockSyncIdentityUseCase();
    mockPurchase = MockPurchaseSubscriptionUseCase();
    mockRestore = MockRestorePurchasesUseCase();
    mockGetOfferings = MockGetOfferingsUseCase();
    mockSyncSubscription = MockSyncSubscriptionUseCase();
    mockAuthBloc = MockAuthBloc();
    mockAnalytics = MockPaywallAnalytics();
    when(
      () => mockAnalytics.logGiftViewed(source: any(named: 'source')),
    ).thenAnswer((_) async => {});
    mockOnboardingTracker = MockOnboardingTracker();
    isSubscribedController = StreamController<bool>.broadcast();

    when(
      () => mockAnalytics.logTriggered(
        source: any(named: 'source'),
        paywallType: any<PaywallType>(named: 'paywallType'),
      ),
    ).thenAnswer((_) async => {});
    when(
      () => mockAnalytics.logGiftClaimed(source: any(named: 'source')),
    ).thenAnswer((_) async => {});
    when(
      () => mockAnalytics.logGiftDismissed(source: any(named: 'source')),
    ).thenAnswer((_) async => {});
    when(
      () => mockOnboardingTracker.logStepViewed(step: any(named: 'step')),
    ).thenAnswer((_) async => {});
    when(
      () => mockOnboardingTracker.logConversion(),
    ).thenAnswer((_) async => {});
    when(
      () => mockAnalytics.logPurchaseSuccess(any()),
    ).thenAnswer((_) async => {});
    when(
      () => mockAnalytics.logTrialStarted(any()),
    ).thenAnswer((_) async => {});
    when(
      () => mockAnalytics.logRestoreRequested(source: any(named: 'source')),
    ).thenAnswer((_) async => {});
    when(
      () => mockAuthBloc.state,
    ).thenReturn(const AuthState.unauthenticated());
    whenListen(
      mockAuthBloc,
      const Stream<AuthState>.empty(),
      initialState: const AuthState.unauthenticated(),
    );

    when(
      () => mockSyncIdentity.call(any()),
    ).thenAnswer((_) async => const Right(null));
    when(
      () => mockGetOfferings.call(any()),
    ).thenAnswer((_) async => Right(tOffering));
    when(
      () => mockWatchStatus.call(any()),
    ).thenAnswer((_) => const Stream.empty());
    when(
      () => mockRefreshStatus.call(any()),
    ).thenAnswer((_) async => const Right(null));
    when(
      () => mockSyncSubscription.call(any()),
    ).thenAnswer((_) async => const Right(null));
  });

  SubscriptionBloc createBloc() {
    return SubscriptionBloc(
      mockWatchStatus,
      mockRefreshStatus,
      mockSyncIdentity,
      mockPurchase,
      mockRestore,
      mockGetOfferings,
      mockAuthBloc,
      mockSyncSubscription,
      isSubscribedController.stream,
      mockAnalytics,
      mockOnboardingTracker,
    );
  }

  group('SubscriptionBloc', () {
    test('initialState_emitsCorrectStatus', () {
      // arrange
      final bloc = createBloc();
      // act & assert
      expect(bloc.state, isA<SubscriptionStateInitial>());
      bloc.close();
    });

    group('initialized', () {
      blocTest<SubscriptionBloc, SubscriptionState>(
        'initialized_unauthenticated_emitsLoadedWithOfferings',
        // arrange
        build: () => createBloc(),
        // act
        act: (bloc) => bloc.add(const SubscriptionEvent.initialized()),
        // assert
        expect: () => [
          isA<SubscriptionStateLoaded>().having(
            (s) => s.offerings,
            'offerings',
            tOffering,
          ),
        ],
        verify: (_) {
          verify(() => mockGetOfferings.call(any())).called(1);
          verifyNever(() => mockSyncIdentity.call(any()));
        },
      );

      blocTest<SubscriptionBloc, SubscriptionState>(
        'initialized_authenticated_triggersIdentityChange',
        // arrange
        setUp: () {
          const tUser = UserModel(id: 'user_123', email: 'test@example.com');
          when(
            () => mockAuthBloc.state,
          ).thenReturn(const AuthState.authenticated(tUser));
        },
        build: () => createBloc(),
        // act
        act: (bloc) => bloc.add(const SubscriptionEvent.initialized()),
        // assert
        expect: () => [isA<SubscriptionStateLoaded>()],
        verify: (_) {
          verify(() => mockSyncIdentity.call('user_123')).called(1);
        },
      );
    });

    group('userIdentityChanged', () {
      const tUserId = 'user_123';

      blocTest<SubscriptionBloc, SubscriptionState>(
        'userIdentityChanged_authenticated_syncsAndWatches',
        // arrange
        setUp: () {
          when(
            () => mockWatchStatus(any()),
          ).thenAnswer((_) => Stream.fromIterable([tSubscribedStatus]));
        },
        build: () => createBloc(),
        // act
        act: (bloc) =>
            bloc.add(const SubscriptionEvent.userIdentityChanged(tUserId)),
        // assert
        expect: () => [
          isA<SubscriptionState>().having(
            (s) => s.status.isSubscribed,
            'subscribed',
            true,
          ),
          isA<SubscriptionStateLoaded>(),
        ],
        verify: (_) {
          verify(() => mockSyncIdentity.call(tUserId)).called(1);
          verify(() => mockWatchStatus.call(tUserId)).called(1);
        },
      );

      blocTest<SubscriptionBloc, SubscriptionState>(
        'userIdentityChanged_sameUid_skipsRedundantSync',
        // arrange
        build: () => createBloc(),
        act: (bloc) async {
          bloc.add(const SubscriptionEvent.userIdentityChanged(tUserId));
          await Future.delayed(Duration.zero);
          bloc.add(const SubscriptionEvent.userIdentityChanged(tUserId));
        },
        // assert
        verify: (_) {
          verify(() => mockSyncIdentity.call(tUserId)).called(1);
        },
      );

      blocTest<SubscriptionBloc, SubscriptionState>(
        'userIdentityChanged_syncFailure_logsErrorButContinues',
        // arrange
        setUp: () {
          when(
            () => mockSyncIdentity.call(any()),
          ).thenAnswer((_) async => const Left(Failure.server('sync error')));
        },
        build: () => createBloc(),
        // act
        act: (bloc) =>
            bloc.add(const SubscriptionEvent.userIdentityChanged(tUserId)),
        // assert
        expect: () => [isA<SubscriptionStateLoaded>()],
      );

      blocTest<SubscriptionBloc, SubscriptionState>(
        'userIdentityChanged_unauthenticated_resetsState',
        // arrange
        build: () => createBloc(),
        // act
        act: (bloc) =>
            bloc.add(const SubscriptionEvent.userIdentityChanged(null)),
        // assert
        expect: () => [SubscriptionState.initial(status: tStatus)],
      );
    });

    group('viewed', () {
      blocTest<SubscriptionBloc, SubscriptionState>(
        'viewed_emitsUpdatedSourceAndLogsAnalytics',
        // arrange
        build: () => createBloc(),
        // act
        act: (bloc) => bloc.add(
          const SubscriptionEvent.viewed(
            source: PaywallSource.onboarding,
            paywallType: PaywallType.regular,
          ),
        ),
        // assert
        expect: () => [
          isA<SubscriptionState>().having(
            (s) => s.paywallSource,
            'source',
            PaywallSource.onboarding,
          ),
        ],
        verify: (_) {
          verify(
            () => mockAnalytics.logTriggered(
              source: PaywallSource.onboarding,
              paywallType: PaywallType.regular,
            ),
          ).called(1);
        },
      );
    });

    group('offeringsRequested', () {
      blocTest<SubscriptionBloc, SubscriptionState>(
        'offeringsRequested_success_emitsLoaded',
        // arrange
        build: () => createBloc(),
        // act
        act: (bloc) => bloc.add(const SubscriptionEvent.offeringsRequested()),
        // assert
        expect: () => [
          isA<SubscriptionStateLoaded>().having(
            (s) => s.offerings,
            'offerings',
            tOffering,
          ),
        ],
      );

      blocTest<SubscriptionBloc, SubscriptionState>(
        'offeringsRequested_nearExpiration_triggersProactiveRefresh',
        // arrange
        setUp: () {
          mockRefreshStatus = MockRefreshSubscriptionStatusUseCase();
          when(
            () => mockRefreshStatus(any()),
          ).thenAnswer((_) async => const Right(null));
          when(
            () => mockGetOfferings(any()),
          ).thenAnswer((_) async => Right(tOffering));
        },
        build: () => SubscriptionBloc(
          mockWatchStatus,
          mockRefreshStatus,
          mockSyncIdentity,
          mockPurchase,
          mockRestore,
          mockGetOfferings,
          mockAuthBloc,
          mockSyncSubscription,
          isSubscribedController.stream,
          mockAnalytics,
          mockOnboardingTracker,
        ),
        seed: () {
          final now = DateTime.now().toUtc();
          return SubscriptionState.initial(
            status: tSubscribedStatus.copyWith(
              expirationDate: now.add(const Duration(minutes: 5)),
            ),
          );
        },
        // act
        act: (bloc) => bloc.add(const SubscriptionEvent.offeringsRequested()),
        // assert
        verify: (_) {
          verify(() => mockRefreshStatus.call(any())).called(1);
        },
      );

      blocTest<SubscriptionBloc, SubscriptionState>(
        'offeringsRequested_failure_emitsFailure',
        // arrange
        setUp: () {
          when(
            () => mockGetOfferings(any()),
          ).thenAnswer((_) async => const Left(Failure.server('error')));
        },
        build: () => createBloc(),
        // act
        act: (bloc) => bloc.add(const SubscriptionEvent.offeringsRequested()),
        // assert
        expect: () => [
          isA<SubscriptionStateFailure>().having(
            (s) => s.failure.message,
            'message',
            'error',
          ),
        ],
      );

      blocTest<SubscriptionBloc, SubscriptionState>(
        'offeringsRequested_isPurchasingTrue_ignoresRequest',
        // arrange
        build: () => createBloc(),
        seed: () => SubscriptionState.loaded(
          status: tStatus,
          offerings: tOffering,
          isPurchasing: true,
          annualPackage: tAnnualPackage,
          monthlyPackage: tMonthlyPackage,
          discountAnnualPackage: tDiscountPackage,
        ),
        // act
        act: (bloc) => bloc.add(const SubscriptionEvent.offeringsRequested()),
        // assert
        expect: () => [],
        verify: (_) {
          verifyNever(() => mockGetOfferings.call(any()));
        },
      );
    });

    group('purchaseRequested', () {
      blocTest<SubscriptionBloc, SubscriptionState>(
        'purchaseRequested_success_emitsLoadedWithSuccessOverride',
        // arrange
        setUp: () {
          when(
            () => mockPurchase(any()),
          ).thenAnswer((_) async => Right(tSubscribedStatus));
        },
        build: () => createBloc(),
        seed: () => SubscriptionState.loaded(
          status: tStatus,
          offerings: tOffering,
          annualPackage: tAnnualPackage,
          monthlyPackage: tMonthlyPackage,
          discountAnnualPackage: tDiscountPackage,
        ),
        // act
        act: (bloc) =>
            bloc.add(SubscriptionEvent.purchaseRequested(tAnnualPackage)),
        // assert
        expect: () => [
          isA<SubscriptionStateLoaded>().having(
            (s) => s.isPurchasing,
            'isPurchasing',
            true,
          ),
          isA<SubscriptionStateLoaded>()
              .having((s) => s.isPurchasing, 'isPurchasing', true)
              .having((s) => s.isLocalSuccessOverride, 'localSuccess', true)
              .having((s) => s.status.isSubscribed, 'subscribed', true),
        ],
      );

      blocTest<SubscriptionBloc, SubscriptionState>(
        'purchaseRequested_cancel_resetsIsPurchasing',
        // arrange
        setUp: () {
          when(
            () => mockPurchase(any()),
          ).thenAnswer((_) async => const Left(Failure.cancel()));
        },
        build: () => createBloc(),
        seed: () => SubscriptionState.loaded(
          status: tStatus,
          offerings: tOffering,
          annualPackage: tAnnualPackage,
          monthlyPackage: tMonthlyPackage,
          discountAnnualPackage: tDiscountPackage,
        ),
        // act
        act: (bloc) =>
            bloc.add(SubscriptionEvent.purchaseRequested(tAnnualPackage)),
        // assert
        expect: () => [
          isA<SubscriptionStateLoaded>().having(
            (s) => s.isPurchasing,
            'isPurchasing',
            true,
          ),
          isA<SubscriptionStateLoaded>().having(
            (s) => s.isPurchasing,
            'isPurchasing',
            false,
          ),
        ],
      );

      blocTest<SubscriptionBloc, SubscriptionState>(
        'purchaseRequested_failure_emitsFailure',
        // arrange
        setUp: () {
          when(() => mockPurchase(any())).thenAnswer(
            (_) async => const Left(Failure.payment('payment error')),
          );
        },
        build: () => createBloc(),
        seed: () => SubscriptionState.loaded(
          status: tStatus,
          offerings: tOffering,
          annualPackage: tAnnualPackage,
          monthlyPackage: tMonthlyPackage,
          discountAnnualPackage: tDiscountPackage,
        ),
        // act
        act: (bloc) =>
            bloc.add(SubscriptionEvent.purchaseRequested(tAnnualPackage)),
        // assert
        expect: () => [
          isA<SubscriptionStateLoaded>().having(
            (s) => s.isPurchasing,
            'isPurchasing',
            true,
          ),
          isA<SubscriptionStateFailure>().having(
            (s) => s.failure.message,
            'message',
            'payment error',
          ),
        ],
      );

      blocTest<SubscriptionBloc, SubscriptionState>(
        'purchaseRequested_success_logsAnalyticsWithSource',
        // arrange
        setUp: () {
          when(
            () => mockPurchase(any()),
          ).thenAnswer((_) async => Right(tSubscribedStatus));
        },
        build: () => createBloc(),
        seed: () => SubscriptionState.loaded(
          status: tStatus,
          offerings: tOffering,
          annualPackage: tAnnualPackage,
          monthlyPackage: tMonthlyPackage,
          discountAnnualPackage: tDiscountPackage,
          paywallSource: PaywallSource.onboarding,
        ),
        // act
        act: (bloc) =>
            bloc.add(SubscriptionEvent.purchaseRequested(tAnnualPackage)),
        // assert
        verify: (_) {
          verify(
            () => mockAnalytics.logPurchaseSuccess(
              any(
                that: isA<AnalyticsPurchaseParams>().having(
                  (p) => p.source,
                  'source',
                  PaywallSource.onboarding,
                ),
              ),
            ),
          ).called(1);
          verify(() => mockOnboardingTracker.logConversion()).called(1);
        },
      );
    });

    group('restoreRequested', () {
      blocTest<SubscriptionBloc, SubscriptionState>(
        'restoreRequested_success_emitsLoadingThenLoaded',
        // arrange
        setUp: () {
          when(
            () => mockRestore(any()),
          ).thenAnswer((_) async => Right(tSubscribedStatus));
        },
        build: () => createBloc(),
        // act
        act: (bloc) => bloc.add(const SubscriptionEvent.restoreRequested()),
        // assert
        expect: () => [
          isA<SubscriptionStateLoading>(),
          isA<SubscriptionStateInitial>().having(
            (s) => s.status.isSubscribed,
            'subscribed',
            true,
          ),
          isA<SubscriptionStateLoaded>().having(
            (s) => s.status.isSubscribed,
            'subscribed',
            true,
          ),
        ],
        verify: (_) {
          verify(
            () =>
                mockAnalytics.logRestoreRequested(source: any(named: 'source')),
          ).called(1);
        },
      );

      blocTest<SubscriptionBloc, SubscriptionState>(
        'restoreRequested_failure_emitsFailure',
        // arrange
        setUp: () {
          when(() => mockRestore(any())).thenAnswer(
            (_) async => const Left(Failure.server('restore error')),
          );
        },
        build: () => createBloc(),
        // act
        act: (bloc) => bloc.add(const SubscriptionEvent.restoreRequested()),
        // assert
        expect: () => [
          isA<SubscriptionStateLoading>(),
          isA<SubscriptionStateFailure>().having(
            (s) => s.failure.message,
            'message',
            'restore error',
          ),
        ],
        verify: (_) {
          verify(
            () =>
                mockAnalytics.logRestoreRequested(source: any(named: 'source')),
          ).called(1);
        },
      );
    });

    group('statusUpdated', () {
      blocTest<SubscriptionBloc, SubscriptionState>(
        'statusUpdated_entitlementChanged_triggersOfferingsRefresh',
        // arrange
        build: () => createBloc(),
        // act
        act: (bloc) =>
            bloc.add(SubscriptionEvent.statusUpdated(tSubscribedStatus)),
        // assert
        expect: () => [
          isA<SubscriptionState>().having(
            (s) => s.status.isSubscribed,
            'subscribed',
            true,
          ),
          isA<SubscriptionStateLoaded>(),
        ],
        verify: (_) {
          verify(() => mockGetOfferings.call(any())).called(1);
        },
      );

      blocTest<SubscriptionBloc, SubscriptionState>(
        'statusUpdated_entitlementNotChanged_noOfferingsRefresh',
        // arrange
        build: () => createBloc(),
        seed: () => SubscriptionState.initial(status: tSubscribedStatus),
        // act
        act: (bloc) => bloc.add(
          SubscriptionEvent.statusUpdated(
            tSubscribedStatus.copyWith(expirationDate: DateTime.now()),
          ),
        ),
        // assert
        expect: () => [isA<SubscriptionStateInitial>()],
        verify: (_) {
          verifyNever(() => mockGetOfferings.call(any()));
        },
      );
    });

    group('appResumed', () {
      blocTest<SubscriptionBloc, SubscriptionState>(
        'appResumed_refreshesEverything',
        // arrange
        build: () => createBloc(),
        // act
        act: (bloc) => bloc.add(const SubscriptionEvent.appResumed()),
        // assert
        expect: () => [isA<SubscriptionStateLoaded>()],
        verify: (_) {
          verify(() => mockRefreshStatus.call(any())).called(1);
          verify(() => mockGetOfferings.call(any())).called(1);
        },
      );
    });

    group('refreshRequested', () {
      blocTest<SubscriptionBloc, SubscriptionState>(
        'refreshRequested_callsRefreshStatus',
        // arrange
        build: () => createBloc(),
        // act
        act: (bloc) => bloc.add(const SubscriptionEvent.refreshRequested()),
        // assert
        verify: (_) {
          verify(() => mockRefreshStatus.call(any())).called(1);
        },
      );
    });

    group('planToggled', () {
      blocTest<SubscriptionBloc, SubscriptionState>(
        'planToggled_updatesSelectionState',
        // arrange
        build: () => createBloc(),
        seed: () => SubscriptionState.loaded(
          status: tStatus,
          offerings: tOffering,
          annualPackage: tAnnualPackage,
          monthlyPackage: tMonthlyPackage,
          discountAnnualPackage: tDiscountPackage,
        ),
        // act
        act: (bloc) =>
            bloc.add(const SubscriptionEvent.planToggled(isAnnual: false)),
        // assert
        expect: () => [
          isA<SubscriptionStateLoaded>().having(
            (s) => s.isAnnualSelection,
            'isAnnual',
            false,
          ),
        ],
      );
    });

    group('purchaseUICompleted', () {
      blocTest<SubscriptionBloc, SubscriptionState>(
        'purchaseUICompleted_success_startsSafeguardAndResetsState',
        // arrange
        build: () => createBloc(),
        seed: () => SubscriptionState.loaded(
          status: tSubscribedStatus,
          offerings: tOffering,
          isPurchasing: true,
          isLocalSuccessOverride: true,
          annualPackage: tAnnualPackage,
          monthlyPackage: tMonthlyPackage,
          discountAnnualPackage: tDiscountPackage,
        ),
        // act
        act: (bloc) => bloc.add(const SubscriptionEvent.purchaseUICompleted()),
        // assert
        expect: () => [
          isA<SubscriptionStateLoaded>()
              .having((s) => s.isPurchasing, 'isPurchasing', false)
              .having((s) => s.isLocalSuccessOverride, 'localSuccess', false),
        ],
        verify: (bloc) {
          verify(() => mockGetOfferings.call(any())).called(1);
        },
      );
    });

    group('resetPurchaseState', () {
      blocTest<SubscriptionBloc, SubscriptionState>(
        'resetPurchaseState_resetsLoadedState',
        // arrange
        build: () => createBloc(),
        seed: () => SubscriptionState.loaded(
          status: tSubscribedStatus,
          offerings: tOffering,
          isPurchasing: true,
          isLocalSuccessOverride: true,
          annualPackage: tAnnualPackage,
          monthlyPackage: tMonthlyPackage,
          discountAnnualPackage: tDiscountPackage,
        ),
        // act
        act: (bloc) => bloc.add(const SubscriptionEvent.resetPurchaseState()),
        // assert
        expect: () => [
          isA<SubscriptionStateLoaded>()
              .having((s) => s.isPurchasing, 'isPurchasing', false)
              .having((s) => s.isLocalSuccessOverride, 'localSuccess', false),
        ],
      );
    });

    group('Expiration Timer', () {
      test('statusUpdated_withFutureExpiration_schedulesRefreshAndTrigger', () {
        fakeAsync((async) {
          // arrange
          final bloc = createBloc();
          final now = DateTime.now().toUtc();
          final expirationDate = now.add(const Duration(milliseconds: 500));
          final tExpiringStatus = tStatus.copyWith(
            isSubscribed: true,
            expirationDate: expirationDate,
          );

          // act
          bloc.add(SubscriptionEvent.statusUpdated(tExpiringStatus));
          async.flushMicrotasks();

          async.elapse(const Duration(milliseconds: 1000));

          async.elapse(const Duration(milliseconds: 4000));

          // assert
          verify(() => mockRefreshStatus.call(any())).called(3);

          verify(() => mockGetOfferings.call(any())).called(2);

          bloc.close();
        });
      });
    });

    group('Background Sync Safeguard', () {
      test('safeguard_firesAndTriggersSync_whenFirestoreStale', () {
        fakeAsync((async) {
          // arrange
          final firestoreStream = StreamController<bool>();
          final bloc = SubscriptionBloc(
            mockWatchStatus,
            mockRefreshStatus,
            mockSyncIdentity,
            mockPurchase,
            mockRestore,
            mockGetOfferings,
            mockAuthBloc,
            mockSyncSubscription,
            firestoreStream.stream,
            mockAnalytics,
            mockOnboardingTracker,
          );

          when(
            () => mockPurchase.call(any()),
          ).thenAnswer((_) async => Right(tSubscribedStatus));

          bloc.add(SubscriptionStatusUpdated(tSubscribedStatus));
          async.flushMicrotasks();
          bloc.add(SubscriptionEvent.purchaseRequested(tAnnualPackage));
          async.flushMicrotasks();

          // act
          bloc.add(const SubscriptionEvent.purchaseUICompleted());
          async.flushMicrotasks();

          firestoreStream.add(false);
          async.flushMicrotasks();

          async.elapse(const Duration(seconds: 11));
          async.flushMicrotasks();

          // assert
          verify(() => mockSyncSubscription.call(any())).called(1);

          bloc.close();
          firestoreStream.close();
          async.flushMicrotasks();
        });
      });

      test('safeguard_doesNothing_whenFirestoreUpdated', () {
        fakeAsync((async) {
          // arrange
          final firestoreStream = StreamController<bool>();
          final bloc = SubscriptionBloc(
            mockWatchStatus,
            mockRefreshStatus,
            mockSyncIdentity,
            mockPurchase,
            mockRestore,
            mockGetOfferings,
            mockAuthBloc,
            mockSyncSubscription,
            firestoreStream.stream,
            mockAnalytics,
            mockOnboardingTracker,
          );

          when(
            () => mockPurchase(any()),
          ).thenAnswer((_) async => Right(tSubscribedStatus));

          bloc.add(SubscriptionStatusUpdated(tSubscribedStatus));
          async.flushMicrotasks();
          bloc.add(SubscriptionEvent.purchaseRequested(tAnnualPackage));
          async.flushMicrotasks();

          // act
          bloc.add(const SubscriptionEvent.purchaseUICompleted());
          async.flushMicrotasks();

          firestoreStream.add(true);
          async.flushMicrotasks();

          async.elapse(const Duration(seconds: 11));
          async.flushMicrotasks();

          // assert
          verifyNever(() => mockSyncSubscription.call(any()));

          bloc.close();
          firestoreStream.close();
          async.flushMicrotasks();
        });
      });
    });
  });

  group('gift', () {
    const tSource = PaywallSource.settings;

    blocTest<SubscriptionBloc, SubscriptionState>(
      'giftViewed_logsAnalytics',
      // arrange
      build: () => createBloc(),
      // act
      act: (bloc) =>
          bloc.add(const SubscriptionEvent.giftViewed(source: tSource)),
      // assert
      verify: (_) {
        verify(() => mockAnalytics.logGiftViewed(source: tSource)).called(1);
      },
    );

    blocTest<SubscriptionBloc, SubscriptionState>(
      'giftClaimed_emitsNavigationFlagThenResetsAndLogsAnalytics',
      // arrange
      build: () => createBloc(),
      seed: () => SubscriptionState.loaded(
        status: tStatus,
        offerings: tOffering,
        annualPackage: tAnnualPackage,
        monthlyPackage: tMonthlyPackage,
        discountAnnualPackage: tDiscountPackage,
      ),
      // act
      act: (bloc) =>
          bloc.add(const SubscriptionEvent.giftClaimed(source: tSource)),
      // assert
      expect: () => [
        isA<SubscriptionStateLoaded>().having(
          (s) => s.shouldNavigateToDiscountedPaywall,
          'shouldNavigate',
          true,
        ),
        isA<SubscriptionStateLoaded>().having(
          (s) => s.shouldNavigateToDiscountedPaywall,
          'shouldNavigate',
          false,
        ),
      ],
      verify: (_) {
        verify(() => mockAnalytics.logGiftClaimed(source: tSource)).called(1);
      },
    );

    blocTest<SubscriptionBloc, SubscriptionState>(
      'giftDismissed_logsAnalytics',
      // arrange
      build: () => createBloc(),
      // act
      act: (bloc) =>
          bloc.add(const SubscriptionEvent.giftDismissed(source: tSource)),
      // assert
      verify: (_) {
        verify(() => mockAnalytics.logGiftDismissed(source: tSource)).called(1);
      },
    );
  });
}
