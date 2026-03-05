import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_roe_event.freezed.dart';

@freezed
abstract class CompanyRoeEvent with _$CompanyRoeEvent {
  const factory CompanyRoeEvent.loadRequested(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadRequested;

  const factory CompanyRoeEvent.stalenessCheckRequested(String ticker) =
      StalenessCheckRequested;

  const factory CompanyRoeEvent.tabShown(String ticker) = TabShown;

  const factory CompanyRoeEvent.tabHidden() = TabHidden;

  const factory CompanyRoeEvent.appBackgrounded() = AppBackgrounded;

  const factory CompanyRoeEvent.appForegrounded() = AppForegrounded;

  const factory CompanyRoeEvent.viewAllTapped({required bool isChart}) =
      ViewAllTapped;
}
