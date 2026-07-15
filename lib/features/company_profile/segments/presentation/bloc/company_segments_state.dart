import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_geographic_segments.dart';
import 'package:bizzie/features/company_profile/segments/domain/models/revenue_product_segments.dart';
import 'package:bizzie/features/company_profile/segments/presentation/analytics/segments_tab_view_state.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_segments_state.freezed.dart';

@freezed
abstract class CompanySegmentsState with _$CompanySegmentsState {
  const factory CompanySegmentsState.initial() = _Initial;
  const factory CompanySegmentsState.loading() = _Loading;
  const factory CompanySegmentsState.loaded({
    required String ticker,
    required RevenueProductSegments productSegments,
    required RevenueGeographicSegments geographicSegments,
    required List<String> annualPeriodKeys,
    required List<String> quarterlyPeriodKeys,
    required Map<String, int> productColorIndices,
    required Map<String, int> geographicColorIndices,
    required int historyLimit,
    required CompanyProfileDataOrigin dataOrigin,
    @Default(true) bool isAnnualView,
    String? selectedAnnualKey,
    String? selectedQuarterlyKey,
    DateTime? lastUpdated,
    SegmentsTabViewState? analyticsState,
  }) = CompanySegmentsLoaded;
  const factory CompanySegmentsState.failure(Failure failure) = _Failure;
}
