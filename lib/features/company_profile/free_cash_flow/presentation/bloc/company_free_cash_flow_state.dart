import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import '../../domain/models/free_cash_flow_stats.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/free_cash_flow/presentation/analytics/free_cash_flow_tab_view_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_free_cash_flow_state.freezed.dart';

@freezed
abstract class CompanyFreeCashFlowState with _$CompanyFreeCashFlowState {
  const factory CompanyFreeCashFlowState.initial() = _Initial;
  const factory CompanyFreeCashFlowState.loading() = _Loading;
  const factory CompanyFreeCashFlowState.loaded({
    required String ticker,
    required FreeCashFlowStats fcfStats,
    required List<ChartDataPoint> annualChartData,
    required List<ChartDataPoint> quarterlyChartData,
    required int historyLimit,
    required CompanyProfileDataOrigin dataOrigin,
    DateTime? lastUpdated,
    FreeCashFlowTabViewState? analyticsState,
  }) = _Loaded;
  const factory CompanyFreeCashFlowState.failure(Failure failure) = _Failure;
}
