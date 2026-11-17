import 'package:bizzie/core/enums/financial_period.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/shares/domain/models/shares_summary_data.dart';
import 'package:bizzie/features/company_profile/shares/presentation/bloc/company_shares_state.dart';

extension CompanySharesLoadedX on CompanySharesLoaded {
  List<ChartDataPoint> get activeChartData => switch (period) {
    FinancialPeriod.annual => annualChartData,
    FinancialPeriod.quarterly => quarterlyChartData,
  };

  SharesSummaryData get activeSummary => switch (period) {
    FinancialPeriod.annual => annualSummary,
    FinancialPeriod.quarterly => quarterlySummary,
  };

  List<FinancialDataPoint> get activeTableData => switch (period) {
    FinancialPeriod.annual => shareStats.annualWeightedAverageShares,
    FinancialPeriod.quarterly => shareStats.quarterlyWeightedAverageShares,
  };
}
