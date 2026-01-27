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

  setUpAll(() {
    registerFallbackValue(DailyBrandsDto.fromJson({}));
  });

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
        () => mockFirestoreService.getLatestDocument<DailyBrandsDto>(
          collectionPath: any(named: 'collectionPath'),
          orderBy: any(named: 'orderBy'),
          fromJson: any(named: 'fromJson'),
          toJson: any(named: 'toJson'),
        ),
      ).thenAnswer((_) async => DailyBrandsDto.fromJson(tDailyBrandsData));

      // act
      final result = await dataSource.fetchDailyBrands();

      // assert
      expect(result, isA<DailyBrandsDto>());
      expect(result?.sectors.first.name, 'All Sectors');
      verify(
        () => mockFirestoreService.getLatestDocument<DailyBrandsDto>(
          collectionPath: 'daily_brands',
          orderBy: 'date',
          fromJson: any(named: 'fromJson'),
          toJson: any(named: 'toJson'),
        ),
      ).called(1);
    });

    test('fetchDailyBrands_empty_returnsNull', () async {
      // arrange
      when(
        () => mockFirestoreService.getLatestDocument<DailyBrandsDto>(
          collectionPath: any(named: 'collectionPath'),
          orderBy: any(named: 'orderBy'),
          fromJson: any(named: 'fromJson'),
          toJson: any(named: 'toJson'),
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
        () => mockFirestoreService.getLatestDocument<DailyBrandsDto>(
          collectionPath: any(named: 'collectionPath'),
          orderBy: any(named: 'orderBy'),
          fromJson: any(named: 'fromJson'),
          toJson: any(named: 'toJson'),
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
          () => mockFirestoreService.getLatestDocument<DailyBrandsDto>(
            collectionPath: any(named: 'collectionPath'),
            orderBy: any(named: 'orderBy'),
            fromJson: any(named: 'fromJson'),
            toJson: any(named: 'toJson'),
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
