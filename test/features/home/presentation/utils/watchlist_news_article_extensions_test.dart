import 'package:bizzie/features/home/domain/models/watchlist_news_article.dart';
import 'package:bizzie/features/home/presentation/utils/watchlist_news_article_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

WatchlistNewsArticle tArticle({required DateTime publishedAt}) =>
    WatchlistNewsArticle(
      symbol: 'AAPL',
      title: 'Test Article',
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
}
