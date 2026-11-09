import 'package:freezed_annotation/freezed_annotation.dart';

part 'sec_filing.freezed.dart';

@freezed
abstract class SecFiling with _$SecFiling {
  const factory SecFiling({
    required String id,
    required String symbol,
    required String companyName,
    required DateTime? filingDate,
    required String formType,
    required String link,
    required String summary,
    double? eps,
    double? revenue,
    String? sentiment,
    String? topic,
    @Default(false) bool isEarnings,
    required DateTime? createdAt,
    required DateTime? analyzedAt,
    String? deepAnalysisId,
    String? deepAnalysisStatus,
  }) = _SecFiling;
}
