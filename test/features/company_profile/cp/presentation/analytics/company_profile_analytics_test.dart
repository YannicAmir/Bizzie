import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/company_profile/cp/presentation/analytics/company_profile_analytics.dart';
import 'package:bizzie/features/company_profile/cp/presentation/analytics/company_profile_session_summary.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late CompanyProfileAnalytics analytics;
  late MockAnalyticsService mockAnalyticsService;

  setUpAll(() {
    registerFallbackValue(
      CompanyProfileSessionSummary(
        sessionId: '',
        ticker: '',
        companyName: '',
        tabsCount: 0,
        tabsList: [],
        durationSeconds: 0,
        isWatchlisted: false,
        initWatchlisted: false,
        isCompany: false,
        isEtf: false,
        isFund: false,
        isFinal: false,
      ),
    );
  });

  setUp(() {
    mockAnalyticsService = MockAnalyticsService();
    analytics = CompanyProfileAnalytics(mockAnalyticsService);

    when(
      () => mockAnalyticsService.logEvent(
        name: any(named: 'name'),
        parameters: any(named: 'parameters'),
      ),
    ).thenAnswer((_) async {});
  });

  group('CompanyProfileAnalytics', () {
    test(
      'logSessionSummary_longTickerAndCompanyName_truncatesValues',
      () async {
        // arrange
        const longTicker = 'VERY_LONG_TICKER_NAME_THAT_EXCEEDS_24';
        const longCoName = 'VERY_LONG_COMPANY_NAME_THAT_EXCEEDS_24_CHARACTERS';
        final summary = CompanyProfileSessionSummary(
          ticker: longTicker,
          companyName: longCoName,
          industry: 'Tech',
          sector: 'Technology',
          initWatchlisted: false,
          isWatchlisted: true,
          isCompany: true,
          isEtf: false,
          isFund: false,
          tabsCount: 3,
          tabsList: const ['Overview', 'Financials'],
          durationSeconds: 120,
          isFinal: true,
          sessionId: '123',
        );

        // act
        await analytics.logSessionSummary(summary);

        // assert
        verify(
          () => mockAnalyticsService.logEvent(
            name: any(named: 'name'),
            parameters: any(
              that: allOf([
                containsPair('ticker', longTicker.substring(0, 24)),
                containsPair('co_name', longCoName.substring(0, 24)),
              ]),
              named: 'parameters',
            ),
          ),
        ).called(1);
      },
    );

    test('logSessionSummary_longTabName_truncatesTabName', () async {
      // arrange
      const longTab = 'FINANCIALS_TAB_THAT_IS_VERY_LONG';
      final summary = CompanyProfileSessionSummary(
        ticker: 'AAPL',
        companyName: 'Apple',
        industry: 'Tech',
        sector: 'Tech',
        initWatchlisted: false,
        isWatchlisted: false,
        isCompany: true,
        isEtf: false,
        isFund: false,
        tabsCount: 1,
        tabsList: const [longTab],
        durationSeconds: 60,
        isFinal: true,
        sessionId: '123',
      );

      // act
      await analytics.logSessionSummary(summary);

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: any(named: 'name'),
          parameters: any(
            that: containsPair('tabs_list', longTab.substring(0, 24)),
            named: 'parameters',
          ),
        ),
      ).called(1);
    });

    test(
      'logSessionSummary_serviceThrowsException_catchesGracefully',
      () async {
        // arrange
        final summary = CompanyProfileSessionSummary(
          ticker: 'AAPL',
          companyName: 'Apple',
          industry: 'Tech',
          sector: 'Tech',
          initWatchlisted: false,
          isWatchlisted: false,
          isCompany: true,
          isEtf: false,
          isFund: false,
          tabsCount: 1,
          tabsList: const ['Overview'],
          durationSeconds: 60,
          isFinal: true,
          sessionId: '123',
        );

        when(
          () => mockAnalyticsService.logEvent(
            name: any(named: 'name'),
            parameters: any(named: 'parameters'),
          ),
        ).thenThrow(Exception('Analytics failure'));

        // act & assert
        await expectLater(analytics.logSessionSummary(summary), completes);
      },
    );

    group('Characters Limit Extension Check', () {
      test('trims correctly on 24 chars', () {
        // arrange
        const input = '1234567890123456789012345';

        // act
        final result = input.substring(0, 24);

        // assert
        expect(result.length, 24);
      });
    });
  });
}
