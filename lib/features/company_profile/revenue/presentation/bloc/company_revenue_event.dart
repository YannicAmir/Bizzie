import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_revenue_event.freezed.dart';

@freezed
abstract class CompanyRevenueEvent with _$CompanyRevenueEvent {
  const factory CompanyRevenueEvent.loadRequested(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadRequested;

  const factory CompanyRevenueEvent.stalenessCheckRequested(String ticker) =
      StalenessCheckRequested;
}
