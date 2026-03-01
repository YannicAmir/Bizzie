import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/shared/domain/models/chart_data_point.dart';
import '../../domain/models/fcps_stats.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/fcps/presentation/analytics/fcps_tab_view_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_fcps_state.freezed.dart';

@freezed
class CompanyFcpsState with _$CompanyFcpsState {
  const factory CompanyFcpsState.initial() = _Initial;
  const factory CompanyFcpsState.loading() = _Loading;
  const factory CompanyFcpsState.loaded({
    required String ticker,
    required FcpsStats fcpsStats,
    required List<ChartDataPoint> annualChartData,
    required List<ChartDataPoint> quarterlyChartData,
    required int historyLimit,
    required CompanyProfileDataOrigin dataOrigin,
    DateTime? lastUpdated,
    FcpsTabViewState? analyticsState,
  }) = _Loaded;
  const factory CompanyFcpsState.failure(Failure failure) = _Failure;
}
