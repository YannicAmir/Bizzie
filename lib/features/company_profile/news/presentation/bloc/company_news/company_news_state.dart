import 'package:bizzie/core/error/failures.dart';
import 'package:bizzie/core/enums/data_origin.dart';
import 'package:bizzie/features/company_profile/news/domain/models/news_article.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_news_state.freezed.dart';

@freezed
class CompanyNewsState with _$CompanyNewsState {
  const factory CompanyNewsState.initial() = _Initial;
  const factory CompanyNewsState.loading() = _Loading;
  const factory CompanyNewsState.loaded({
    required List<NewsArticle> articles,
    required String ticker,
    required CompanyProfileDataOrigin dataOrigin,
    DateTime? lastUpdated,
  }) = _Loaded;
  const factory CompanyNewsState.failure(Failure failure) = _Failure;
}
