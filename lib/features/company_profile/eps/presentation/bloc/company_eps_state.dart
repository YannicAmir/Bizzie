import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import 'package:bizzie/features/company_profile/eps/domain/models/eps_stats.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:bizzie/features/company_profile/eps/presentation/analytics/eps_tab_view_state.dart';

part 'company_eps_state.freezed.dart';

@freezed
abstract class CompanyEpsState with _$CompanyEpsState {
  const factory CompanyEpsState.initial() = _Initial;
  const factory CompanyEpsState.loading() = _Loading;
  const factory CompanyEpsState.loaded({
    required String ticker,
    required EpsStats epsStats,
    required List<ChartDataPoint> annualChartData,
    required List<ChartDataPoint> quarterlyChartData,
    required int historyLimit,
    required CompanyProfileDataOrigin dataOrigin,
    DateTime? lastUpdated,
    EpsTabViewState? analyticsState,
  }) = _Loaded;
  const factory CompanyEpsState.failure(Failure failure) = _Failure;
}
