import 'package:freezed_annotation/freezed_annotation.dart';

part 'fmp_sec_filing_dto.freezed.dart';
part 'fmp_sec_filing_dto.g.dart';

@freezed
abstract class FmpSecFilingDto with _$FmpSecFilingDto {
  const factory FmpSecFilingDto({
    String? symbol,
    String? filingDate,
    String? acceptedDate,
    String? period,
    String? formType, // "DEF 14A", "10-K" etc
    String? link,
    String? finalLink,
  }) = _FmpSecFilingDto;

  factory FmpSecFilingDto.fromJson(Map<String, dynamic> json) =>
      _$FmpSecFilingDtoFromJson(json);
}
