import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/company_profile/cp/presentation/analytics/company_profile_analytics.dart';
import 'package:bizzie/features/company_profile/cp/presentation/analytics/company_profile_session_summary.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsService extends Mock implements IAnalyticsService {}

const tTicker = 'AAPL';
const tLongTicker = 'VERY_LONG_TICKER_NAME_THAT_EXCEEDS_24';
const tLongCoName = 'VERY_LONG_COMPANY_NAME_THAT_EXCEEDS_24_CHARACTERS';
const tLongTab = 'FINANCIALS_TAB_THAT_IS_VERY_LONG';

const tSummary = CompanyProfileSessionSummary(
  sessionId: 'session-1',
  ticker: tTicker,
  companyName: 'Apple',
  industry: 'Consumer Electronics',
  sector: 'Technology',
  tabsCount: 2,
  tabsList: ['Overview', 'News'],
  durationSeconds: 120,
  isWatchlisted: true,
  initWatchlisted: false,
  isCompany: true,
  isEtf: false,
  isFund: false,
  isFinal: true,
);
const tSummaryWithoutIndustry = CompanyProfileSessionSummary(
  sessionId: 'session-1',
  ticker: tTicker,
  companyName: 'Apple',
  tabsCount: 1,
  tabsList: ['Overview'],
  durationSeconds: 60,
  isWatchlisted: false,
  initWatchlisted: false,
  isCompany: true,
  isEtf: false,
  isFund: false,
  isFinal: false,
);
const tLongNamesSummary = CompanyProfileSessionSummary(
  sessionId: 'session-2',
  ticker: tLongTicker,
  companyName: tLongCoName,
  industry: 'Tech',
  sector: 'Technology',
  tabsCount: 3,
  tabsList: ['Overview', 'Financials'],
  durationSeconds: 120,
  isWatchlisted: true,
  initWatchlisted: false,
  isCompany: true,
  isEtf: false,
  isFund: false,
  isFinal: true,
);
const tLongTabSummary = CompanyProfileSessionSummary(
  sessionId: 'session-3',
  ticker: tTicker,
  companyName: 'Apple',
  industry: 'Tech',
  sector: 'Tech',
  tabsCount: 1,
  tabsList: [tLongTab],
  durationSeconds: 60,
  isWatchlisted: false,
  initWatchlisted: false,
  isCompany: true,
  isEtf: false,
  isFund: false,
  isFinal: true,
);

void main() {
  late CompanyProfileAnalytics sut;
  late MockAnalyticsService mockAnalyticsService;

  setUp(() {
    mockAnalyticsService = MockAnalyticsService();
    sut = CompanyProfileAnalytics(mockAnalyticsService);

    when(
      () => mockAnalyticsService.logEvent(
        name: any(named: 'name'),
        parameters: any(named: 'parameters'),
      ),
    ).thenAnswer((_) async {});
  });

  group('CompanyProfileAnalytics', () {
    group('logSessionSummary', () {
      test(
        'logSessionSummary_completeSummary_logsEventWithAllParameters',
        () async {
          // arrange
          const tExpectedTabsList = 'Overview,News';

          // act
          await sut.logSessionSummary(tSummary);

          // assert
          verify(
            () => mockAnalyticsService.logEvent(
              name: 'cp_session_summary',
              parameters: any(
                that: allOf([
                  containsPair('session_id', 'session-1'),
                  containsPair('ticker', tTicker),
                  containsPair('co_name', 'Apple'),
                  containsPair('industry', 'Consumer Electronics'),
                  containsPair('sector', 'Technology'),
                  containsPair('tabs_count', 2),
                  containsPair('tabs_list', tExpectedTabsList),
                  containsPair('duration_sec', 120),
                  containsPair('is_watchlisted', true),
                  containsPair('init_watchlisted', false),
                  containsPair('is_company', true),
                  containsPair('is_etf', false),
                  containsPair('is_fund', false),
                  containsPair('is_final', true),
                  containsPair('screen_name', 'company_profile'),
                  containsPair('timestamp', isA<String>()),
                ]),
                named: 'parameters',
              ),
            ),
          ).called(1);
        },
      );

      test(
        'logSessionSummary_nullIndustryAndSector_omitsOptionalParameters',
        () async {
          // arrange
          const tOmittedKeys = ['industry', 'sector'];

          // act
          await sut.logSessionSummary(tSummaryWithoutIndustry);

          // assert
          verify(
            () => mockAnalyticsService.logEvent(
              name: 'cp_session_summary',
              parameters: any(
                that: isNot(
                  anyOf(contains(tOmittedKeys[0]), contains(tOmittedKeys[1])),
                ),
                named: 'parameters',
              ),
            ),
          ).called(1);
        },
      );

      test(
        'logSessionSummary_longTickerAndCompanyName_truncatesValues',
        () async {
          // arrange
          final tExpectedTicker = tLongTicker.substring(0, 24);
          final tExpectedCoName = tLongCoName.substring(0, 24);

          // act
          await sut.logSessionSummary(tLongNamesSummary);

          // assert
          verify(
            () => mockAnalyticsService.logEvent(
              name: 'cp_session_summary',
              parameters: any(
                that: allOf([
                  containsPair('ticker', tExpectedTicker),
                  containsPair('co_name', tExpectedCoName),
                ]),
                named: 'parameters',
              ),
            ),
          ).called(1);
        },
      );

      test('logSessionSummary_longTabName_truncatesTabsList', () async {
        // arrange
        final tExpectedTabsList = tLongTab.substring(0, 24);

        // act
        await sut.logSessionSummary(tLongTabSummary);

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'cp_session_summary',
            parameters: any(
              that: containsPair('tabs_list', tExpectedTabsList),
              named: 'parameters',
            ),
          ),
        ).called(1);
      });

      test(
        'logSessionSummary_serviceThrowsException_catchesGracefully',
        () async {
          // arrange
          when(
            () => mockAnalyticsService.logEvent(
              name: any(named: 'name'),
              parameters: any(named: 'parameters'),
            ),
          ).thenThrow(Exception('Analytics failure'));

          // act
          final future = sut.logSessionSummary(tSummary);

          // assert
          await expectLater(future, completes);
        },
      );
    });

    group('logEditTabsOpened', () {
      test(
        'logEditTabsOpened_activeSession_logsEditTabsEventWithOpenedAction',
        () async {
          // arrange
          const tIsSubscribed = true;

          // act
          await sut.logEditTabsOpened(
            ticker: tTicker,
            isSubscribed: tIsSubscribed,
          );

          // assert
          verify(
            () => mockAnalyticsService.logEvent(
              name: 'cp_edit_tabs',
              parameters: any(
                that: allOf([
                  containsPair('action', 'opened'),
                  containsPair('ticker', tTicker),
                  containsPair('is_subscribed', tIsSubscribed),
                ]),
                named: 'parameters',
              ),
            ),
          ).called(1);
        },
      );

      test(
        'logEditTabsOpened_anyInvocation_mergesScreenNameAndTimestamp',
        () async {
          // arrange
          const tExpectedScreenName = 'company_profile';

          // act
          await sut.logEditTabsOpened(ticker: tTicker, isSubscribed: true);

          // assert
          verify(
            () => mockAnalyticsService.logEvent(
              name: 'cp_edit_tabs',
              parameters: any(
                that: allOf([
                  containsPair('screen_name', tExpectedScreenName),
                  containsPair('timestamp', isA<String>()),
                ]),
                named: 'parameters',
              ),
            ),
          ).called(1);
        },
      );

      test('logEditTabsOpened_longTicker_truncatesTickerTo24Chars', () async {
        // arrange
        final tExpectedTicker = tLongTicker.substring(0, 24);

        // act
        await sut.logEditTabsOpened(ticker: tLongTicker, isSubscribed: false);

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'cp_edit_tabs',
            parameters: any(
              that: containsPair('ticker', tExpectedTicker),
              named: 'parameters',
            ),
          ),
        ).called(1);
      });

      test(
        'logEditTabsOpened_serviceThrowsException_catchesGracefully',
        () async {
          // arrange
          when(
            () => mockAnalyticsService.logEvent(
              name: any(named: 'name'),
              parameters: any(named: 'parameters'),
            ),
          ).thenThrow(Exception('Analytics failure'));

          // act
          final future = sut.logEditTabsOpened(
            ticker: tTicker,
            isSubscribed: true,
          );

          // assert
          await expectLater(future, completes);
        },
      );
    });

    group('logEditTabsSaved', () {
      test(
        'logEditTabsSaved_tabOrder_logsSavedActionWithShortenedTabNames',
        () async {
          // arrange
          const tMainTabs = ['chat', 'fcps', 'revenue', 'news'];
          const tMoreTabs = ['free_cash', 'dividends', 'eps'];

          // act
          await sut.logEditTabsSaved(
            ticker: tTicker,
            isSubscribed: false,
            mainTabs: tMainTabs,
            moreTabs: tMoreTabs,
          );

          // assert
          verify(
            () => mockAnalyticsService.logEvent(
              name: 'cp_edit_tabs',
              parameters: any(
                that: allOf([
                  containsPair('action', 'saved'),
                  containsPair('ticker', tTicker),
                  containsPair('is_subscribed', false),
                  containsPair('main_tabs', 'chat,fcps,reve,news'),
                  containsPair('more_tabs', 'free,divi,eps'),
                ]),
                named: 'parameters',
              ),
            ),
          ).called(1);
        },
      );

      test(
        'logEditTabsSaved_serviceThrowsException_catchesGracefully',
        () async {
          // arrange
          when(
            () => mockAnalyticsService.logEvent(
              name: any(named: 'name'),
              parameters: any(named: 'parameters'),
            ),
          ).thenThrow(Exception('Analytics failure'));

          // act
          final future = sut.logEditTabsSaved(
            ticker: tTicker,
            isSubscribed: true,
            mainTabs: const ['chat'],
            moreTabs: const ['news'],
          );

          // assert
          await expectLater(future, completes);
        },
      );
    });
  });
}
