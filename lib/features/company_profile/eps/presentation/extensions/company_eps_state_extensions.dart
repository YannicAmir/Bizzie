import 'package:bizzie/features/company_profile/eps/presentation/bloc/company_eps_state.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';

extension CompanyEpsLoadedX on CompanyEpsLoaded {
  List<ChartDataPoint> get activeChartData =>
      isAnnualView ? annualChartData : quarterlyChartData;
}
