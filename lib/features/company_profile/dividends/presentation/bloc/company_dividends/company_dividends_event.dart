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

  const factory CompanyDividendsEvent.tabShown(String ticker) = TabShown;
  const factory CompanyDividendsEvent.tabHidden() = TabHidden;
  const factory CompanyDividendsEvent.appBackgrounded() = AppBackgrounded;
  const factory CompanyDividendsEvent.appForegrounded() = AppForegrounded;

  const factory CompanyDividendsEvent.viewAllTapped({required bool isChart}) =
      ViewAllTapped;

  const factory CompanyDividendsEvent.reset() = Reset;
}
