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
}
