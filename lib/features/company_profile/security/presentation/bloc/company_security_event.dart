import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_security_event.freezed.dart';

@freezed
sealed class CompanySecurityEvent with _$CompanySecurityEvent {
  const factory CompanySecurityEvent.loadRequested(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadRequested;

  const factory CompanySecurityEvent.stalenessCheckRequested(String ticker) =
      StalenessCheckRequested;

  const factory CompanySecurityEvent.tabShown(String ticker) = TabShown;
  const factory CompanySecurityEvent.tabHidden() = TabHidden;
  const factory CompanySecurityEvent.appBackgrounded() = AppBackgrounded;
  const factory CompanySecurityEvent.appForegrounded() = AppForegrounded;

  const factory CompanySecurityEvent.priceAnalyticsUpdated({
    int? loadTimeMs,
    bool? isSuccess,
    String? finalTimeframe,
    int? chartChangeCount,
  }) = PriceAnalyticsUpdated;

  const factory CompanySecurityEvent.earningsAnalyticsUpdated({
    bool? hasUpcoming,
    String? daysAway,
  }) = EarningsAnalyticsUpdated;

  const factory CompanySecurityEvent.reset() = SecurityReset;
}
