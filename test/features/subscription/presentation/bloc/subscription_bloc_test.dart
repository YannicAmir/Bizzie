import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_event.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_state.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_offering.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:bizzie/features/subscription/domain/usecases/get_offerings_use_case.dart';
import 'package:bizzie/features/subscription/domain/usecases/purchase_subscription_use_case.dart';
import 'package:bizzie/features/subscription/domain/usecases/restore_purchases_use_case.dart';
import 'package:bizzie/features/subscription/domain/usecases/sync_identity_use_case.dart';
import 'package:bizzie/features/subscription/domain/usecases/sync_subscription_use_case.dart';
import 'package:bizzie/features/subscription/domain/usecases/watch_subscription_status_use_case.dart';
import 'package:bizzie/features/subscription/domain/usecases/refresh_subscription_status_use_case.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_event.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_state.dart';
import 'package:bizzie/features/subscription/domain/enums/subscription_package_type.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

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

void main() {
  late MockWatchSubscriptionStatusUseCase mockWatchStatus;
  late MockRefreshSubscriptionStatusUseCase mockRefreshStatus;
  late MockSyncIdentityUseCase mockSyncIdentity;
  late MockPurchaseSubscriptionUseCase mockPurchase;
  late MockRestorePurchasesUseCase mockRestore;
  late MockGetOfferingsUseCase mockGetOfferings;
  late MockSyncSubscriptionUseCase mockSyncSubscription;
  late MockAuthBloc mockAuthBloc;
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
    registerFallbackValue(NoParams());
    registerFallbackValue(tAnnualPackage);
    registerFallbackValue(SubscriptionStatus.initial());
    registerFallbackValue(const Failure.server(''));
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
    isSubscribedController = StreamController<bool>.broadcast();

    when(
      () => mockAuthBloc.state,
    ).thenReturn(const AuthState.unauthenticated());
    whenListen(
      mockAuthBloc,
      const Stream<AuthState>.empty(),
      initialState: const AuthState.unauthenticated(),
    );

    when(
      () => mockSyncIdentity(any()),
    ).thenAnswer((_) async => const Right(null));
    when(
      () => mockGetOfferings(any()),
    ).thenAnswer((_) async => Right(tOffering));
    when(() => mockWatchStatus(any())).thenAnswer((_) => const Stream.empty());
    when(
      () => mockRefreshStatus(any()),
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
    );
  }

  group('SubscriptionBloc', () {
    test('initial state should be SubscriptionState.initial', () {
      final bloc = createBloc();
      expect(bloc.state, isA<SubscriptionStateInitial>());
      bloc.close();
    });

    group('Initialization', () {
      blocTest<SubscriptionBloc, SubscriptionState>(
        'initialized_unauthenticated_emitsLoadedWithOfferings',
        build: () => createBloc(),
        act: (bloc) => bloc.add(const SubscriptionEvent.initialized()),
        expect: () => [
          isA<SubscriptionStateLoaded>().having(
            (s) => s.offerings,
            'offerings',
            tOffering,
          ),
        ],
        verify: (_) {
          verify(() => mockGetOfferings(any())).called(1);
          // Should not sync identity since unauthenticated
          verifyNever(() => mockSyncIdentity(any()));
        },
      );

      blocTest<SubscriptionBloc, SubscriptionState>(
        'initialized_authenticated_syncsAndLoads',
        setUp: () {
          const tUser = UserModel(id: 'user_123', email: 'test@example.com');
          when(
            () => mockAuthBloc.state,
          ).thenReturn(const AuthState.authenticated(tUser));
        },
        build: () {
          // Re-mock auth state for this specific build if needed, or just let setUp handle it
          return createBloc();
        },
        act: (bloc) => bloc.add(const SubscriptionEvent.initialized()),
        // Initialization adds both userIdentityChanged AND offeringsRequested
        // offeringsRequested is likely the one that finishes with Loaded
        expect: () => [isA<SubscriptionStateLoaded>()],
      );
    });

    group('Registration and Identity', () {
      const tUserId = 'user_123';

      blocTest<SubscriptionBloc, SubscriptionState>(
        'userIdentityChanged_authenticated_syncsAndWatches',
        setUp: () {
          when(
            () => mockWatchStatus(any()),
          ).thenAnswer((_) => Stream.fromIterable([tSubscribedStatus]));
        },
        build: () => createBloc(),
        act: (bloc) =>
            bloc.add(const SubscriptionEvent.userIdentityChanged(tUserId)),
        expect: () => [
          isA<SubscriptionState>().having(
            (s) => s.status.isSubscribed,
            'subscribed',
            true,
          ),
          isA<SubscriptionStateLoaded>().having(
            (s) => s.offerings,
            'offerings',
            tOffering,
          ),
        ],
        verify: (_) {
          verify(() => mockSyncIdentity(tUserId)).called(1);
          verify(() => mockWatchStatus(tUserId)).called(1);
        },
      );

      blocTest<SubscriptionBloc, SubscriptionState>(
        'userIdentityChanged_unauthenticated_resetsState',
        build: () => createBloc(),
        act: (bloc) =>
            bloc.add(const SubscriptionEvent.userIdentityChanged(null)),
        expect: () => [SubscriptionState.initial(status: tStatus)],
      );
    });

    group('Offerings', () {
      blocTest<SubscriptionBloc, SubscriptionState>(
        'offeringsRequested_success_emitsLoaded',
        build: () => createBloc(),
        act: (bloc) => bloc.add(const SubscriptionEvent.offeringsRequested()),
        expect: () => [
          isA<SubscriptionStateLoaded>().having(
            (s) => s.offerings,
            'offerings',
            tOffering,
          ),
        ],
      );

      blocTest<SubscriptionBloc, SubscriptionState>(
        'offeringsRequested_failure_emitsFailure',
        setUp: () {
          when(
            () => mockGetOfferings(any()),
          ).thenAnswer((_) async => const Left(Failure.server('error')));
        },
        build: () => createBloc(),
        act: (bloc) => bloc.add(const SubscriptionEvent.offeringsRequested()),
        expect: () => [
          isA<SubscriptionStateFailure>().having(
            (s) => s.failure.message,
            'message',
            'error',
          ),
        ],
      );
    });

    group('Purchase', () {
      blocTest<SubscriptionBloc, SubscriptionState>(
        'purchaseRequested_success_emitsLoadedWithSuccessOverride',
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
        act: (bloc) =>
            bloc.add(SubscriptionEvent.purchaseRequested(tAnnualPackage)),
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
        'purchaseRequested_failure_emitsFailure',
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
        act: (bloc) =>
            bloc.add(SubscriptionEvent.purchaseRequested(tAnnualPackage)),
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
    });

    group('Restore', () {
      blocTest<SubscriptionBloc, SubscriptionState>(
        'restoreRequested_success_emitsLoadingThenLoaded',
        setUp: () {
          when(
            () => mockRestore(any()),
          ).thenAnswer((_) async => Right(tSubscribedStatus));
        },
        build: () => createBloc(),
        act: (bloc) => bloc.add(const SubscriptionEvent.restoreRequested()),
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
      );
    });

    group('Status Updates', () {
      blocTest<SubscriptionBloc, SubscriptionState>(
        'statusUpdated_emitsCorrectStatus',
        build: () => createBloc(),
        act: (bloc) =>
            bloc.add(SubscriptionEvent.statusUpdated(tSubscribedStatus)),
        expect: () => [
          isA<SubscriptionState>().having(
            (s) => s.status.isSubscribed,
            'subscribed',
            true,
          ),
          // Side effect: Status change triggers offerings fetch
          isA<SubscriptionStateLoaded>().having(
            (s) => s.offerings,
            'offerings',
            tOffering,
          ),
        ],
      );
    });
    group('Expiration Timer', () {
      test('statusUpdated_withFutureExpiration_schedulesRefresh', () async {
        final bloc = createBloc();
        final now = DateTime.now();
        final expirationDate = now.add(const Duration(milliseconds: 100));
        final tExpiringStatus = tStatus.copyWith(
          isSubscribed: true,
          expirationDate: expirationDate,
        );

        // 1. Emit status with future expiration
        bloc.add(SubscriptionEvent.statusUpdated(tExpiringStatus));

        // 2. Initial state check
        await expectLater(
          bloc.stream,
          emits(
            isA<SubscriptionState>().having(
              (s) => s.status.isSubscribed,
              'subscribed',
              true,
            ),
          ),
        );

        // 3. Wait for timer (expiration + buffer of 2s in implementation)
        // Since the implementation adds 2 seconds buffer, we need to wait > 2.1s
        await Future.delayed(const Duration(milliseconds: 2200));

        // 4. Verify refresh was called
        verify(() => mockRefreshStatus(any())).called(1);
        verify(
          () => mockGetOfferings(any()),
        ).called(2); // 1 from status change, 1 from expiration refresh

        bloc.close();
      });
    });
  });
}
