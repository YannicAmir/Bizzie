import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_news_event.freezed.dart';

@freezed
abstract class CompanyNewsEvent with _$CompanyNewsEvent {
  const factory CompanyNewsEvent.loadRequested(
    String ticker, {
    @Default(false) bool forceRefresh,
  }) = LoadRequested;

  const factory CompanyNewsEvent.stalenessCheckRequested(String ticker) =
      StalenessCheckRequested;
}
