import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_net_income_event.freezed.dart';

@freezed
sealed class CompanyNetIncomeEvent with _$CompanyNetIncomeEvent {
  const factory CompanyNetIncomeEvent.loadRequested(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadRequested;

  const factory CompanyNetIncomeEvent.stalenessCheckRequested(String ticker) =
      StalenessCheckRequested;

  const factory CompanyNetIncomeEvent.tabShown(String ticker) = TabShown;
  const factory CompanyNetIncomeEvent.tabHidden() = TabHidden;
  const factory CompanyNetIncomeEvent.appBackgrounded() = AppBackgrounded;
  const factory CompanyNetIncomeEvent.appForegrounded() = AppForegrounded;

  const factory CompanyNetIncomeEvent.periodChanged({required bool isAnnual}) =
      PeriodChanged;

  const factory CompanyNetIncomeEvent.viewAllTapped({
    required bool isAnnual,
    required bool isChart,
  }) = ViewAllTapped;

  const factory CompanyNetIncomeEvent.reset() = NetIncomeReset;
}
