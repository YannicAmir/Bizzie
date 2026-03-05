import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_eps_event.freezed.dart';

@freezed
abstract class CompanyEpsEvent with _$CompanyEpsEvent {
  const factory CompanyEpsEvent.loadRequested(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadRequested;

  const factory CompanyEpsEvent.stalenessCheckRequested(String ticker) =
      StalenessCheckRequested;

  const factory CompanyEpsEvent.tabShown(String ticker) = TabShown;
  const factory CompanyEpsEvent.tabHidden() = TabHidden;
  const factory CompanyEpsEvent.appBackgrounded() = AppBackgrounded;
  const factory CompanyEpsEvent.appForegrounded() = AppForegrounded;

  const factory CompanyEpsEvent.periodViewed({required bool isAnnual}) =
      PeriodViewed;

  const factory CompanyEpsEvent.viewAllTapped({
    required bool isAnnual,
    required bool isChart,
  }) = ViewAllTapped;
}
