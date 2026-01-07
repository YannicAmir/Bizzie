import 'package:bizzie/features/onboarding/data/dtos/daily_brands_dto.dart';
import 'package:bizzie/features/onboarding/data/dtos/user_dto.dart';
import 'package:bizzie/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/data/datasources/onboarding_remote_datasource.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockOnboardingRemoteDataSource extends Mock
    implements IOnboardingRemoteDataSource {}

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}

class FakeUserDto extends Fake implements UserDto {}

void main() {
  late OnboardingRepositoryImpl repository;
  late MockOnboardingRemoteDataSource mockRemoteDataSource;
  late MockFirebaseMessaging mockFirebaseMessaging;

  setUpAll(() {
    registerFallbackValue(FakeUserDto());
  });

  setUp(() {
    mockRemoteDataSource = MockOnboardingRemoteDataSource();
    mockFirebaseMessaging = MockFirebaseMessaging();
    repository = OnboardingRepositoryImpl(
      mockRemoteDataSource,
      mockFirebaseMessaging,
    );
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
      expect(result.length, 2);
      expect(result.last, Sector.informationTechnology);
    });

    test('getDailyBrands_remoteReturnsNull_returnsMockData', () async {
      // Arrange
      when(
        () => mockRemoteDataSource.fetchDailyBrands(),
      ).thenAnswer((_) async => null);

      // Act
      final result = await repository.getDailyBrands(tSector);

      // Assert
      expect(result.$1.isNotEmpty, true);
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
      expect(result.$1.length, 1);
      expect(result.$1.first.name, 'Prod1');
    });

    test('completeOnboarding_validData_callsSaveUserProfile', () async {
      // Arrange
      const tUid = 'uid_123';
      const tData = OnboardingData(firstName: 'John');
      when(
        () => mockFirebaseMessaging.getToken(),
      ).thenAnswer((_) async => 'fcm_token');
      when(
        () => mockFirebaseMessaging.subscribeToTopic(any()),
      ).thenAnswer((_) async {});
      when(
        () => mockRemoteDataSource.saveUserProfile(any(), any()),
      ).thenAnswer((_) async {});

      // Act
      await repository.completeOnboarding(data: tData, uid: tUid);

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

      // Act & Assert
      expect(
        () => repository.getDailyBrands(tSector),
        throwsA(isA<Exception>()),
      );
    });

    test('completeOnboarding_saveThrows_throwsException', () async {
      // Arrange
      const tUid = 'uid_123';
      const tData = OnboardingData(firstName: 'John');
      when(
        () => mockFirebaseMessaging.getToken(),
      ).thenAnswer((_) async => 'fcm_token');
      when(
        () => mockFirebaseMessaging.subscribeToTopic(any()),
      ).thenAnswer((_) async {});
      when(
        () => mockRemoteDataSource.saveUserProfile(any(), any()),
      ).thenThrow(Exception('Save Failed'));

      // Act & Assert
      expect(
        () => repository.completeOnboarding(data: tData, uid: tUid),
        throwsA(isA<Exception>()),
      );
    });
  });
}
