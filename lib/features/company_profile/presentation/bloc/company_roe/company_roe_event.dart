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
}
