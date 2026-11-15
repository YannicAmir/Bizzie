import 'package:bizzie/core/enums/financial_period.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_shares_event.freezed.dart';

@freezed
sealed class CompanySharesEvent with _$CompanySharesEvent {
  const factory CompanySharesEvent.loadRequested(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadRequested;

  const factory CompanySharesEvent.stalenessCheckRequested(String ticker) =
      StalenessCheckRequested;

  const factory CompanySharesEvent.tabShown(String ticker) = TabShown;

  const factory CompanySharesEvent.tabHidden() = TabHidden;

  const factory CompanySharesEvent.appBackgrounded() = AppBackgrounded;

  const factory CompanySharesEvent.appForegrounded() = AppForegrounded;

  const factory CompanySharesEvent.periodChanged({
    required FinancialPeriod period,
  }) = PeriodChanged;

  const factory CompanySharesEvent.viewAllTapped({
    required FinancialPeriod period,
    required bool isChart,
  }) = ViewAllTapped;

  const factory CompanySharesEvent.reset() = Reset;
}
