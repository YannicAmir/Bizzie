import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/home/domain/interfaces/i_watchlist_news_repository.dart';
import 'package:bizzie/features/home/domain/models/watchlist_news_article.dart';
import 'package:bizzie/features/home/domain/usecases/watch_watchlist_news_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWatchlistNewsRepository extends Mock
    implements IWatchlistNewsRepository {}

const tTickers = ['AXP', 'NVDA'];
const tFailure = Failure.server('error');

final tArticle = WatchlistNewsArticle(
  symbol: 'AXP',
  title: 'Article',
  site: 'zacks.com',
  url: 'https://example.com/article',
  publishedAt: DateTime.utc(2026, 7, 15, 10),
);

void main() {
  late WatchWatchlistNewsUseCase sut;
  late MockWatchlistNewsRepository mockRepository;

  setUp(() {
    mockRepository = MockWatchlistNewsRepository();
    sut = WatchWatchlistNewsUseCase(mockRepository);
  });

  group('WatchWatchlistNewsUseCase', () {
    test('call_repositoryEmitsRight_returnsRightArticles', () async {
      // arrange
      when(() => mockRepository.watchWatchlistNews(tTickers)).thenAnswer(
        (_) => Stream.value(Right([tArticle])),
      );

      // act
      final result = await sut(tTickers).first;

      // assert
      expect(result.isRight(), isTrue);
      expect(result.getOrElse(() => []), [tArticle]);
      verify(() => mockRepository.watchWatchlistNews(tTickers)).called(1);
    });

    test('call_repositoryEmitsLeft_returnsLeftFailure', () async {
      // arrange
      when(() => mockRepository.watchWatchlistNews(tTickers)).thenAnswer(
        (_) => Stream.value(const Left(tFailure)),
      );

      // act
      final result = await sut(tTickers).first;

      // assert
      expect(result, const Left<Failure, List<WatchlistNewsArticle>>(tFailure));
    });
  });
}
