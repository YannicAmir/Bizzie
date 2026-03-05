import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_revenue_event.freezed.dart';

@freezed
abstract class CompanyRevenueEvent with _$CompanyRevenueEvent {
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

  const factory CompanyRevenueEvent.periodViewed({required bool isAnnual}) =
      PeriodViewed;

  const factory CompanyRevenueEvent.viewAllTapped({
    required bool isAnnual,
    required bool isChart,
  }) = ViewAllTapped;
}
