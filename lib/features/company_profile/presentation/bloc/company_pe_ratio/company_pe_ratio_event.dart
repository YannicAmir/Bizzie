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
}
