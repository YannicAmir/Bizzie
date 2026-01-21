import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_net_income_event.freezed.dart';

@freezed
abstract class CompanyNetIncomeEvent with _$CompanyNetIncomeEvent {
  const factory CompanyNetIncomeEvent.loadRequested(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadRequested;

  const factory CompanyNetIncomeEvent.stalenessCheckRequested(String ticker) =
      StalenessCheckRequested;
}
