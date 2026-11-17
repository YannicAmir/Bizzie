import 'package:bizzie/core/enums/financial_period.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_state.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/presentation/utils/financial_highlights_resolver.dart';

extension CompanyRevenueLoadedX on CompanyRevenueLoaded {
  List<ChartDataPoint> get activeChartData => switch (period) {
    FinancialPeriod.annual => annualChartData,
    FinancialPeriod.quarterly => quarterlyChartData,
  };

  GrowthHighlight? get annualGrowthHighlight => annualChartData.isEmpty
      ? null
      : FinancialHighlightsResolver.resolveAnnualGrowth(
          annualData: revenueStats.annualRevenue,
          quarterlyData: revenueStats.quarterlyRevenue,
        );
}
