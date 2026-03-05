import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/financial_data_point.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:bizzie/features/company_profile/roe/presentation/analytics/roe_tab_view_state.dart';

part 'company_roe_state.freezed.dart';

@freezed
class CompanyRoeState with _$CompanyRoeState {
  const factory CompanyRoeState.initial() = _Initial;
  const factory CompanyRoeState.loading() = _Loading;
  const factory CompanyRoeState.loaded({
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
    RoeTabViewState? analyticsState,
  }) = _Loaded;
  const factory CompanyRoeState.failure(Failure failure) = _Failure;
}
