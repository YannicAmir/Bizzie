import 'package:bizzie/features/home/domain/models/watchlist_news_article.dart';
import 'package:bizzie/features/home/presentation/utils/watchlist_news_article_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

WatchlistNewsArticle tArticle({
  required DateTime publishedAt,
  String id = 'AAPL_article',
  String symbol = 'AAPL',
  String title = 'Test Article',
}) => WatchlistNewsArticle(
  id: id,
  symbol: symbol,
  title: title,
  site: 'test.com',
  url: 'https://test.com/article',
  publishedAt: publishedAt,
);

void main() {
  group('WatchlistNewsArticlePresentationX', () {
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

  group('WatchlistNewsArticleListPresentationX', () {
    test(
      'sortedBySymbolThenRecency_multipleTickers_groupsBySymbolBeforeDate',
      () {
        // arrange
        final nvdaNewer = tArticle(
          id: 'NVDA_newer',
          symbol: 'NVDA',
          title: 'NVDA newer',
          publishedAt: DateTime.utc(2026, 7, 15, 10),
        );
        final axpLater = tArticle(
          id: 'AXP_later',
          symbol: 'AXP',
          title: 'AXP later',
          publishedAt: DateTime.utc(2026, 7, 16, 10),
        );
        final axpOlder = tArticle(
          id: 'AXP_older',
          symbol: 'AXP',
          title: 'AXP older',
          publishedAt: DateTime.utc(2026, 7, 14, 10),
        );

        // act
        final result = [nvdaNewer, axpLater, axpOlder].sortedBySymbolThenRecency;

        // assert — symbols grouped alphabetically, newest-first within a group.
        expect(result.map((a) => a.symbol).toList(), ['AXP', 'AXP', 'NVDA']);
        expect(result.map((a) => a.title).toList(), [
          'AXP later',
          'AXP older',
          'NVDA newer',
        ]);
      },
    );

    test('sortedBySymbolThenRecency_equalSymbolAndDate_breaksTieOnId', () {
      // arrange
      final publishedAt = DateTime.utc(2026, 7, 15, 10);
      final articleB = tArticle(
        id: 'AAPL_b',
        publishedAt: publishedAt,
      );
      final articleA = tArticle(
        id: 'AAPL_a',
        publishedAt: publishedAt,
      );

      // act
      final result = [articleB, articleA].sortedBySymbolThenRecency;

      // assert
      expect(result.map((a) => a.id).toList(), ['AAPL_a', 'AAPL_b']);
    });

    test('sortedBySymbolThenRecency_doesNotMutateSource', () {
      // arrange
      final newer = tArticle(
        id: 'AAPL_newer',
        publishedAt: DateTime.utc(2026, 7, 15, 10),
      );
      final older = tArticle(
        id: 'AAPL_older',
        publishedAt: DateTime.utc(2026, 7, 14, 10),
      );
      final source = [older, newer];

      // act
      source.sortedBySymbolThenRecency;

      // assert — the source list keeps its original order.
      expect(source, [older, newer]);
    });

    test('sortedBySymbolThenRecency_emptyList_returnsEmpty', () {
      // arrange
      final List<WatchlistNewsArticle> source = [];

      // act
      final result = source.sortedBySymbolThenRecency;

      // assert
      expect(result, isEmpty);
    });
  });
}
