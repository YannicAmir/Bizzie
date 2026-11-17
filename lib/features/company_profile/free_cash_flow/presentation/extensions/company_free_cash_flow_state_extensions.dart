import 'package:bizzie/core/enums/financial_period.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/presentation/bloc/company_free_cash_flow_state.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';

extension CompanyFreeCashFlowLoadedX on CompanyFreeCashFlowLoaded {
  List<ChartDataPoint> get activeChartData => switch (period) {
    FinancialPeriod.annual => annualChartData,
    FinancialPeriod.quarterly => quarterlyChartData,
  };
}
