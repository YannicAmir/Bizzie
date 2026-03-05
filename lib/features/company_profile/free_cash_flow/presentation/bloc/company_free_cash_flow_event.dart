import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_free_cash_flow_event.freezed.dart';

@freezed
abstract class CompanyFreeCashFlowEvent with _$CompanyFreeCashFlowEvent {
  const factory CompanyFreeCashFlowEvent.loadRequested(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadRequested;

  const factory CompanyFreeCashFlowEvent.stalenessCheckRequested(
    String ticker,
  ) = StalenessCheckRequested;

  const factory CompanyFreeCashFlowEvent.tabShown(String ticker) = TabShown;
  const factory CompanyFreeCashFlowEvent.tabHidden() = TabHidden;
  const factory CompanyFreeCashFlowEvent.appBackgrounded() = AppBackgrounded;
  const factory CompanyFreeCashFlowEvent.appForegrounded() = AppForegrounded;

  const factory CompanyFreeCashFlowEvent.periodViewed({
    required bool isAnnual,
  }) = PeriodViewed;
  const factory CompanyFreeCashFlowEvent.viewAllTapped({
    required bool isAnnual,
    required bool isChart,
  }) = ViewAllTapped;
}
