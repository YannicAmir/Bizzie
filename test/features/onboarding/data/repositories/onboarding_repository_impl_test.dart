import 'package:bizzie/core/data/dtos/onboarding_skip_config.dart';
import 'package:bizzie/features/onboarding/data/dtos/historical_price_dto.dart';
import 'package:bizzie/features/onboarding/data/dtos/onboarding_profile_update_dto.dart';
import 'package:bizzie/features/onboarding/domain/models/historical_price.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_profile_update.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_skip_defaults.dart';
import 'package:bizzie/core/data/dtos/user_dto.dart';
import 'package:bizzie/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:bizzie/core/domain/models/company.dart';

import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/core/enums/investing_experience.dart';
import 'package:bizzie/core/domain/models/user_model.dart';
import 'package:bizzie/features/onboarding/data/interfaces/i_onboarding_remote_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:mocktail/mocktail.dart';

class MockOnboardingRemoteDataSource extends Mock
    implements IOnboardingRemoteDataSource {}

class FakeUserDto extends Fake implements UserDto {}

class FakeOnboardingProfileUpdateDto extends Fake
    implements OnboardingProfileUpdateDto {}

const tSkipConfig = OnboardingSkipConfig(
  defaultWatchlist: [
    OnboardingSkipWatchlistItem(ticker: 'AAPL', name: 'Apple'),
  ],
  defaultSector: 'Information Technology',
  initialCompanyTicker: 'AAPL',
);
const tProfileUpdate = OnboardingProfileUpdate(
  uid: 'uid_123',
  name: 'Jane',
  investingExperience: InvestingExperience.expert,
);

void main() {
  late OnboardingRepositoryImpl repository;
  late MockOnboardingRemoteDataSource mockRemoteDataSource;

  setUpAll(() {
    registerFallbackValue(FakeUserDto());
    registerFallbackValue(FakeOnboardingProfileUpdateDto());
  });

  setUp(() {
    mockRemoteDataSource = MockOnboardingRemoteDataSource();
    repository = OnboardingRepositoryImpl(mockRemoteDataSource);
  });

  group('OnboardingRepositoryImpl', () {
    test('getSectors_success_returnsSectorList', () async {
      // Arrange
      when(
        () => mockRemoteDataSource.getStockMarketSectors(),
      ).thenReturn(['Healthcare', 'Information Technology']);

      // Act
      final result = await repository.getSectors();

      // Assert
      expect(result.isRight(), true);
      result.fold((_) => fail('Should be Right'), (sectors) {
        expect(sectors.length, 2);
        expect(sectors.last, Sector.informationTechnology);
      });
    });

    test('getSp500History_success_returnsMappedHistory', () async {
      // arrange
      when(() => mockRemoteDataSource.getSp500History()).thenReturn(const [
        HistoricalPriceDto(
          symbol: '^GSPC',
          date: '2025-12-29',
          price: 6905.73,
          volume: 3541750000,
        ),
      ]);

      // act
      final result = await repository.getSp500History();

      // assert
      expect(result.getOrElse(() => fail('Should be Right')), const [
        HistoricalPrice(
          symbol: '^GSPC',
          date: '2025-12-29',
          price: 6905.73,
          volume: 3541750000,
        ),
      ]);
    });

    test('getSp500History_datasourceThrows_returnsLeftServerFailure', () async {
      // arrange
      when(
        () => mockRemoteDataSource.getSp500History(),
      ).thenThrow(Exception('Parse Failed'));

      // act
      final result = await repository.getSp500History();

      // assert
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Should be Left'),
      );
    });

    test('getSkipDefaults_success_returnsMappedDefaults', () async {
      // arrange
      when(
        () => mockRemoteDataSource.getOnboardingSkipConfig(),
      ).thenReturn(tSkipConfig);

      // act
      final result = await repository.getSkipDefaults();

      // assert
      expect(
        result.getOrElse(() => fail('Should be Right')),
        const OnboardingSkipDefaults(
          defaultWatchlist: [Company(ticker: 'AAPL', name: 'Apple')],
          defaultSector: Sector.informationTechnology,
          initialCompanyTicker: 'AAPL',
        ),
      );
    });

    test('getSkipDefaults_unknownSector_returnsNullDefaultSector', () async {
      // arrange
      when(
        () => mockRemoteDataSource.getOnboardingSkipConfig(),
      ).thenReturn(tSkipConfig.copyWith(defaultSector: 'unknown'));

      // act
      final result = await repository.getSkipDefaults();

      // assert
      expect(
        result.getOrElse(() => fail('Should be Right')).defaultSector,
        isNull,
      );
    });

    test('getSkipDefaults_datasourceThrows_returnsLeftServerFailure', () async {
      // arrange
      when(
        () => mockRemoteDataSource.getOnboardingSkipConfig(),
      ).thenThrow(Exception('Config Failed'));

      // act
      final result = await repository.getSkipDefaults();

      // assert
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Should be Left'),
      );
    });

    group('userProfileExists', () {
      test('userProfileExists_profileFound_returnsRightTrue', () async {
        // arrange
        when(
          () => mockRemoteDataSource.userProfileExists('uid_123'),
        ).thenAnswer((_) async => true);

        // act
        final result = await repository.userProfileExists('uid_123');

        // assert
        expect(result, const Right(true));
      });

      test('userProfileExists_noProfile_returnsRightFalse', () async {
        // arrange
        when(
          () => mockRemoteDataSource.userProfileExists('uid_123'),
        ).thenAnswer((_) async => false);

        // act
        final result = await repository.userProfileExists('uid_123');

        // assert
        expect(result, const Right(false));
      });

      test(
        'userProfileExists_dataSourceThrows_returnsLeftServerFailure',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.userProfileExists(any()),
          ).thenThrow(Exception('offline'));

          // act
          final result = await repository.userProfileExists('uid_123');

          // assert
          expect(result, const Left(Failure.server('Exception: offline')));
        },
      );
    });

    test('saveUserProfile_validData_callsSaveUserProfile', () async {
      // Arrange
      final tUser = UserModel(
        uid: 'uid_123',
        name: 'John',
        favoriteSector: 'technology',
        watchlist: [const Company(ticker: 'AAPL', name: 'Apple')],
        investingExperience: InvestingExperience.beginner,
        createdAt: DateTime.now(),
        isSubscribed: false,
        fcmTokens: {},
      );

      when(
        () => mockRemoteDataSource.saveUserProfile(
          any(),
          any(),
          awaitServerAck: any(named: 'awaitServerAck'),
        ),
      ).thenAnswer((_) async {});

      // Act
      await repository.saveUserProfile(tUser);

      // Assert
      verify(
        () => mockRemoteDataSource.saveUserProfile(
          any(),
          any(),
          awaitServerAck: any(named: 'awaitServerAck'),
        ),
      ).called(1);
    });

    test(
      'saveUserProfile_defaultAwaitServerAck_forwardsTrueToDataSource',
      () async {
        // arrange
        final tUser = UserModel(
          uid: 'uid_123',
          name: 'John',
          favoriteSector: 'technology',
          watchlist: [],
          investingExperience: InvestingExperience.beginner,
          createdAt: DateTime.now(),
          isSubscribed: false,
          fcmTokens: {},
        );
        when(
          () => mockRemoteDataSource.saveUserProfile(
            any(),
            any(),
            awaitServerAck: any(named: 'awaitServerAck'),
          ),
        ).thenAnswer((_) async {});

        // act
        await repository.saveUserProfile(tUser);

        // assert
        verify(
          () => mockRemoteDataSource.saveUserProfile(
            any(),
            any(),
            awaitServerAck: true,
          ),
        ).called(1);
      },
    );

    test(
      'saveUserProfile_awaitServerAckFalse_forwardsFalseToDataSource',
      () async {
        // arrange
        final tUser = UserModel(
          uid: 'uid_123',
          name: 'John',
          favoriteSector: 'technology',
          watchlist: [],
          investingExperience: InvestingExperience.beginner,
          createdAt: DateTime.now(),
          isSubscribed: false,
          fcmTokens: {},
        );
        when(
          () => mockRemoteDataSource.saveUserProfile(
            any(),
            any(),
            awaitServerAck: any(named: 'awaitServerAck'),
          ),
        ).thenAnswer((_) async {});

        // act
        final result = await repository.saveUserProfile(
          tUser,
          awaitServerAck: false,
        );

        // assert
        expect(result.isRight(), isTrue);
        verify(
          () => mockRemoteDataSource.saveUserProfile(
            any(),
            any(),
            awaitServerAck: false,
          ),
        ).called(1);
      },
    );

    test('saveUserProfile_saveThrows_throwsException', () async {
      // Arrange
      final tUser = UserModel(
        uid: 'uid_123',
        name: 'John',
        favoriteSector: 'technology',
        watchlist: [],
        investingExperience: InvestingExperience.beginner,
        createdAt: DateTime.now(),
        isSubscribed: false,
        fcmTokens: {},
      );

      when(
        () => mockRemoteDataSource.saveUserProfile(
          any(),
          any(),
          awaitServerAck: any(named: 'awaitServerAck'),
        ),
      ).thenThrow(Exception('Save Failed'));

      // Act & Assert
      // Act
      final result = await repository.saveUserProfile(tUser);

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (l) => expect(l, isA<ServerFailure>()),
        (_) => fail('Should be Left'),
      );
    });

    test(
      'updateOnboardingProfile_validUpdate_forwardsOwnedFieldsDtoToDataSource',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.updateOnboardingProfile(
            any(),
            any(),
            awaitServerAck: any(named: 'awaitServerAck'),
          ),
        ).thenAnswer((_) async {});

        // act
        final result = await repository.updateOnboardingProfile(
          tProfileUpdate,
          awaitServerAck: false,
        );

        // assert
        expect(result, const Right(null));
        verify(
          () => mockRemoteDataSource.updateOnboardingProfile(
            'uid_123',
            const OnboardingProfileUpdateDto(
              name: 'Jane',
              investingExperience: 'expert',
            ),
            awaitServerAck: false,
          ),
        ).called(1);
        verifyNever(
          () => mockRemoteDataSource.saveUserProfile(
            any(),
            any(),
            awaitServerAck: any(named: 'awaitServerAck'),
          ),
        );
      },
    );

    test(
      'updateOnboardingProfile_dataSourceThrows_returnsLeftServerFailure',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.updateOnboardingProfile(
            any(),
            any(),
            awaitServerAck: any(named: 'awaitServerAck'),
          ),
        ).thenThrow(Exception('Update Failed'));

        // act
        final result = await repository.updateOnboardingProfile(tProfileUpdate);

        // assert
        expect(result, const Left(Failure.server('Exception: Update Failed')));
      },
    );
  });
}
