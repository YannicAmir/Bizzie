import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_pe_ratio_state.freezed.dart';

@freezed
class CompanyPeRatioState with _$CompanyPeRatioState {
  const factory CompanyPeRatioState.initial() = _Initial;
  const factory CompanyPeRatioState.loading() = _Loading;
  const factory CompanyPeRatioState.loaded({
    required List<FinancialDataPoint> dataPoints,
    required List<ChartDataPoint> chartData,
    required double currentValue,
    required double growthPercentage,
    required double absoluteDelta,
    required bool isPositive,
    required String referenceLabel,
    required int historyLimit,
    DateTime? lastUpdated,
  }) = _Loaded;
  const factory CompanyPeRatioState.failure(Failure failure) = _Failure;
}
