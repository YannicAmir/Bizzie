import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/revenue/domain/models/revenue_stats.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/revenue/presentation/analytics/revenue_tab_view_state.dart';

part 'company_revenue_state.freezed.dart';

@freezed
class CompanyRevenueState with _$CompanyRevenueState {
  const factory CompanyRevenueState.initial() = _Initial;
  const factory CompanyRevenueState.loading() = _Loading;
  const factory CompanyRevenueState.loaded({
    required String ticker,
    required RevenueStats revenueStats,
    required List<ChartDataPoint> annualChartData,
    required List<ChartDataPoint> quarterlyChartData,
    required int historyLimit,
    required CompanyProfileDataOrigin dataOrigin,
    DateTime? lastUpdated,
    RevenueTabViewState? analyticsState,
  }) = _Loaded;
  const factory CompanyRevenueState.failure(Failure failure) = _Failure;
}
