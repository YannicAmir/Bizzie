import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/company_profile/cp/presentation/analytics/company_profile_analytics.dart';
import 'package:bizzie/features/company_profile/cp/presentation/analytics/company_profile_session_summary.dart';
import 'package:bizzie/features/company_profile/cp/presentation/enums/company_profile_tour_step.dart';
import 'package:bizzie/features/company_profile/shared/presentation/enums/growth_band.dart';
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

    group('tour', () {
      test('logTourStarted_ticker_logsTourStartedWithTicker', () async {
        // arrange
        const tExpectedScreenName = 'company_profile';

        // act
        await sut.logTourStarted(ticker: tTicker);

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'cp_tour_started',
            parameters: any(
              that: allOf([
                containsPair('ticker', tTicker),
                containsPair('screen_name', tExpectedScreenName),
              ]),
              named: 'parameters',
            ),
          ),
        ).called(1);
      });

      test('logTourStepViewed_eachStep_logsIndexAndName', () async {
        // arrange
        const tExpected = {
          CompanyProfileTourStep.companyOverview: (1, 'company_overview'),
          CompanyProfileTourStep.tabs: (2, 'tabs'),
          CompanyProfileTourStep.revenueTab: (3, 'revenue_tab'),
          CompanyProfileTourStep.revenueGrowth: (4, 'revenue_growth'),
          CompanyProfileTourStep.stayUpdated: (5, 'stay_updated'),
        };

        for (final entry in tExpected.entries) {
          // act
          await sut.logTourStepViewed(step: entry.key);

          // assert
          verify(
            () => mockAnalyticsService.logEvent(
              name: 'cp_tour_step_viewed',
              parameters: any(
                that: allOf([
                  containsPair('step_index', entry.value.$1),
                  containsPair('step_name', entry.value.$2),
                ]),
                named: 'parameters',
              ),
            ),
          ).called(1);
        }
      });

      test('logTourCompleted_ticker_logsTourCompletedWithTicker', () async {
        // arrange
        final tExpectedTicker = tLongTicker.substring(0, 24);

        // act
        await sut.logTourCompleted(ticker: tLongTicker);

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: 'cp_tour_completed',
            parameters: any(
              that: containsPair('ticker', tExpectedTicker),
              named: 'parameters',
            ),
          ),
        ).called(1);
      });

      test('logTourSkipped_eachStep_logsIndexAndName', () async {
        // arrange
        const tExpected = {
          CompanyProfileTourStep.companyOverview: (1, 'company_overview'),
          CompanyProfileTourStep.tabs: (2, 'tabs'),
          CompanyProfileTourStep.revenueTab: (3, 'revenue_tab'),
          CompanyProfileTourStep.revenueGrowth: (4, 'revenue_growth'),
          CompanyProfileTourStep.stayUpdated: (5, 'stay_updated'),
        };

        for (final entry in tExpected.entries) {
          // act
          await sut.logTourSkipped(step: entry.key);

          // assert
          verify(
            () => mockAnalyticsService.logEvent(
              name: 'cp_tour_skipped',
              parameters: any(
                that: allOf([
                  containsPair('step_index', entry.value.$1),
                  containsPair('step_name', entry.value.$2),
                ]),
                named: 'parameters',
              ),
            ),
          ).called(1);
        }
      });

      test('logTourRevenueGrowthBandShown_eachBand_logsBandAndYears', () async {
        // arrange
        const tExpected = {
          GrowthBand.negative: 'negative',
          GrowthBand.low: 'low',
          GrowthBand.moderate: 'moderate',
          GrowthBand.high: 'high',
          GrowthBand.turnedPositive: 'turned_positive',
          GrowthBand.turnedNegative: 'turned_negative',
        };
        const tYears = 5;

        for (final entry in tExpected.entries) {
          // act
          await sut.logTourRevenueGrowthBandShown(
            band: entry.key,
            years: tYears,
          );

          // assert
          verify(
            () => mockAnalyticsService.logEvent(
              name: 'cp_tour_revenue_growth_band_shown',
              parameters: any(
                that: allOf([
                  containsPair('band', entry.value),
                  containsPair('years', tYears),
                ]),
                named: 'parameters',
              ),
            ),
          ).called(1);
        }
      });

      test('logTourStarted_serviceThrowsException_catchesGracefully', () async {
        // arrange
        when(
          () => mockAnalyticsService.logEvent(
            name: any(named: 'name'),
            parameters: any(named: 'parameters'),
          ),
        ).thenThrow(Exception('Analytics failure'));

        // act
        final future = sut.logTourStarted(ticker: tTicker);

        // assert
        await expectLater(future, completes);
      });
    });
  });
}
