import 'package:bizzie/features/onboarding/data/dtos/daily_brands_dto.dart';
import 'package:bizzie/features/onboarding/data/dtos/user_dto.dart';
import 'package:bizzie/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/domain/models/user_model.dart';
import 'package:bizzie/features/onboarding/data/datasources/onboarding_remote_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:mocktail/mocktail.dart';

class MockOnboardingRemoteDataSource extends Mock
    implements IOnboardingRemoteDataSource {}

class FakeUserDto extends Fake implements UserDto {}

void main() {
  late OnboardingRepositoryImpl repository;
  late MockOnboardingRemoteDataSource mockRemoteDataSource;

  setUpAll(() {
    registerFallbackValue(FakeUserDto());
  });

  setUp(() {
    mockRemoteDataSource = MockOnboardingRemoteDataSource();
    repository = OnboardingRepositoryImpl(mockRemoteDataSource);
  });

  group('OnboardingRepositoryImpl', () {
    const tSector = Sector.informationTechnology;

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

    test('getDailyBrands_remoteReturnsNull_returnsMockData', () async {
      // Arrange
      when(
        () => mockRemoteDataSource.fetchDailyBrands(),
      ).thenAnswer((_) async => null);

      // Act
      final result = await repository.getDailyBrands(tSector);

      // Assert
      // Assert
      expect(result.isRight(), true);
      result.fold((_) => fail('Should be Right'), (r) {
        final (global, _) = r;
        expect(global.isNotEmpty, true);
      });
      verify(() => mockRemoteDataSource.fetchDailyBrands()).called(1);
    });

    test('getDailyBrands_remoteReturnsDto_mapsCorrectly', () async {
      // Arrange
      final tDto = DailyBrandsDto(
        date: DateTime(2025, 1, 1),
        sectors: [
          DailyBrandSectorDto(
            name: 'All Sectors',
            products: [
              DailyBrandProductDto(
                name: 'Prod1',
                company: 'Comp1',
                ticker: 'TKR1',
                description: 'Desc1',
              ),
            ],
          ),
        ],
      );
      when(
        () => mockRemoteDataSource.fetchDailyBrands(),
      ).thenAnswer((_) async => tDto);

      // Act
      final result = await repository.getDailyBrands(tSector);

      // Assert
      // Assert
      expect(result.isRight(), true);
      result.fold((_) => fail('Should be Right'), (r) {
        final (global, _) = r;
        expect(global.length, 1);
        expect(global.first.name, 'Prod1');
      });
    });

    test('saveUserProfile_validData_callsSaveUserProfile', () async {
      // Arrange
      final tUser = UserModel(
        uid: 'uid_123',
        name: 'John',
        favoriteSector: 'Technology',
        watchlist: [const Company(ticker: 'AAPL', name: 'Apple')],
        investingExperience: InvestingExperience.beginner,
        createdAt: DateTime.now(),
        isSubscribed: false,
        fcmTokens: {},
      );

      when(
        () => mockRemoteDataSource.saveUserProfile(any(), any()),
      ).thenAnswer((_) async {});

      // Act
      await repository.saveUserProfile(tUser);

      // Assert
      verify(
        () => mockRemoteDataSource.saveUserProfile(any(), any()),
      ).called(1);
    });

    test('getDailyBrands_remoteThrows_throwsException', () async {
      // Arrange
      when(
        () => mockRemoteDataSource.fetchDailyBrands(),
      ).thenThrow(Exception('Firestore Error'));

      // Act
      final result = await repository.getDailyBrands(tSector);

      // Assert
      expect(result.isLeft(), true);
      result.fold(
        (l) => expect(l, isA<ServerFailure>()),
        (_) => fail('Should be Left'),
      );
    });

    test('saveUserProfile_saveThrows_throwsException', () async {
      // Arrange
      final tUser = UserModel(
        uid: 'uid_123',
        name: 'John',
        favoriteSector: 'Technology',
        watchlist: [],
        investingExperience: InvestingExperience.beginner,
        createdAt: DateTime.now(),
        isSubscribed: false,
        fcmTokens: {},
      );

      when(
        () => mockRemoteDataSource.saveUserProfile(any(), any()),
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
  });
}
