import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/watchlist_ytd/data/dtos/ytd_price_change_dto.dart';
import 'package:bizzie/features/watchlist_ytd/data/interfaces/i_watchlist_ytd_remote_datasource.dart';
import 'package:bizzie/features/watchlist_ytd/data/repositories/watchlist_ytd_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchlistYtdRemoteDataSource extends Mock
    implements IWatchlistYtdRemoteDataSource {}

const tTickers = ['FTNT', 'NVDA'];

const tDto = YtdPriceChangeDto(
  ticker: 'FTNT',
  companyName: 'Fortinet, Inc.',
  year: 2026,
  baselineDate: '2025-12-31',
  baselineClose: 79.41,
  latestDate: '2026-07-21',
  latestClose: 158.1,
  ytdChange: 78.69,
  ytdChangePercent: 99.09331318473744,
);

void main() {
  late WatchlistYtdRepositoryImpl sut;
  late MockWatchlistYtdRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockWatchlistYtdRemoteDataSource();
    sut = WatchlistYtdRepositoryImpl(mockRemoteDataSource);
  });

  group('WatchlistYtdRepositoryImpl', () {
    group('getWatchlistYtd', () {
      test(
        'getWatchlistYtd_datasourceReturnsDtos_returnsRightDomainModels',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.getWatchlistYtd(tTickers),
          ).thenAnswer((_) async => [tDto]);

          // act
          final result = await sut.getWatchlistYtd(tTickers);

          // assert
          expect(result.isRight(), isTrue);
          expect(result.getOrElse(() => []), [tDto.toDomain()]);
        },
      );

      test('getWatchlistYtd_emptyTickers_returnsRightEmptyList', () async {
        // arrange
        when(
          () => mockRemoteDataSource.getWatchlistYtd([]),
        ).thenAnswer((_) async => []);

        // act
        final result = await sut.getWatchlistYtd([]);

        // assert
        expect(result.isRight(), isTrue);
        expect(result.getOrElse(() => [tDto.toDomain()]), isEmpty);
      });

      test(
        'getWatchlistYtd_datasourceThrows_returnsLeftServerFailure',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.getWatchlistYtd(tTickers),
          ).thenThrow(Exception('firestore down'));

          // act
          final result = await sut.getWatchlistYtd(tTickers);

          // assert
          expect(result.isLeft(), isTrue);
          result.fold(
            (failure) => expect(failure, isA<Failure>()),
            (_) => fail('Expected Left'),
          );
        },
      );
    });
  });
}
