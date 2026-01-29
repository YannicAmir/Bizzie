import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_dividends_event.freezed.dart';

@freezed
sealed class CompanyDividendsEvent with _$CompanyDividendsEvent {
  const factory CompanyDividendsEvent.loadRequested(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadRequested;

  const factory CompanyDividendsEvent.stalenessCheckRequested(String ticker) =
      StalenessCheckRequested;
}
