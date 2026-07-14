import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/net_income/domain/models/net_income_stats.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/net_income/presentation/analytics/net_income_tab_view_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_net_income_state.freezed.dart';

@freezed
abstract class CompanyNetIncomeState with _$CompanyNetIncomeState {
  const factory CompanyNetIncomeState.initial() = _Initial;
  const factory CompanyNetIncomeState.loading() = _Loading;
  const factory CompanyNetIncomeState.loaded({
    required String ticker,
    required NetIncomeStats netIncomeStats,
    required List<ChartDataPoint> annualChartData,
    required List<ChartDataPoint> quarterlyChartData,
    required int historyLimit,
    required CompanyProfileDataOrigin dataOrigin,
    @Default(true) bool isAnnualView,
    DateTime? lastUpdated,
    NetIncomeTabViewState? analyticsState,
  }) = CompanyNetIncomeLoaded;
  const factory CompanyNetIncomeState.failure(Failure failure) = _Failure;
}
