import 'package:bizzie/features/company_profile/net_income/presentation/bloc/company_net_income_state.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';

extension CompanyNetIncomeLoadedX on CompanyNetIncomeLoaded {
  List<ChartDataPoint> get activeChartData =>
      isAnnualView ? annualChartData : quarterlyChartData;
}
