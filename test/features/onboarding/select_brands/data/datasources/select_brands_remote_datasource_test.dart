import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/features/onboarding/select_brands/data/datasources/select_brands_remote_datasource.dart';
import 'package:bizzie/features/onboarding/select_brands/data/dtos/daily_brands_dto.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirestoreService extends Mock implements FirestoreService {}

void main() {
  late SelectBrandsRemoteDataSource dataSource;
  late MockFirestoreService mockFirestoreService;

  setUp(() {
    mockFirestoreService = MockFirestoreService();
    dataSource = SelectBrandsRemoteDataSource(mockFirestoreService);
  });

  final tDailyBrandsData = {
    'date': '2026-01-25',
    'sectors': [
      {
        'name': 'All Sectors',
        'products': [
          {
            'name': 'Apple',
            'company': 'Apple Inc.',
            'ticker': 'AAPL',
            'description': 'desc',
          },
        ],
      },
    ],
  };

  group('fetchDailyBrands', () {
    test('fetchDailyBrands_success_returnsDailyBrandsDto', () async {
      // arrange
      when(
        () => mockFirestoreService.getLatestDocument(
          collectionPath: any(named: 'collectionPath'),
          orderBy: any(named: 'orderBy'),
        ),
      ).thenAnswer((_) async => tDailyBrandsData);

      // act
      final result = await dataSource.fetchDailyBrands();

      // assert
      expect(result, isA<DailyBrandsDto>());
      expect(result?.sectors.first.name, 'All Sectors');
      verify(
        () => mockFirestoreService.getLatestDocument(
          collectionPath: 'daily_brands',
          orderBy: 'date',
        ),
      ).called(1);
    });

    test('fetchDailyBrands_empty_returnsNull', () async {
      // arrange
      when(
        () => mockFirestoreService.getLatestDocument(
          collectionPath: any(named: 'collectionPath'),
          orderBy: any(named: 'orderBy'),
        ),
      ).thenAnswer((_) async => null);

      // act
      final result = await dataSource.fetchDailyBrands();

      // assert
      expect(result, isNull);
    });

    test('fetchDailyBrands_firebaseException_throwsServerException', () async {
      // arrange
      when(
        () => mockFirestoreService.getLatestDocument(
          collectionPath: any(named: 'collectionPath'),
          orderBy: any(named: 'orderBy'),
        ),
      ).thenThrow(
        FirebaseException(plugin: 'firestore', message: 'connection error'),
      );

      // act
      final call = dataSource.fetchDailyBrands();

      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });

    test(
      'fetchDailyBrands_unexpectedException_throwsServerException',
      () async {
        // arrange
        when(
          () => mockFirestoreService.getLatestDocument(
            collectionPath: any(named: 'collectionPath'),
            orderBy: any(named: 'orderBy'),
          ),
        ).thenThrow(Exception('unexpected'));

        // act
        final call = dataSource.fetchDailyBrands();

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}
