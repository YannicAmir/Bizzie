import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/business/domain/models/business_profile.dart';
import 'package:bizzie/features/company_profile/business/presentation/analytics/business_tab_analytics.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_business_state.freezed.dart';

@freezed
abstract class CompanyBusinessState with _$CompanyBusinessState {
  const factory CompanyBusinessState.initial() = _Initial;
  const factory CompanyBusinessState.loading() = _Loading;
  const factory CompanyBusinessState.loaded(
    BusinessProfile businessProfile, {
    required int historyLimit,
    required BusinessTabViewState analyticsState,
    DateTime? lastUpdated,
  }) = _Loaded;
  const factory CompanyBusinessState.failure(Failure failure) = _Failure;
}
