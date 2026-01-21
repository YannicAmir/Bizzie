import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_more_event.freezed.dart';

@freezed
sealed class CompanyMoreEvent with _$CompanyMoreEvent {
  const factory CompanyMoreEvent.loadRatios(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadRatios;

  const factory CompanyMoreEvent.loadKeyMetrics(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadKeyMetrics;

  const factory CompanyMoreEvent.loadAll(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadAll;

  const factory CompanyMoreEvent.stalenessCheckRequested(String ticker) =
      StalenessCheckRequested;
}
