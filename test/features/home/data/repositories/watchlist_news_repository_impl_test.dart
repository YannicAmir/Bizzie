import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/home/data/dtos/watchlist_news_dto.dart';
import 'package:bizzie/features/home/data/interfaces/i_watchlist_news_remote_datasource.dart';
import 'package:bizzie/features/home/data/repositories/watchlist_news_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchlistNewsRemoteDataSource extends Mock
    implements IWatchlistNewsRemoteDataSource {}

const tTickers = ['AXP', 'NVDA'];

final tOlderDto = WatchlistNewsDto(
  symbol: 'AXP',
  title: 'Older article',
  site: 'zacks.com',
  url: 'https://example.com/older',
  publishedAt: DateTime.utc(2026, 7, 14, 10),
);

final tNewerDto = WatchlistNewsDto(
  symbol: 'NVDA',
  title: 'Newer article',
  site: '247wallst.com',
  url: 'https://example.com/newer',
  publishedAt: DateTime.utc(2026, 7, 15, 10),
);

void main() {
  late WatchlistNewsRepositoryImpl sut;
  late MockWatchlistNewsRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockWatchlistNewsRemoteDataSource();
    sut = WatchlistNewsRepositoryImpl(mockRemoteDataSource);
  });

  group('WatchlistNewsRepositoryImpl', () {
    group('watchWatchlistNews', () {
      test(
        'watchWatchlistNews_datasourceEmitsDtos_returnsRightSortedNewestFirst',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.getWatchlistNewsStream(tTickers),
          ).thenAnswer((_) => Stream.value([tOlderDto, tNewerDto]));

          // act
          final result = await sut.watchWatchlistNews(tTickers).first;

          // assert
          expect(result.isRight(), isTrue);
          expect(
            result.getOrElse(() => []),
            [tNewerDto.toDomain(), tOlderDto.toDomain()],
          );
        },
      );

      test(
        'watchWatchlistNews_manyArticles_returnsAllSortedNewestFirst',
        () async {
          // arrange
          final dtos = List.generate(
            12,
            (index) => WatchlistNewsDto(
              symbol: 'AXP',
              title: 'Article $index',
              site: 'zacks.com',
              url: 'https://example.com/$index',
              publishedAt: DateTime.utc(2026, 7, 15).add(
                Duration(minutes: index),
              ),
            ),
          );
          when(
            () => mockRemoteDataSource.getWatchlistNewsStream(tTickers),
          ).thenAnswer((_) => Stream.value(dtos));

          // act
          final result = await sut.watchWatchlistNews(tTickers).first;

          // assert
          final articles = result.getOrElse(() => []);
          expect(articles.length, 12);
          expect(articles.first.title, 'Article 11');
          expect(articles.last.title, 'Article 0');
        },
      );

      test(
        'watchWatchlistNews_datasourceStreamErrors_returnsLeftServerFailure',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.getWatchlistNewsStream(tTickers),
          ).thenAnswer((_) => Stream.error(Exception('firestore down')));

          // act
          final result = await sut.watchWatchlistNews(tTickers).first;

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
