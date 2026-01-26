import 'package:freezed_annotation/freezed_annotation.dart';

part 'roe.freezed.dart';

@freezed
abstract class Roe with _$Roe {
  const factory Roe({
    required String symbol,
    required String date,
    required String period,
    required double returnOnEquity,
  }) = _Roe;
}
