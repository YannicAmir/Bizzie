import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/market_news/data/dtos/market_news_dto.dart';
import 'package:bizzie/features/market_news/data/interfaces/i_market_news_remote_datasource.dart';
import 'package:bizzie/features/market_news/data/repositories/market_news_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMarketNewsRemoteDataSource extends Mock
    implements IMarketNewsRemoteDataSource {}

final tOlderDto = MarketNewsDto(
  id: 'news_older',
  title: 'Older article',
  site: 'reuters.com',
  publisher: 'Reuters',
  url: 'https://reuters.com/older',
  publishedAt: DateTime.utc(2026, 7, 14, 10),
);

final tNewerDto = MarketNewsDto(
  id: 'news_newer',
  title: 'Newer article',
  site: 'seekingalpha.com',
  publisher: 'Seeking Alpha',
  url: 'https://seekingalpha.com/newer',
  publishedAt: DateTime.utc(2026, 7, 15, 10),
);

void main() {
  late MarketNewsRepositoryImpl sut;
  late MockMarketNewsRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockMarketNewsRemoteDataSource();
    sut = MarketNewsRepositoryImpl(mockRemoteDataSource);
  });

  group('MarketNewsRepositoryImpl', () {
    group('watchMarketNews', () {
      test(
        'watchMarketNews_datasourceEmitsDtos_returnsRightMappedPreservingOrder',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.getMarketNewsStream(),
          ).thenAnswer((_) => Stream.value([tOlderDto, tNewerDto]));

          // act
          final result = await sut.watchMarketNews().first;

          // assert — the repository is a pure mapper and preserves the
          // datasource order; display ordering is applied in presentation.
          expect(result.isRight(), isTrue);
          expect(result.getOrElse(() => []), [
            tOlderDto.toDomain(),
            tNewerDto.toDomain(),
          ]);
        },
      );

      test(
        'watchMarketNews_manyArticles_mapsAllPreservingOrder',
        () async {
          // arrange
          final dtos = List.generate(
            15,
            (index) => MarketNewsDto(
              id: 'news_$index',
              title: 'Article $index',
              site: 'reuters.com',
              publisher: 'Reuters',
              url: 'https://reuters.com/$index',
              publishedAt: DateTime.utc(
                2026,
                7,
                15,
              ).add(Duration(minutes: index)),
            ),
          );
          when(
            () => mockRemoteDataSource.getMarketNewsStream(),
          ).thenAnswer((_) => Stream.value(dtos));

          // act
          final result = await sut.watchMarketNews().first;

          // assert
          final articles = result.getOrElse(() => []);
          expect(articles.length, 15);
          expect(articles.first.title, 'Article 0');
          expect(articles.last.title, 'Article 14');
        },
      );

      test(
        'watchMarketNews_datasourceStreamErrors_returnsLeftServerFailure',
        () async {
          // arrange
          when(
            () => mockRemoteDataSource.getMarketNewsStream(),
          ).thenAnswer((_) => Stream.error(Exception('firestore down')));

          // act
          final result = await sut.watchMarketNews().first;

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
