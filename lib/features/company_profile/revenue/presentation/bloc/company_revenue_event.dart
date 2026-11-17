import 'package:bizzie/core/enums/financial_period.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_revenue_event.freezed.dart';

@freezed
sealed class CompanyRevenueEvent with _$CompanyRevenueEvent {
  const factory CompanyRevenueEvent.loadRequested(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadRequested;

  const factory CompanyRevenueEvent.stalenessCheckRequested(String ticker) =
      StalenessCheckRequested;

  const factory CompanyRevenueEvent.tabShown(String ticker) = TabShown;

  const factory CompanyRevenueEvent.tabHidden() = TabHidden;

  const factory CompanyRevenueEvent.appBackgrounded() = AppBackgrounded;

  const factory CompanyRevenueEvent.appForegrounded() = AppForegrounded;

  const factory CompanyRevenueEvent.periodChanged({
    required FinancialPeriod period,
  }) = PeriodChanged;

  const factory CompanyRevenueEvent.viewAllTapped({
    required FinancialPeriod period,
    required bool isChart,
  }) = ViewAllTapped;

  const factory CompanyRevenueEvent.reset() = Reset;
}
