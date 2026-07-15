import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/features/company_profile/pe_ratio/presentation/analytics/pe_ratio_tab_view_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_pe_ratio_state.freezed.dart';

@freezed
abstract class CompanyPeRatioState with _$CompanyPeRatioState {
  const factory CompanyPeRatioState.initial() = _Initial;
  const factory CompanyPeRatioState.loading() = _Loading;
  const factory CompanyPeRatioState.loaded({
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
    PeRatioTabViewState? analyticsState,
  }) = CompanyPeRatioLoaded;
  const factory CompanyPeRatioState.failure(Failure failure) = _Failure;
}
