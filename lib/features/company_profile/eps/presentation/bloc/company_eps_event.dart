import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_eps_event.freezed.dart';

@freezed
abstract class CompanyEpsEvent with _$CompanyEpsEvent {
  const factory CompanyEpsEvent.loadRequested(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadRequested;

  const factory CompanyEpsEvent.stalenessCheckRequested(String ticker) =
      StalenessCheckRequested;
}
