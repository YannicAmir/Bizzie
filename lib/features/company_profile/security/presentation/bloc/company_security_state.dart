import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/security/domain/models/security_details.dart';
import 'package:bizzie/features/company_profile/security/presentation/analytics/security_tab_analytics.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_security_state.freezed.dart';

@freezed
abstract class CompanySecurityState with _$CompanySecurityState {
  const factory CompanySecurityState.initial() = _Initial;
  const factory CompanySecurityState.loading() = _Loading;
  const factory CompanySecurityState.loaded(
    SecurityDetails securityDetails, {
    required SecurityTabViewState analyticsState,
    DateTime? lastUpdated,
  }) = SecurityLoaded;
  const factory CompanySecurityState.unsupported(
    SecurityDetails securityDetails, {
    required SecurityTabViewState analyticsState,
  }) = SecurityUnsupported;
  const factory CompanySecurityState.failure(Failure failure) = _Failure;
}
