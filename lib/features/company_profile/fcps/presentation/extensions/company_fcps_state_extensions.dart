import 'package:bizzie/core/enums/financial_period.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/bloc/company_fcps_state.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';

extension CompanyFcpsLoadedX on CompanyFcpsLoaded {
  List<ChartDataPoint> get activeChartData => switch (period) {
    FinancialPeriod.annual => annualChartData,
    FinancialPeriod.quarterly => quarterlyChartData,
  };
}
