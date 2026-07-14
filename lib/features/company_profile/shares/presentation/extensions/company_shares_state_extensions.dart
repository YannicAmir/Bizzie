import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/shares/domain/models/shares_summary_data.dart';
import 'package:bizzie/features/company_profile/shares/presentation/bloc/company_shares_state.dart';

extension CompanySharesLoadedX on CompanySharesLoaded {
  List<ChartDataPoint> get activeChartData =>
      isAnnualView ? annualChartData : quarterlyChartData;

  SharesSummaryData get activeSummary =>
      isAnnualView ? annualSummary : quarterlySummary;

  List<FinancialDataPoint> get activeTableData => isAnnualView
      ? shareStats.annualWeightedAverageShares
      : shareStats.quarterlyWeightedAverageShares;
}
