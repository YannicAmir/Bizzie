import 'package:bizzie/core/error/exceptions.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/reports/data/datasources/reports_remote_datasource.dart';
import 'package:bizzie/features/reports/data/repositories/reports_repository_impl.dart';
import 'package:bizzie/features/reports/domain/models/reports_feed.dart';
import 'package:bizzie/features/user/data/dtos/user_activity_dto.dart';
import 'package:bizzie/features/user/domain/models/user_activity.dart';
import 'package:bizzie/features/search/domain/interfaces/i_stock_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockReportsRemoteDataSource extends Mock
    implements IReportsRemoteDataSource {}

class MockStockRepository extends Mock implements IStockRepository {}

void main() {
  late ReportsRepositoryImpl repository;
  late MockReportsRemoteDataSource mockRemoteDataSource;
  late MockStockRepository mockStockRepository;

  setUpAll(() {
    registerFallbackValue(const UserActivityDto());
  });

  setUp(() {
    mockRemoteDataSource = MockReportsRemoteDataSource();
    mockStockRepository = MockStockRepository();
    repository = ReportsRepositoryImpl(
      mockRemoteDataSource,
      mockStockRepository,
    );
  });

  group('getReportsFeed', () {
    const tTickers = ['AAPL'];

    test('getReportsFeed_emptyTickersList_returnsEmptyReportsFeed', () async {
      // act
      final result = await repository.getReportsFeed([]).first;

      // assert
      expect(result, isA<Right<Failure, ReportsFeed>>());
      expect(result.getOrElse(() => throw Exception()).currentReports, isEmpty);
      verifyZeroInteractions(mockRemoteDataSource);
    });

    test('getReportsFeed_successfulCalls_returnsReportsFeed', () async {
      // arrange
      when(
        () => mockRemoteDataSource.getFinancialReportsStream(any()),
      ).thenAnswer((_) => Stream.value([]));
      when(
        () => mockRemoteDataSource.getSecFilingsStream(any()),
      ).thenAnswer((_) => Stream.value([]));
      when(
        () => mockRemoteDataSource.getUpcomingEarningsStream(any()),
      ).thenAnswer((_) => Stream.value([]));
      when(
        () => mockStockRepository.getAllStocks(),
      ).thenAnswer((_) async => const Right([]));

      // act
      final stream = repository.getReportsFeed(tTickers);

      // assert
      expect(stream, emits(isA<Right<Failure, ReportsFeed>>()));
      await untilCalled(
        () => mockRemoteDataSource.getFinancialReportsStream(tTickers),
      );
      verify(
        () => mockRemoteDataSource.getFinancialReportsStream(tTickers),
      ).called(1);
    });

    test(
      'getReportsFeed_remoteDataSourceFailure_returnsServerFailure',
      () async {
        // arrange
        when(
          () => mockRemoteDataSource.getFinancialReportsStream(any()),
        ).thenAnswer((_) => Stream.error(ServerException(message: 'Error')));
        when(
          () => mockRemoteDataSource.getSecFilingsStream(any()),
        ).thenAnswer((_) => Stream.value([]));
        when(
          () => mockRemoteDataSource.getUpcomingEarningsStream(any()),
        ).thenAnswer((_) => Stream.value([]));

        // act
        final stream = repository.getReportsFeed(tTickers);

        // assert
        expect(stream, emits(isA<Left<Failure, ReportsFeed>>()));
      },
    );
  });

  group('getUserActivityStream', () {
    const tUid = 'test_uid';
    const tUserActivityDto = UserActivityDto(lastViewedReports: null);
    const tUserActivity = UserActivity(lastViewedReports: null);

    test('getUserActivityStream_successfulCall_returnsUserActivity', () async {
      // arrange
      when(
        () => mockRemoteDataSource.getUserActivityStream(any()),
      ).thenAnswer((_) => Stream.value(tUserActivityDto));

      // act
      final result = repository.getUserActivityStream(tUid);

      // assert
      expect(
        result,
        emitsInOrder([const Right<Failure, UserActivity>(tUserActivity)]),
      );
      verify(() => mockRemoteDataSource.getUserActivityStream(tUid));
    });

    test('getUserActivityStream_dataSourceFailure_returnsFailure', () async {
      // arrange
      when(
        () => mockRemoteDataSource.getUserActivityStream(any()),
      ).thenAnswer((_) => Stream.error(Exception('Error')));

      // act
      final result = repository.getUserActivityStream(tUid);

      // assert
      expect(result, emits(isA<Left<Failure, UserActivity>>()));
      verify(() => mockRemoteDataSource.getUserActivityStream(tUid));
    });
  });

  group('markReportsViewed', () {
    const tUid = 'test_uid';
    final tTimestamp = DateTime(2023, 1, 1);
    final tDto = UserActivityDto(lastViewedReports: tTimestamp);

    test('markReportsViewed_callsUpdateUserActivity', () async {
      // arrange
      when(
        () => mockRemoteDataSource.updateUserActivity(any(), any()),
      ).thenAnswer((_) async {});

      // act
      await repository.markReportsViewed(tUid, tTimestamp);

      // assert
      verify(
        () => mockRemoteDataSource.updateUserActivity(tUid, tDto),
      ).called(1);
    });
  });
}
