import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_pfcf_ratio_event.freezed.dart';

@freezed
abstract class CompanyPfcfRatioEvent with _$CompanyPfcfRatioEvent {
  const factory CompanyPfcfRatioEvent.loadRequested(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadRequested;

  const factory CompanyPfcfRatioEvent.stalenessCheckRequested(String ticker) =
      StalenessCheckRequested;

  const factory CompanyPfcfRatioEvent.tabShown(String ticker) = TabShown;
  const factory CompanyPfcfRatioEvent.tabHidden() = TabHidden;
  const factory CompanyPfcfRatioEvent.appBackgrounded() = AppBackgrounded;
  const factory CompanyPfcfRatioEvent.appForegrounded() = AppForegrounded;
  const factory CompanyPfcfRatioEvent.viewAllTapped({required bool isChart}) =
      ViewAllTapped;
  const factory CompanyPfcfRatioEvent.reset() = Reset;
}
