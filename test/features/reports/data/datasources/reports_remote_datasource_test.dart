import 'package:bizzie/features/reports/data/datasources/reports_remote_datasource.dart';
import 'package:bizzie/features/reports/data/dtos/financial_report_dto.dart';
import 'package:bizzie/features/reports/data/dtos/sec_filing_dto.dart';
import 'package:bizzie/features/reports/data/dtos/upcoming_earnings_dto.dart';
import 'package:bizzie/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirestoreService extends Mock implements FirestoreService {}

const tTickers = ['AAPL'];
final tStreamError = StateError('stream failed');
final tPermissionDenied = FirebaseException(
  plugin: 'cloud_firestore',
  code: 'permission-denied',
);

void main() {
  late MockFirestoreService mockFirestoreService;
  late ReportsRemoteDataSource sut;

  void stubChunkedStream<T>(Object error) {
    when(
      () => mockFirestoreService.getCollectionStreamChunked<T>(
        path: any(named: 'path'),
        whereInField: any(named: 'whereInField'),
        values: any(named: 'values'),
        fromJson: any(named: 'fromJson'),
        chunkSize: any(named: 'chunkSize'),
      ),
    ).thenAnswer((_) => Stream<List<T>>.error(error));
  }

  setUp(() {
    mockFirestoreService = MockFirestoreService();
    sut = ReportsRemoteDataSource(mockFirestoreService);
  });

  group('ReportsRemoteDataSource', () {
    group('getFinancialReportsStream', () {
      test('getFinancialReportsStream_streamError_rethrowsError', () {
        // arrange
        stubChunkedStream<FinancialReportDto>(tStreamError);

        // act
        final result = sut.getFinancialReportsStream(tTickers);

        // assert
        expect(result, emitsError(tStreamError));
      });

      test('getFinancialReportsStream_permissionDenied_swallowsError', () {
        // arrange
        stubChunkedStream<FinancialReportDto>(tPermissionDenied);

        // act
        final result = sut.getFinancialReportsStream(tTickers);

        // assert
        expect(result, emitsDone);
      });
    });

    group('getSecFilingsStream', () {
      test('getSecFilingsStream_streamError_rethrowsError', () {
        // arrange
        stubChunkedStream<SecFilingDto>(tStreamError);

        // act
        final result = sut.getSecFilingsStream(tTickers);

        // assert
        expect(result, emitsError(tStreamError));
      });

      test('getSecFilingsStream_permissionDenied_swallowsError', () {
        // arrange
        stubChunkedStream<SecFilingDto>(tPermissionDenied);

        // act
        final result = sut.getSecFilingsStream(tTickers);

        // assert
        expect(result, emitsDone);
      });
    });

    group('getUpcomingEarningsStream', () {
      test('getUpcomingEarningsStream_streamError_rethrowsError', () {
        // arrange
        stubChunkedStream<UpcomingEarningsDto>(tStreamError);

        // act
        final result = sut.getUpcomingEarningsStream(tTickers);

        // assert
        expect(result, emitsError(tStreamError));
      });

      test('getUpcomingEarningsStream_permissionDenied_swallowsError', () {
        // arrange
        stubChunkedStream<UpcomingEarningsDto>(tPermissionDenied);

        // act
        final result = sut.getUpcomingEarningsStream(tTickers);

        // assert
        expect(result, emitsDone);
      });
    });
  });
}
