import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/net_income/domain/models/net_income_stats.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_net_income_state.freezed.dart';

@freezed
class CompanyNetIncomeState with _$CompanyNetIncomeState {
  const factory CompanyNetIncomeState.initial() = _Initial;
  const factory CompanyNetIncomeState.loading() = _Loading;
  const factory CompanyNetIncomeState.loaded({
    required NetIncomeStats netIncomeStats,
    required List<ChartDataPoint> annualChartData,
    required List<ChartDataPoint> quarterlyChartData,
    DateTime? lastUpdated,
  }) = _Loaded;
  const factory CompanyNetIncomeState.failure(Failure failure) = _Failure;
}
