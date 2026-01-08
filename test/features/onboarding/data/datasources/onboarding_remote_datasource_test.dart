// ignore_for_file: subtype_of_sealed_class
import 'package:bizzie/features/onboarding/data/datasources/onboarding_remote_datasource.dart';
import 'package:bizzie/features/onboarding/data/dtos/user_dto.dart';
import 'package:bizzie/services/config_service.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirestoreService extends Mock implements FirestoreService {}

class MockConfigService extends Mock implements ConfigService {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockQuery extends Mock implements Query<Map<String, dynamic>> {}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {}

class MockWriteBatch extends Mock implements WriteBatch {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class FakeDocumentReference extends Fake
    implements DocumentReference<Map<String, dynamic>> {}

void main() {
  late OnboardingRemoteDataSource dataSource;
  late MockFirestoreService mockFirestoreService;
  late MockConfigService mockConfigService;
  late MockFirebaseFirestore mockFirestore;

  setUpAll(() {
    registerFallbackValue(FakeDocumentReference());
  });

  setUp(() {
    mockFirestoreService = MockFirestoreService();
    mockConfigService = MockConfigService();
    mockFirestore = MockFirebaseFirestore();

    when(() => mockFirestoreService.instance).thenReturn(mockFirestore);

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
        favoriteSectorDisplay: '',
      );

      final mockBatch = MockWriteBatch();
      final mockUserRef = MockDocumentReference();
      final mockUsersCollection = MockCollectionReference();

      when(() => mockFirestore.batch()).thenReturn(mockBatch);
      when(
        () => mockFirestore.collection('users'),
      ).thenReturn(mockUsersCollection);
      when(() => mockUsersCollection.doc(any())).thenReturn(mockUserRef);
      when(() => mockBatch.set(any(), any())).thenReturn(null);
      when(() => mockBatch.commit()).thenAnswer((_) async {});

      // Act
      await dataSource.saveUserProfile(tUser, []);

      // Assert
      verify(() => mockFirestore.batch()).called(1);
      verify(() => mockBatch.commit()).called(1);
      verify(
        () => mockBatch.set<Map<String, dynamic>>(any(), any(), any()),
      ).called(1);
    });

    test('fetchDailyBrands_hasData_returnsDto', () async {
      // Arrange
      final mockCollection = MockCollectionReference();
      final mockQuery = MockQuery();
      final mockSnapshot = MockQuerySnapshot();
      final mockDoc = MockQueryDocumentSnapshot();

      when(
        () => mockFirestore.collection('daily_brands'),
      ).thenReturn(mockCollection);
      when(
        () => mockCollection.orderBy('date', descending: true),
      ).thenReturn(mockQuery);
      when(() => mockQuery.limit(1)).thenReturn(mockQuery);
      when(() => mockQuery.get()).thenAnswer((_) async => mockSnapshot);

      when(() => mockSnapshot.docs).thenReturn([mockDoc]);
      when(() => mockDoc.data()).thenReturn({
        'date': Timestamp.now(),
        'sectors': [
          {'name': 'Tech', 'products': []},
        ],
      });

      // Act
      final result = await dataSource.fetchDailyBrands();

      // Assert
      expect(result, isNotNull);
      verify(() => mockFirestore.collection('daily_brands')).called(1);
    });

    test('fetchDailyBrands_noData_returnsNull', () async {
      // Arrange
      final mockCollection = MockCollectionReference();
      final mockQuery = MockQuery();
      final mockSnapshot = MockQuerySnapshot();

      when(
        () => mockFirestore.collection('daily_brands'),
      ).thenReturn(mockCollection);
      when(
        () => mockCollection.orderBy('date', descending: true),
      ).thenReturn(mockQuery);
      when(() => mockQuery.limit(1)).thenReturn(mockQuery);
      when(() => mockQuery.get()).thenAnswer((_) async => mockSnapshot);

      when(() => mockSnapshot.docs).thenReturn([]);

      // Act
      final result = await dataSource.fetchDailyBrands();

      // Assert
      expect(result, isNull);
    });
  });
}
