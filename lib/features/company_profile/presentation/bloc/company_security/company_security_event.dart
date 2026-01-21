import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_security_event.freezed.dart';

@freezed
sealed class CompanySecurityEvent with _$CompanySecurityEvent {
  const factory CompanySecurityEvent.loadRequested(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadRequested;

  const factory CompanySecurityEvent.stalenessCheckRequested(String ticker) =
      StalenessCheckRequested;
}
