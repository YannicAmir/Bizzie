import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_pe_ratio_event.freezed.dart';

@freezed
abstract class CompanyPeRatioEvent with _$CompanyPeRatioEvent {
  const factory CompanyPeRatioEvent.loadRequested(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadRequested;

  const factory CompanyPeRatioEvent.stalenessCheckRequested(String ticker) =
      StalenessCheckRequested;

  const factory CompanyPeRatioEvent.tabShown(String ticker) = TabShown;
  const factory CompanyPeRatioEvent.tabHidden() = TabHidden;
  const factory CompanyPeRatioEvent.appBackgrounded() = AppBackgrounded;
  const factory CompanyPeRatioEvent.appForegrounded() = AppForegrounded;
  const factory CompanyPeRatioEvent.viewAllTapped({required bool isChart}) =
      ViewAllTapped;
}
