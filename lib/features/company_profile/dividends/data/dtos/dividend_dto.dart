import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/dividend_event.dart';

part 'dividend_dto.freezed.dart';
part 'dividend_dto.g.dart';

@freezed
abstract class DividendDto with _$DividendDto {
  const factory DividendDto({
    required String date,
    double? dividend,
    double? adjDividend,
    String? recordDate,
    String? paymentDate,
    String? declarationDate,
    double? yield,
    String? frequency,
  }) = _DividendDto;

  const DividendDto._();

  factory DividendDto.fromJson(Map<String, dynamic> json) =>
      _$DividendDtoFromJson(json);

  DividendEvent toDomain() {
    return DividendEvent(
      date: date,
      dividend: dividend ?? 0.0,
      adjDividend: adjDividend ?? 0.0,
      recordDate: recordDate,
      paymentDate: paymentDate,
      declarationDate: declarationDate,
      frequency: frequency,
      yield: yield,
    );
  }
}
