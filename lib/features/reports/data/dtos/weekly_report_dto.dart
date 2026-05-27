// ignore_for_file: invalid_annotation_target
import 'package:bizzie/core/utils/timestamp_converter.dart';
import 'package:bizzie/features/reports/domain/models/weekly_report.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weekly_report_dto.freezed.dart';
part 'weekly_report_dto.g.dart';

@freezed
abstract class WeeklyReportDto with _$WeeklyReportDto {
  const WeeklyReportDto._();

  @JsonSerializable()
  const factory WeeklyReportDto({
    @JsonKey(includeToJson: false) String? id,
    String? ticker,
    String? companyName,
    String? messageTitle,
    String? messageShortSummary,
    String? messageLongSummary,
    List<String>? newsLinks,
    List<String>? eightKLinks,
    Map<String, dynamic>? priceMovement,
    @TimestampConverter() DateTime? createdAt,
  }) = _WeeklyReportDto;

  factory WeeklyReportDto.fromJson(Map<String, dynamic> json) =>
      _$WeeklyReportDtoFromJson(json);

  WeeklyReport toDomain() {
    PriceMovement? parsedPriceMovement;
    if (priceMovement != null) {
      parsedPriceMovement = PriceMovement(
        startPrice: _toDouble(priceMovement!['startPrice']),
        endPrice: _toDouble(priceMovement!['endPrice']),
        priceChange: _toDouble(priceMovement!['priceChange']),
        priceChangePercent: _toDouble(priceMovement!['priceChangePercent']),
      );
    }

    return WeeklyReport(
      id: id,
      ticker: ticker,
      companyName: companyName,
      messageTitle: messageTitle,
      messageShortSummary: messageShortSummary,
      messageLongSummary: messageLongSummary,
      newsLinks: newsLinks,
      eightKLinks: eightKLinks,
      priceMovement: parsedPriceMovement,
      createdAt: createdAt,
    );
  }

  double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}
