import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/domain/models/financial_data_point.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_roe_state.freezed.dart';

@freezed
class CompanyRoeState with _$CompanyRoeState {
  const factory CompanyRoeState.initial() = _Initial;
  const factory CompanyRoeState.loading() = _Loading;
  const factory CompanyRoeState.loaded({
    required List<FinancialDataPoint> dataPoints,
    required List<ChartDataPoint> chartData,
    required double currentValue,
    required double growthPercentage,
    required double absoluteDelta,
    required bool isPositive,
    required String referenceLabel,
    DateTime? lastUpdated,
  }) = _Loaded;
  const factory CompanyRoeState.failure(Failure failure) = _Failure;
}
