// ignore_for_file: subtype_of_sealed_class
import 'package:bizzie/features/onboarding/data/datasources/onboarding_remote_datasource.dart';
import 'package:bizzie/features/user/data/dtos/user_dto.dart';
import 'package:bizzie/services/config_service.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirestoreService extends Mock implements FirestoreService {}

class MockConfigService extends Mock implements ConfigService {}

class MockBizzieBatch extends Mock implements BizzieBatch {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class FakeDocumentReference extends Fake
    implements DocumentReference<Map<String, dynamic>> {}

void main() {
  late OnboardingRemoteDataSource dataSource;
  late MockFirestoreService mockFirestoreService;
  late MockConfigService mockConfigService;

  setUpAll(() {
    registerFallbackValue(FakeDocumentReference());
  });

  setUp(() {
    mockFirestoreService = MockFirestoreService();
    mockConfigService = MockConfigService();

    dataSource = OnboardingRemoteDataSource(
      mockFirestoreService,
      mockConfigService,
    );
  });

  group('OnboardingRemoteDataSource', () {
    test('getStockMarketSectors_success_returnsSectorsFromConfig', () {
      // Arrange
      const tSectors = ['Tech', 'Health'];
      when(() => mockConfigService.stockMarketSectors).thenReturn(tSectors);

      // Act
      final result = dataSource.getStockMarketSectors();

      // Assert
      expect(result, tSectors);
      verify(() => mockConfigService.stockMarketSectors).called(1);
    });

    test('getOnboardingConfig_success_returnsBoolFromConfig', () {
      // Arrange
      const tKey = 'show_intro';
      when(() => mockConfigService.getBool(tKey)).thenReturn(true);

      // Act
      final result = dataSource.getOnboardingConfig(tKey);

      // Assert
      expect(result, true);
      verify(() => mockConfigService.getBool(tKey)).called(1);
    });

    test('saveUserProfile_validUser_callsBatchCommit', () async {
      // Arrange
      final tUser = UserDto(
        uid: '123',
        name: 'John',
        fcmTokens: {},
        investingExperience: 'beginner',
        isSubscribed: false,
        favoriteSector: '',
        createdAt: DateTime(2023),
      );

      final mockBizzieBatch = MockBizzieBatch();

      when(() => mockFirestoreService.batch()).thenReturn(mockBizzieBatch);
      when(
        () => mockBizzieBatch.setRaw(
          path: any(named: 'path'),
          data: any(named: 'data'),
        ),
      ).thenReturn(null);
      when(() => mockBizzieBatch.commit()).thenAnswer((_) async {});

      // Act
      await dataSource.saveUserProfile(tUser, []);

      // Assert
      verify(() => mockFirestoreService.batch()).called(1);
      verify(() => mockBizzieBatch.commit()).called(1);
      verify(
        () => mockBizzieBatch.setRaw(
          path: 'users/123',
          data: any(named: 'data'),
        ),
      ).called(1);
    });
  });
}
