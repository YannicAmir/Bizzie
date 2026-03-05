import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/search/domain/enums/search_analytics_enums.dart';
import 'package:bizzie/features/search/presentation/analytics/search_tracker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late SearchTracker tracker;
  late MockIAnalyticsService mockAnalytics;

  setUp(() {
    mockAnalytics = MockIAnalyticsService();
    tracker = SearchTracker(mockAnalytics);

    when(
      () => mockAnalytics.logEvent(
        name: any(named: 'name'),
        parameters: any(named: 'parameters'),
      ),
    ).thenAnswer((_) async {});

    when(
      () => mockAnalytics.setUserProperty(
        name: any(named: 'name'),
        value: any(named: 'value'),
      ),
    ).thenAnswer((_) async {});
  });

  group('SearchTracker', () {
    test('logPageView_withSource_logsSearchPageViewedWithParams', () async {
      // arrange
      const source = SearchSource.home;

      // act
      await tracker.logPageView(source: source);

      // assert
      verify(
        () => mockAnalytics.logEvent(
          name: 'search_page_viewed',
          parameters: any(
            named: 'parameters',
            that: containsPair('source', source.analyticsValue),
          ),
        ),
      ).called(1);
    });

    test(
      'logAiSearchOutcome_withMatch_logsAiSearchOutcomeWithDetails',
      () async {
        // arrange
        const query = 'iPhone';
        const outcome = SearchOutcome.matchFound;
        const matchTicker = 'AAPL';

        // act
        await tracker.logAiSearchOutcome(
          query: query,
          outcome: outcome,
          matchTicker: matchTicker,
        );

        // assert
        verify(
          () => mockAnalytics.logEvent(
            name: 'ai_search_outcome',
            parameters: any(
              named: 'parameters',
              that: allOf(
                containsPair('query', query),
                containsPair('outcome', outcome.analyticsValue),
                containsPair('match_ticker', matchTicker),
              ),
            ),
          ),
        ).called(1);
      },
    );

    test(
      'logResultClicked_isAiResult_logsSearchResultClickedWithDetails',
      () async {
        // arrange
        const query = 'Apple';
        const ticker = 'AAPL';
        const isAiResult = true;
        const companyName = 'Apple Inc.';

        // act
        await tracker.logResultClicked(
          query: query,
          ticker: ticker,
          isAiResult: isAiResult,
          companyName: companyName,
        );

        // assert
        verify(
          () => mockAnalytics.logEvent(
            name: 'search_result_clicked',
            parameters: any(
              named: 'parameters',
              that: allOf(
                containsPair('query', query),
                containsPair('ticker', ticker),
                containsPair('is_ai_result', isAiResult),
                containsPair('company_name', companyName),
              ),
            ),
          ),
        ).called(1);
      },
    );

    test('logRecommendedClicked_validTicker_logsRecomBrandClicked', () async {
      // arrange
      const query = '';
      const ticker = 'TSLA';

      // act
      await tracker.logRecommendedClicked(query: query, ticker: ticker);

      // assert
      verify(
        () => mockAnalytics.logEvent(
          name: 'recom_brand_clicked',
          parameters: any(
            named: 'parameters',
            that: allOf(
              containsPair('query', query),
              containsPair('ticker', ticker),
            ),
          ),
        ),
      ).called(1);
    });

    test('logSearchCleared_userAction_logsSearchClearedEvent', () async {
      // act
      await tracker.logSearchCleared();

      // assert
      verify(
        () => mockAnalytics.logEvent(
          name: 'search_cleared',
          parameters: any(named: 'parameters'),
        ),
      ).called(1);
    });

    test('setLastSearchQuery_validQuery_updatesUserProperty', () async {
      // arrange
      const query = 'Apple';

      // act
      await tracker.setLastSearchQuery(query);

      // assert
      verify(
        () => mockAnalytics.setUserProperty(
          name: 'last_search_query',
          value: query,
        ),
      ).called(1);
    });

    test('setTotalSearchCount_asInteger_updatesUserPropertyAsString', () async {
      // arrange
      const count = 10;

      // act
      await tracker.setTotalSearchCount(count);

      // assert
      verify(
        () => mockAnalytics.setUserProperty(
          name: 'search_total_count',
          value: count.toString(),
        ),
      ).called(1);
    });

    test('logSearchCancelled_logsSearchCancelled', () async {
      // act
      await tracker.logSearchCancelled();

      // assert
      verify(
        () => mockAnalytics.logEvent(
          name: 'search_cancelled',
          parameters: any(named: 'parameters'),
        ),
      ).called(1);
    });
  });
}
