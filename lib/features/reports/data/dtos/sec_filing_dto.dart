// ignore_for_file: invalid_annotation_target
import 'package:bizzie/features/reports/domain/models/sec_filing.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/core/utils/json_converters.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'sec_filing_dto.freezed.dart';
part 'sec_filing_dto.g.dart';

@freezed
abstract class SecFilingDto with _$SecFilingDto {
  const SecFilingDto._();
  const factory SecFilingDto({
    @JsonKey(includeToJson: false) String? id,
    required String symbol,
    required String companyName,
    required String filingDate,
    required String formType,
    required String link,
    required String summary,
    @ForceDoubleNullable() double? eps,
    @ForceDoubleNullable() double? revenue,
    String? sentiment,
    String? topic,
    @Default(false) bool isEarnings,
    Object? createdAt,
    Object? analyzedAt,
    String? deepAnalysisId,
    String? deepAnalysisStatus,
  }) = _SecFilingDto;

  factory SecFilingDto.fromJson(Map<String, dynamic> json) =>
      _$SecFilingDtoFromJson(json);

  SecFiling toDomain() {
    DateTime? parsedDate;
    try {
      parsedDate = DateTime.parse(filingDate);
    } catch (e) {
      parsedDate = null;
    }

    DateTime? parseTimestamp(Object? timestamp) {
      if (timestamp == null) return null;
      if (timestamp is String) return DateTime.tryParse(timestamp);
      if (timestamp is Timestamp) return timestamp.toDate();
      return null;
    }

    DateTime? parsedCreatedAt = parseTimestamp(createdAt);
    DateTime? parsedAnalyzedAt = parseTimestamp(analyzedAt);

    return SecFiling(
      id: id ?? '',
      symbol: symbol,
      companyName: companyName,
      filingDate: parsedDate,
      formType: formType,
      link: link,
      summary: summary,
      eps: eps,
      revenue: revenue,
      sentiment: sentiment,
      topic: topic,
      isEarnings: isEarnings,
      createdAt: parsedCreatedAt,
      analyzedAt: parsedAnalyzedAt,
      deepAnalysisId: deepAnalysisId,
      deepAnalysisStatus: deepAnalysisStatus,
    );
  }
}
