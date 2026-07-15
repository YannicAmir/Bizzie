import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_geographic_segments.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_product_segments.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_segment.dart';
import 'package:bizzie/features/company_profile/segments/presentation/bloc/company_segments_state.dart';
import 'package:bizzie/features/company_profile/segments/presentation/extensions/company_segments_state_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

const tTicker = 'AAPL';
const tCurrency = 'USD';

const tProductAnnual2025 = RevenueSegment(
  date: '2025-09-27',
  fiscalYear: 2025,
  period: 'FY',
  reportedCurrency: tCurrency,
  data: {'iPhone': 200.0, 'Mac': 50.0},
);

const tProductAnnual2024 = RevenueSegment(
  date: '2024-09-28',
  fiscalYear: 2024,
  period: 'FY',
  reportedCurrency: tCurrency,
  data: {'iPhone': 180.0, 'Mac': 60.0, 'iPod': 5.0},
);

const tProductQuarter = RevenueSegment(
  date: '2026-03-28',
  fiscalYear: 2026,
  period: 'Q2',
  reportedCurrency: tCurrency,
  data: {'iPhone': 90.0},
);

const tGeographicAnnual2025 = RevenueSegment(
  date: '2025-09-27',
  fiscalYear: 2025,
  period: 'FY',
  reportedCurrency: tCurrency,
  data: {'Americas': 150.0},
);

CompanySegmentsLoaded buildLoadedState({
  String productCurrency = tCurrency,
  String geographicCurrency = tCurrency,
}) {
  return CompanySegmentsState.loaded(
        ticker: tTicker,
        productSegments: RevenueProductSegments(
          symbol: tTicker,
          reportedCurrency: productCurrency,
          annual: const [tProductAnnual2025, tProductAnnual2024],
          quarterly: const [tProductQuarter],
        ),
        geographicSegments: RevenueGeographicSegments(
          symbol: tTicker,
          reportedCurrency: geographicCurrency,
          annual: const [tGeographicAnnual2025],
          quarterly: const [],
        ),
        annualPeriodKeys: const ['2025', '2024'],
        quarterlyPeriodKeys: const ['Q2 2026'],
        productColorIndices: const {'iPhone': 0, 'Mac': 1, 'iPod': 2},
        geographicColorIndices: const {'Americas': 0},
        historyLimit: 7,
        dataOrigin: CompanyProfileDataOrigin.api,
        selectedAnnualKey: '2025',
        selectedQuarterlyKey: 'Q2 2026',
      )
      as CompanySegmentsLoaded;
}

void main() {
  group('CompanySegmentsLoadedX', () {
    test('selectedKey_annualAndQuarterly_returnsRespectiveSelection', () {
      // arrange
      final state = buildLoadedState();

      // act
      final annualKey = state.selectedKey(isAnnual: true);
      final quarterlyKey = state.selectedKey(isAnnual: false);

      // assert
      expect(annualKey, '2025');
      expect(quarterlyKey, 'Q2 2026');
    });

    test('periodKeys_annualAndQuarterly_returnsRespectiveLists', () {
      // arrange
      final state = buildLoadedState();

      // act
      final annualKeys = state.periodKeys(isAnnual: true);
      final quarterlyKeys = state.periodKeys(isAnnual: false);

      // assert
      expect(annualKeys, ['2025', '2024']);
      expect(quarterlyKeys, ['Q2 2026']);
    });

    test('reportedCurrency_productCurrencyPresent_prefersProductCurrency', () {
      // arrange
      final state = buildLoadedState(
        productCurrency: 'EUR',
        geographicCurrency: 'USD',
      );

      // act
      final currency = state.reportedCurrency;

      // assert
      expect(currency, 'EUR');
    });

    test('reportedCurrency_productCurrencyEmpty_fallsBackToGeographic', () {
      // arrange
      final state = buildLoadedState(
        productCurrency: '',
        geographicCurrency: 'JPY',
      );

      // act
      final currency = state.reportedCurrency;

      // assert
      expect(currency, 'JPY');
    });

    test('productSegmentForKey_existingAnnualKey_returnsSegment', () {
      // arrange
      final state = buildLoadedState();

      // act
      final segment = state.productSegmentForKey('2024', isAnnual: true);

      // assert
      expect(segment, tProductAnnual2024);
    });

    test('productSegmentForKey_existingQuarterlyKey_returnsSegment', () {
      // arrange
      final state = buildLoadedState();

      // act
      final segment = state.productSegmentForKey('Q2 2026', isAnnual: false);

      // assert
      expect(segment, tProductQuarter);
    });

    test('productSegmentForKey_unknownOrNullKey_returnsNull', () {
      // arrange
      final state = buildLoadedState();

      // act
      final unknown = state.productSegmentForKey('1999', isAnnual: true);
      final nullKey = state.productSegmentForKey(null, isAnnual: true);

      // assert
      expect(unknown, isNull);
      expect(nullKey, isNull);
    });

    test('geographicSegmentForKey_existingAnnualKey_returnsSegment', () {
      // arrange
      final state = buildLoadedState();

      // act
      final segment = state.geographicSegmentForKey('2025', isAnnual: true);

      // assert
      expect(segment, tGeographicAnnual2025);
    });

    test('geographicSegmentForKey_unknownKey_returnsNull', () {
      // arrange
      final state = buildLoadedState();

      // act
      final segment = state.geographicSegmentForKey('Q1 2020', isAnnual: false);

      // assert
      expect(segment, isNull);
    });

    test('pairLabel_previousPeriodExists_returnsPairedLabel', () {
      // arrange
      final state = buildLoadedState();

      // act
      final label = state.pairLabel('2025', isAnnual: true);

      // assert
      expect(label, '2025, 2024');
    });

    test('pairLabel_previousPeriodMissing_returnsSingleLabel', () {
      // arrange
      final state = buildLoadedState();

      // act
      final annualLabel = state.pairLabel('2024', isAnnual: true);
      final quarterlyLabel = state.pairLabel('Q2 2026', isAnnual: false);

      // assert
      expect(annualLabel, '2024');
      expect(quarterlyLabel, 'Q2 2026');
    });
  });
}
