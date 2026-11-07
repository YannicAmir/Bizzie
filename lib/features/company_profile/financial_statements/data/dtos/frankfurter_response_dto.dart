import 'package:freezed_annotation/freezed_annotation.dart';

part 'frankfurter_response_dto.freezed.dart';
part 'frankfurter_response_dto.g.dart';

@freezed
abstract class FrankfurterResponseDto with _$FrankfurterResponseDto {
  const factory FrankfurterResponseDto({
    required String date,
    required String base,
    required String quote,
    required double rate,
  }) = _FrankfurterResponseDto;

  const FrankfurterResponseDto._();

  factory FrankfurterResponseDto.fromJson(Map<String, dynamic> json) =>
      _$FrankfurterResponseDtoFromJson(json);
}
