// ignore_for_file: invalid_annotation_target
import 'package:bizzie/features/reports/domain/models/upcoming_earnings.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'upcoming_earnings_dto.freezed.dart';
part 'upcoming_earnings_dto.g.dart';

@freezed
abstract class UpcomingEarningsDto with _$UpcomingEarningsDto {
  const UpcomingEarningsDto._();
  const factory UpcomingEarningsDto({
    @JsonKey(includeFromJson: false, includeToJson: false) String? id,
    required String symbol,
    required String date,
    String? expireAt,
  }) = _UpcomingEarningsDto;

  factory UpcomingEarningsDto.fromJson(Map<String, dynamic> json) =>
      _$UpcomingEarningsDtoFromJson(json);

  UpcomingEarnings toDomain({String? companyName}) {
    return UpcomingEarnings(
      symbol: symbol,
      companyName: companyName ?? symbol,
      date: DateTime.tryParse(date),
    );
  }
}
