import 'package:bizzie/features/market_news/domain/models/market_news_article.dart';
import 'package:bizzie/features/market_news/presentation/utils/market_news_article_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

MarketNewsArticle tArticle({
  required DateTime publishedAt,
  String id = 'news_1',
}) => MarketNewsArticle(
  id: id,
  title: 'Test Article',
  site: 'reuters.com',
  publisher: 'Reuters',
  url: 'https://reuters.com/article',
  publishedAt: publishedAt,
);

void main() {
  group('MarketNewsArticlePresentationX', () {
    test('timeAgo_pastPublishedAt_returnsRelativeString', () {
      // arrange
      final article = tArticle(
        publishedAt: DateTime.now().subtract(const Duration(hours: 2)),
      );

      // act
      final result = article.timeAgo;

      // assert
      expect(result, contains('hours ago'));
    });

    test('timeAgo_futurePublishedAt_clampsToNow', () {
      // arrange
      final article = tArticle(
        publishedAt: DateTime.now().add(const Duration(days: 1)),
      );

      // act
      final result = article.timeAgo;

      // assert
      expect(result, equals('a moment ago'));
    });
  });

  group('MarketNewsArticleListPresentationX', () {
    test('sortedByRecency_unorderedArticles_ordersNewestFirst', () {
      // arrange
      final older = tArticle(
        id: 'news_older',
        publishedAt: DateTime.utc(2026, 7, 14, 10),
      );
      final newer = tArticle(
        id: 'news_newer',
        publishedAt: DateTime.utc(2026, 7, 15, 10),
      );

      // act
      final result = [older, newer].sortedByRecency;

      // assert
      expect(result, [newer, older]);
    });

    test('sortedByRecency_equalTimestamps_breaksTieOnIdAscending', () {
      // arrange
      final publishedAt = DateTime.utc(2026, 7, 15, 10);
      final articleB = tArticle(id: 'news_b', publishedAt: publishedAt);
      final articleA = tArticle(id: 'news_a', publishedAt: publishedAt);

      // act
      final result = [articleB, articleA].sortedByRecency;

      // assert
      expect(result, [articleA, articleB]);
    });

    test('sortedByRecency_doesNotMutateSource', () {
      // arrange
      final older = tArticle(
        id: 'news_older',
        publishedAt: DateTime.utc(2026, 7, 14, 10),
      );
      final newer = tArticle(
        id: 'news_newer',
        publishedAt: DateTime.utc(2026, 7, 15, 10),
      );
      final source = [older, newer];

      // act
      source.sortedByRecency;

      // assert — the source list keeps its original order.
      expect(source, [older, newer]);
    });

    test('sortedByRecency_emptyList_returnsEmpty', () {
      // arrange
      final List<MarketNewsArticle> source = [];

      // act
      final result = source.sortedByRecency;

      // assert
      expect(result, isEmpty);
    });
  });
}
