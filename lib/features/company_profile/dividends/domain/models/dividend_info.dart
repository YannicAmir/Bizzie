import 'package:freezed_annotation/freezed_annotation.dart';
import 'dividend_event.dart';

part 'dividend_info.freezed.dart';

@freezed
abstract class DividendInfo with _$DividendInfo {
  const factory DividendInfo({
    required String symbol,
    required List<DividendEvent> history,
  }) = _DividendInfo;
}
