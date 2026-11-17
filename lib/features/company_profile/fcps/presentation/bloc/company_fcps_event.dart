import 'package:bizzie/core/enums/financial_period.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_fcps_event.freezed.dart';

@freezed
sealed class CompanyFcpsEvent with _$CompanyFcpsEvent {
  const factory CompanyFcpsEvent.loadRequested(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadRequested;

  const factory CompanyFcpsEvent.stalenessCheckRequested(String ticker) =
      StalenessCheckRequested;

  const factory CompanyFcpsEvent.tabShown(String ticker) = TabShown;
  const factory CompanyFcpsEvent.tabHidden() = TabHidden;
  const factory CompanyFcpsEvent.appBackgrounded() = AppBackgrounded;
  const factory CompanyFcpsEvent.appForegrounded() = AppForegrounded;
  const factory CompanyFcpsEvent.periodChanged({
    required FinancialPeriod period,
  }) = PeriodChanged;
  const factory CompanyFcpsEvent.viewAllTapped({
    required FinancialPeriod period,
    required bool isChart,
  }) = ViewAllTapped;
  const factory CompanyFcpsEvent.reset() = Reset;
}
