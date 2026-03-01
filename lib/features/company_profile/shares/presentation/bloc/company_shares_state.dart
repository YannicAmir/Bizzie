import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/shares/domain/models/shares_summary_data.dart';
import 'package:bizzie/features/company_profile/shares/domain/models/share_stats.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/shares/presentation/analytics/shares_tab_view_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_shares_state.freezed.dart';

@freezed
class CompanySharesState with _$CompanySharesState {
  const factory CompanySharesState.initial() = _Initial;
  const factory CompanySharesState.loading() = _Loading;
  const factory CompanySharesState.loaded({
    required String ticker,
    required ShareStats shareStats,
    required List<ChartDataPoint> annualChartData,
    required List<ChartDataPoint> quarterlyChartData,
    required SharesSummaryData annualSummary,
    required SharesSummaryData quarterlySummary,
    required int historyLimit,
    required CompanyProfileDataOrigin dataOrigin,
    DateTime? lastUpdated,
    SharesTabViewState? analyticsState,
  }) = _Loaded;
  const factory CompanySharesState.failure(Failure failure) = _Failure;
}
