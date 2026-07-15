import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_segments_event.freezed.dart';

@freezed
sealed class CompanySegmentsEvent with _$CompanySegmentsEvent {
  const factory CompanySegmentsEvent.loadRequested(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadRequested;

  const factory CompanySegmentsEvent.stalenessCheckRequested(String ticker) =
      StalenessCheckRequested;

  const factory CompanySegmentsEvent.tabShown(String ticker) = TabShown;

  const factory CompanySegmentsEvent.tabHidden() = TabHidden;

  const factory CompanySegmentsEvent.appBackgrounded() = AppBackgrounded;

  const factory CompanySegmentsEvent.appForegrounded() = AppForegrounded;

  const factory CompanySegmentsEvent.periodChanged({required bool isAnnual}) =
      PeriodChanged;

  const factory CompanySegmentsEvent.periodKeySelected(
    String key, {
    required bool isAnnual,
  }) = PeriodKeySelected;

  const factory CompanySegmentsEvent.reset() = Reset;
}
