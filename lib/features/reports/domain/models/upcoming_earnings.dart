import 'package:freezed_annotation/freezed_annotation.dart';

part 'upcoming_earnings.freezed.dart';

@freezed
abstract class UpcomingEarnings with _$UpcomingEarnings {
  const factory UpcomingEarnings({
    required String symbol,
    required String companyName,
    required DateTime? date,
  }) = _UpcomingEarnings;
}
