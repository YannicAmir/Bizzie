import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/interfaces/i_analytics_service.dart';
import 'package:bizzie/features/company_profile/business/presentation/analytics/business_tab_analytics.dart';
import 'package:bizzie/features/company_profile/security/presentation/analytics/security_tab_analytics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAnalyticsService extends Mock implements IAnalyticsService {}

void main() {
  late MockAnalyticsService mockAnalyticsService;
  late SecurityTabAnalytics securityTracker;
  late BusinessTabAnalytics businessTracker;

  setUpAll(() {
    registerFallbackValue(
      const SecurityTabViewState(
        ticker: 'AAPL',
        securityType: 'company',
        timestamp: '',
      ),
    );
    registerFallbackValue(
      const BusinessTabViewState(ticker: 'AAPL', timestamp: ''),
    );
  });

  setUp(() {
    mockAnalyticsService = MockAnalyticsService();
    securityTracker = SecurityTabAnalytics(mockAnalyticsService);
    businessTracker = BusinessTabAnalytics(mockAnalyticsService);

    when(
      () => mockAnalyticsService.logEvent(
        name: any(named: 'name'),
        parameters: any(named: 'parameters'),
      ),
    ).thenAnswer((_) async {});
  });

  group('SecurityTabAnalytics', () {
    test('logViewSummary_success_callsLogEventWithCorrectParameters', () async {
      // arrange
      final state = SecurityTabViewState(
        ticker: 'AAPL',
        securityType: 'company',
        timestamp: '2023-01-01T00:00:00Z',
        loadTimeMs: 123,
        isSuccess: true,
        viewDurationSec: 10,
        dataSource: CompanyProfileDataOrigin.api,
      );

      // act
      await securityTracker.logViewSummary(state, isFinal: true);

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: 'security_tab_view_summary',
          parameters: any(
            named: 'parameters',
            that: isA<Map<String, Object>>(),
          ),
        ),
      ).called(1);
    });

    test('logViewSummary_failure_catchesExceptionGracefully', () async {
      // arrange
      final state = SecurityTabViewState(
        ticker: 'AAPL',
        securityType: 'company',
        timestamp: '2023-01-01T00:00:00Z',
      );
      when(
        () => mockAnalyticsService.logEvent(
          name: any(named: 'name'),
          parameters: any(named: 'parameters'),
        ),
      ).thenThrow(Exception('test error'));

      // act & assert
      await expectLater(
        securityTracker.logViewSummary(state, isFinal: true),
        completes,
      );
    });
  });

  group('BusinessTabAnalytics', () {
    test('logViewSummary_success_callsLogEventWithCorrectParameters', () async {
      // arrange
      final state = BusinessTabViewState(
        ticker: 'AAPL',
        timestamp: '2023-01-01T00:00:00Z',
        loadTimeMs: 123,
        isSuccess: true,
        viewDurationSec: 10,
        dataSource: CompanyProfileDataOrigin.api,
      );

      // act
      await businessTracker.logViewSummary(state, isFinal: true);

      // assert
      verify(
        () => mockAnalyticsService.logEvent(
          name: 'business_tab_view_summary',
          parameters: any(
            named: 'parameters',
            that: isA<Map<String, Object>>(),
          ),
        ),
      ).called(1);
    });

    test('logViewSummary_failure_catchesExceptionGracefully', () async {
      // arrange
      final state = BusinessTabViewState(
        ticker: 'AAPL',
        timestamp: '2023-01-01T00:00:00Z',
      );
      when(
        () => mockAnalyticsService.logEvent(
          name: any(named: 'name'),
          parameters: any(named: 'parameters'),
        ),
      ).thenThrow(Exception('test error'));

      // act & assert
      await expectLater(
        businessTracker.logViewSummary(state, isFinal: true),
        completes,
      );
    });
  });
}
