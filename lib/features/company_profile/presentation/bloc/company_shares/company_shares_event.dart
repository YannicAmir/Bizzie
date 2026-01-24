import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_shares_event.freezed.dart';

@freezed
abstract class CompanySharesEvent with _$CompanySharesEvent {
  const factory CompanySharesEvent.loadRequested(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadRequested;

  const factory CompanySharesEvent.stalenessCheckRequested(String ticker) =
      StalenessCheckRequested;
}
