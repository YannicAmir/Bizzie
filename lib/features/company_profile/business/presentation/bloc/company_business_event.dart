import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_business_event.freezed.dart';

@freezed
sealed class CompanyBusinessEvent with _$CompanyBusinessEvent {
  const factory CompanyBusinessEvent.loadRequested(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadRequested;

  const factory CompanyBusinessEvent.stalenessCheckRequested(String ticker) =
      StalenessCheckRequested;
}
