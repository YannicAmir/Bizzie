import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_fcps_event.freezed.dart';

@freezed
abstract class CompanyFcpsEvent with _$CompanyFcpsEvent {
  const factory CompanyFcpsEvent.loadRequested(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadRequested;

  const factory CompanyFcpsEvent.stalenessCheckRequested(String ticker) =
      StalenessCheckRequested;
}
