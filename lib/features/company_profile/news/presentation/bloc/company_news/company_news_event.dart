import 'package:bizzie/features/company_profile/news/domain/models/news_article.dart';
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

  const factory CompanyNewsEvent.tabShown(String ticker) = TabShown;

  const factory CompanyNewsEvent.tabHidden() = TabHidden;

  const factory CompanyNewsEvent.appBackgrounded() = AppBackgrounded;

  const factory CompanyNewsEvent.appForegrounded() = AppForegrounded;

  const factory CompanyNewsEvent.articleTapped({
    required NewsArticle article,
    required bool isFeatured,
  }) = ArticleTapped;

  const factory CompanyNewsEvent.reset() = Reset;
}
