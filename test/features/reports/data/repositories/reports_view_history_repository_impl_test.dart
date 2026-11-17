import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/reports/data/interfaces/i_reports_local_datasource.dart';
import 'package:bizzie/features/reports/data/repositories/reports_view_history_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockReportsLocalDataSource extends Mock
    implements IReportsLocalDataSource {}

void main() {
  late ReportsViewHistoryRepositoryImpl sut;
  late MockReportsLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockReportsLocalDataSource();
    sut = ReportsViewHistoryRepositoryImpl(mockLocalDataSource);
  });

  group('ReportsViewHistoryRepositoryImpl', () {
    group('getSeenWeeklyReportIds', () {
      test('getSeenWeeklyReportIds_nothingStored_returnsRightEmptySet', () {
        // arrange
        when(
          () => mockLocalDataSource.getSeenWeeklyReportIds(),
        ).thenReturn(null);

        // act
        final result = sut.getSeenWeeklyReportIds();

        // assert
        expect(result, const Right<Failure, Set<String>>(<String>{}));
      });

      test('getSeenWeeklyReportIds_validJsonStored_returnsRightDecodedSet', () {
        // arrange
        when(
          () => mockLocalDataSource.getSeenWeeklyReportIds(),
        ).thenReturn('["AAPL_2026-01-01","MSFT_2026-01-01"]');

        // act
        final result = sut.getSeenWeeklyReportIds();

        // assert
        expect(result.getOrElse(() => {}), {
          'AAPL_2026-01-01',
          'MSFT_2026-01-01',
        });
      });

      test(
        'getSeenWeeklyReportIds_corruptJsonStored_returnsLeftCacheFailure',
        () {
          // arrange
          when(
            () => mockLocalDataSource.getSeenWeeklyReportIds(),
          ).thenReturn('not json');

          // act
          final result = sut.getSeenWeeklyReportIds();

          // assert
          expect(result.isLeft(), isTrue);
          result.leftMap((failure) => expect(failure, isA<CacheFailure>()));
        },
      );
    });

    group('saveSeenWeeklyReportIds', () {
      test(
        'saveSeenWeeklyReportIds_success_persistsJsonAndReturnsRightUnit',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.setSeenWeeklyReportIds(any()),
          ).thenAnswer((_) async {});

          // act
          final result = await sut.saveSeenWeeklyReportIds({'AAPL_2026-01-01'});

          // assert
          expect(result, const Right<Failure, Unit>(unit));
          verify(
            () => mockLocalDataSource.setSeenWeeklyReportIds(
              '["AAPL_2026-01-01"]',
            ),
          ).called(1);
        },
      );

      test(
        'saveSeenWeeklyReportIds_datasourceThrows_returnsLeftCacheFailure',
        () async {
          // arrange
          when(
            () => mockLocalDataSource.setSeenWeeklyReportIds(any()),
          ).thenThrow(Exception('disk full'));

          // act
          final result = await sut.saveSeenWeeklyReportIds({'AAPL_2026-01-01'});

          // assert
          expect(
            result,
            const Left<Failure, Unit>(Failure.cache('Exception: disk full')),
          );
        },
      );
    });

    group('incrementFeedViewCount', () {
      test(
        'incrementFeedViewCount_existingCount_persistsAndReturnsIncremented',
        () async {
          // arrange
          when(() => mockLocalDataSource.getFeedViewCount()).thenReturn(5);
          when(
            () => mockLocalDataSource.setFeedViewCount(any()),
          ).thenAnswer((_) async {});

          // act
          final result = await sut.incrementFeedViewCount();

          // assert
          expect(result, const Right<Failure, int>(6));
          verify(() => mockLocalDataSource.setFeedViewCount(6)).called(1);
        },
      );

      test(
        'incrementFeedViewCount_noStoredCount_persistsAndReturnsOne',
        () async {
          // arrange
          when(() => mockLocalDataSource.getFeedViewCount()).thenReturn(null);
          when(
            () => mockLocalDataSource.setFeedViewCount(any()),
          ).thenAnswer((_) async {});

          // act
          final result = await sut.incrementFeedViewCount();

          // assert
          expect(result, const Right<Failure, int>(1));
          verify(() => mockLocalDataSource.setFeedViewCount(1)).called(1);
        },
      );

      test(
        'incrementFeedViewCount_datasourceThrows_returnsLeftCacheFailure',
        () async {
          // arrange
          when(() => mockLocalDataSource.getFeedViewCount()).thenReturn(1);
          when(
            () => mockLocalDataSource.setFeedViewCount(any()),
          ).thenThrow(Exception('disk full'));

          // act
          final result = await sut.incrementFeedViewCount();

          // assert
          expect(
            result,
            const Left<Failure, int>(Failure.cache('Exception: disk full')),
          );
        },
      );
    });
  });
}
