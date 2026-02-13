import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/interfaces/i_firebase_functions_service.dart';
import 'package:bizzie/features/subscription/data/dtos/subscription_offering_dto.dart';
import 'package:bizzie/features/subscription/data/dtos/subscription_status_dto.dart';
import 'package:bizzie/features/subscription/data/repositories/subscription_repository_impl.dart';
import 'package:bizzie/features/subscription/data/interfaces/i_subscription_remote_data_source.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_offering.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_status.dart';
import 'package:bizzie/features/subscription/domain/enums/subscription_package_type.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSubscriptionRemoteDataSource extends Mock
    implements ISubscriptionRemoteDataSource {}

class MockFirebaseFunctionsService extends Mock
    implements IFirebaseFunctionsService {}

class MockSubscriptionPackage extends Mock implements SubscriptionPackage {}

void main() {
  late SubscriptionRepositoryImpl repository;
  late MockSubscriptionRemoteDataSource mockRemoteDataSource;
  late MockFirebaseFunctionsService mockFunctionsService;

  setUp(() {
    mockRemoteDataSource = MockSubscriptionRemoteDataSource();
    mockFunctionsService = MockFirebaseFunctionsService();
    repository = SubscriptionRepositoryImpl(
      mockRemoteDataSource,
      mockFunctionsService,
    );

    final tFakePackage = SubscriptionPackage(
      id: 'id',
      identifier: 'identifier',
      productId: 'io.getbizzie.bizzieapp.plus.annual.full.dev',
      packageType: SubscriptionPackageType.annual,
      title: 'title',
      description: 'description',
      priceString: '\$0.00',
      price: 0.0,
      currencyCode: 'USD',
    );
    registerFallbackValue(tFakePackage);
  });

  group('SubscriptionRepositoryImpl', () {
    const tUserId = 'user_123';
    const tStatusDto = SubscriptionStatusDto(
      isSubscribed: true,
      activeEntitlements: {'plus'},
      activeProductIds: {'productId'},
    );
    final tStatus = tStatusDto.toDomain();

    group('initialize', () {
      test('initialize_callsRemoteDataSource', () async {
        // arrange
        when(() => mockRemoteDataSource.initialize()).thenAnswer((_) async {});

        // act
        await repository.initialize();

        // assert
        verify(() => mockRemoteDataSource.initialize()).called(1);
      });
    });

    group('watchSubscriptionStatus', () {
      test('watchSubscriptionStatus_delegatesToRemoteDataSource', () {
        // arrange
        when(
          () => mockRemoteDataSource.watchSubscriptionStatus(),
        ).thenAnswer((_) => Stream.value(tStatusDto));

        // act
        final result = repository.watchSubscriptionStatus(tUserId);

        // assert
        expect(
          result,
          emits(
            isA<SubscriptionStatus>().having(
              (s) => s.isSubscribed,
              'isSubscribed',
              true,
            ),
          ),
        );
        verify(() => mockRemoteDataSource.watchSubscriptionStatus()).called(1);
      });
    });

    group('getSubscriptionStatus', () {
      test('getSubscriptionStatus_success_returnsSubscriptionStatus', () async {
        // arrange
        when(
          () => mockRemoteDataSource.getSubscriptionStatus(),
        ).thenAnswer((_) async => tStatusDto);

        // act
        final result = await repository.getSubscriptionStatus();

        // assert
        expect(result, Right(tStatus));
        verify(() => mockRemoteDataSource.getSubscriptionStatus()).called(1);
      });

      test('getSubscriptionStatus_error_returnsFailure', () async {
        // arrange
        final tException = Exception('error');
        when(
          () => mockRemoteDataSource.getSubscriptionStatus(),
        ).thenThrow(tException);

        // act
        final result = await repository.getSubscriptionStatus();

        // assert
        expect(result, isA<Left<Failure, SubscriptionStatus>>());
        verify(() => mockRemoteDataSource.getSubscriptionStatus()).called(1);
      });
    });

    group('getOfferings', () {
      const tOfferingDto = SubscriptionOfferingDto(
        identifier: 'default',
        serverDescription: 'Default offering',
        availablePackages: [],
      );
      final tOffering = tOfferingDto.toDomain();

      test('getOfferings_success_returnsSubscriptionOffering', () async {
        // arrange
        when(
          () => mockRemoteDataSource.checkTrialEligibility(any()),
        ).thenAnswer((_) async => {});
        when(
          () => mockRemoteDataSource.getOfferings(),
        ).thenAnswer((_) async => tOfferingDto);

        // act
        final result = await repository.getOfferings();

        // assert
        expect(result, Right(tOffering));
      });

      test('getOfferings_error_returnsFailure', () async {
        // arrange
        when(() => mockRemoteDataSource.getOfferings()).thenThrow(Exception());

        // act
        final result = await repository.getOfferings();

        // assert
        expect(result, isA<Left<Failure, SubscriptionOffering>>());
      });
    });

    group('purchasePackage', () {
      late MockSubscriptionPackage tPackage;

      setUp(() {
        tPackage = MockSubscriptionPackage();
        when(() => tPackage.identifier).thenReturn('annual_plus');
        when(() => tPackage.productId).thenReturn('productId');
      });

      test('purchasePackage_success_returnsSubscriptionStatus', () async {
        // arrange
        when(
          () => mockRemoteDataSource.purchasePackage(any()),
        ).thenAnswer((_) async => tStatusDto);

        // act
        final result = await repository.purchasePackage(tPackage);

        // assert
        expect(result, Right(tStatus));
      });

      test('purchasePackage_error_returnsFailure', () async {
        // arrange
        when(
          () => mockRemoteDataSource.purchasePackage(any()),
        ).thenThrow(Exception());

        // act
        final result = await repository.purchasePackage(tPackage);

        // assert
        expect(result, isA<Left<Failure, SubscriptionStatus>>());
      });
    });

    group('restorePurchases', () {
      test('restorePurchases_success_returnsSubscriptionStatus', () async {
        // arrange
        when(
          () => mockRemoteDataSource.restorePurchases(),
        ).thenAnswer((_) async => tStatusDto);

        // act
        final result = await repository.restorePurchases();

        // assert
        expect(result, Right(tStatus));
      });

      test('restorePurchases_error_returnsFailure', () async {
        // arrange
        when(
          () => mockRemoteDataSource.restorePurchases(),
        ).thenThrow(Exception());

        // act
        final result = await repository.restorePurchases();

        // assert
        expect(result, isA<Left<Failure, SubscriptionStatus>>());
      });
    });

    group('syncIdentity', () {
      test('syncIdentity_uidPresent_callsLogIn', () async {
        // arrange
        when(() => mockRemoteDataSource.logIn(any())).thenAnswer((_) async {});

        // act
        final result = await repository.syncIdentity(tUserId);

        // assert
        expect(result, const Right(null));
        verify(() => mockRemoteDataSource.logIn(tUserId)).called(1);
        verifyNever(() => mockRemoteDataSource.logOut());
      });

      test('syncIdentity_uidNull_callsLogOut', () async {
        // arrange
        when(() => mockRemoteDataSource.logOut()).thenAnswer((_) async {});

        // act
        final result = await repository.syncIdentity(null);

        // assert
        expect(result, const Right(null));
        verify(() => mockRemoteDataSource.logOut()).called(1);
        verifyNever(() => mockRemoteDataSource.logIn(any()));
      });
    });

    group('logIn', () {
      test('logIn_success_returnsRightNull', () async {
        // arrange
        when(() => mockRemoteDataSource.logIn(any())).thenAnswer((_) async {});

        // act
        final result = await repository.logIn(tUserId);

        // assert
        expect(result, const Right(null));
      });

      test('logIn_error_returnsFailure', () async {
        // arrange
        when(() => mockRemoteDataSource.logIn(any())).thenThrow(Exception());

        // act
        final result = await repository.logIn(tUserId);

        // assert
        expect(result, isA<Left<Failure, void>>());
      });
    });

    group('logOut', () {
      test('logOut_success_returnsRightNull', () async {
        // arrange
        when(() => mockRemoteDataSource.logOut()).thenAnswer((_) async {});

        // act
        final result = await repository.logOut();

        // assert
        expect(result, const Right(null));
      });

      test('logOut_error_returnsFailure', () async {
        // arrange
        when(() => mockRemoteDataSource.logOut()).thenThrow(Exception());

        // act
        final result = await repository.logOut();

        // assert
        expect(result, isA<Left<Failure, void>>());
      });
    });
  });
}
