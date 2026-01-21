import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/domain/models/company_ratios.dart';
import 'package:bizzie/features/company_profile/domain/models/key_metrics.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_more_state.freezed.dart';

enum MoreDataStatus { initial, loading, success, failure }

@freezed
abstract class CompanyMoreState with _$CompanyMoreState {
  const factory CompanyMoreState({
    @Default(MoreDataStatus.initial) MoreDataStatus ratiosStatus,
    @Default([]) List<CompanyRatios> ratios,
    Failure? ratiosError,
    DateTime? ratiosLastUpdated,

    @Default(MoreDataStatus.initial) MoreDataStatus keyMetricsStatus,
    @Default([]) List<KeyMetrics> keyMetrics,
    Failure? keyMetricsError,
    DateTime? keyMetricsLastUpdated,
  }) = _CompanyMoreState;
}
