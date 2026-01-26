import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_free_cash_flow_event.freezed.dart';

@freezed
abstract class CompanyFreeCashFlowEvent with _$CompanyFreeCashFlowEvent {
  const factory CompanyFreeCashFlowEvent.loadRequested(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadRequested;

  const factory CompanyFreeCashFlowEvent.stalenessCheckRequested(
    String ticker,
  ) = StalenessCheckRequested;
}
