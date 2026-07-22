import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/usecase/usecase.dart';
import 'package:bizzie/features/market_news/domain/interfaces/i_market_news_repository.dart';
import 'package:bizzie/features/market_news/domain/models/market_news_article.dart';
import 'package:bizzie/features/market_news/domain/usecases/watch_market_news_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMarketNewsRepository extends Mock implements IMarketNewsRepository {}

const tFailure = Failure.server('error');

final tArticle = MarketNewsArticle(
  id: 'news_1',
  title: 'Article',
  site: 'reuters.com',
  publisher: 'Reuters',
  url: 'https://reuters.com/article',
  publishedAt: DateTime.utc(2026, 7, 15, 10),
);

void main() {
  late WatchMarketNewsUseCase sut;
  late MockMarketNewsRepository mockRepository;

  setUp(() {
    mockRepository = MockMarketNewsRepository();
    sut = WatchMarketNewsUseCase(mockRepository);
  });

  group('WatchMarketNewsUseCase', () {
    test('call_repositoryEmitsRight_returnsRightArticles', () async {
      // arrange
      when(
        () => mockRepository.watchMarketNews(),
      ).thenAnswer((_) => Stream.value(Right([tArticle])));

      // act
      final result = await sut(NoParams()).first;

      // assert
      expect(result.isRight(), isTrue);
      expect(result.getOrElse(() => []), [tArticle]);
      verify(() => mockRepository.watchMarketNews()).called(1);
    });

    test('call_repositoryEmitsLeft_returnsLeftFailure', () async {
      // arrange
      when(
        () => mockRepository.watchMarketNews(),
      ).thenAnswer((_) => Stream.value(const Left(tFailure)));

      // act
      final result = await sut(NoParams()).first;

      // assert
      expect(result, const Left<Failure, List<MarketNewsArticle>>(tFailure));
    });
  });
}
