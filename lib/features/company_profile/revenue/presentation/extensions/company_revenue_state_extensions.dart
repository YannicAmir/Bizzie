import 'package:bizzie/features/company_profile/revenue/presentation/bloc/company_revenue_state.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';

extension CompanyRevenueLoadedX on CompanyRevenueLoaded {
  List<ChartDataPoint> get activeChartData =>
      isAnnualView ? annualChartData : quarterlyChartData;
}
