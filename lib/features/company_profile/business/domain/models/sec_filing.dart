import 'package:freezed_annotation/freezed_annotation.dart';

part 'sec_filing.freezed.dart';

@freezed
abstract class SecFiling with _$SecFiling {
  const factory SecFiling({
    required String date,
    required String year,
    required String period,
    required String link,
  }) = _SecFiling;
}
