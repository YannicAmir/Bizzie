import 'package:freezed_annotation/freezed_annotation.dart';

part 'weekly_report.freezed.dart';

@freezed
abstract class PriceMovement with _$PriceMovement {
  const factory PriceMovement({
    double? startPrice,
    double? endPrice,
    double? priceChange,
    double? priceChangePercent,
  }) = _PriceMovement;
}

@freezed
abstract class WeeklyReport with _$WeeklyReport {
  const WeeklyReport._();

  const factory WeeklyReport({
    String? id,
    String? ticker,
    String? companyName,
    String? messageTitle,
    String? messageShortSummary,
    String? messageLongSummary,
    List<String>? newsLinks,
    List<String>? eightKLinks,
    PriceMovement? priceMovement,
    DateTime? createdAt,
  }) = _WeeklyReport;

  String get seenKey => '${ticker}_$id';
}
