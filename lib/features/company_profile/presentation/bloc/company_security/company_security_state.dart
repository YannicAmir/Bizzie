import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/features/company_profile/domain/models/security_details.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_security_state.freezed.dart';

@freezed
class CompanySecurityState with _$CompanySecurityState {
  const factory CompanySecurityState.initial() = _Initial;
  const factory CompanySecurityState.loading() = _Loading;
  const factory CompanySecurityState.loaded(
    SecurityDetails securityDetails, {
    DateTime? lastUpdated,
  }) = _Loaded;
  const factory CompanySecurityState.unsupported(
    SecurityDetails securityDetails,
  ) = _Unsupported;
  const factory CompanySecurityState.failure(Failure failure) = _Failure;
}
