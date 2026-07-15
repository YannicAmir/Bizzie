import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_business_event.freezed.dart';

@freezed
sealed class CompanyBusinessEvent with _$CompanyBusinessEvent {
  const factory CompanyBusinessEvent.loadRequested(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadRequested;

  const factory CompanyBusinessEvent.stalenessCheckRequested(String ticker) =
      StalenessCheckRequested;

  const factory CompanyBusinessEvent.tabShown(String ticker) = TabShown;
  const factory CompanyBusinessEvent.tabHidden() = TabHidden;
  const factory CompanyBusinessEvent.appBackgrounded() = AppBackgrounded;
  const factory CompanyBusinessEvent.appForegrounded() = AppForegrounded;

  const factory CompanyBusinessEvent.reset() = BusinessReset;

  const factory CompanyBusinessEvent.analyticsInteractionOccurred({
    bool? tappedWebsite,
    bool? tappedProxy,
    bool? didExpandDescription,
    bool? viewed10Ks,
    bool? viewed10Qs,
    bool? viewAll10KsTapped,
    bool? viewAll10QsTapped,
  }) = AnalyticsInteractionOccurred;
}
