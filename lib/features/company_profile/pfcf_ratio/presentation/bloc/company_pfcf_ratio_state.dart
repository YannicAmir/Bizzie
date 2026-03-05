import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/pfcf_ratio/presentation/analytics/pfcf_ratio_tab_view_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_pfcf_ratio_state.freezed.dart';

@freezed
class CompanyPfcfRatioState with _$CompanyPfcfRatioState {
  const factory CompanyPfcfRatioState.initial() = _Initial;
  const factory CompanyPfcfRatioState.loading() = _Loading;
  const factory CompanyPfcfRatioState.loaded({
    required String ticker,
    required List<FinancialDataPoint> dataPoints,
    required List<ChartDataPoint> chartData,
    required double currentValue,
    required double growthPercentage,
    required double absoluteDelta,
    required bool isPositive,
    required String referenceLabel,
    required int historyLimit,
    required CompanyProfileDataOrigin dataOrigin,
    int? loadTimeMs,
    @Default(false) bool isSuccess,
    DateTime? lastUpdated,
    PfcfRatioTabViewState? analyticsState,
  }) = _Loaded;
  const factory CompanyPfcfRatioState.failure(Failure failure) = _Failure;
}
