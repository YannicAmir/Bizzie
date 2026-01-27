import 'package:freezed_annotation/freezed_annotation.dart';

part 'governance_dtos.freezed.dart';
part 'governance_dtos.g.dart';

// Governance
@freezed
abstract class GovernanceDto with _$GovernanceDto {
  const factory GovernanceDto({
    required String symbol,
    required String nameAndPosition,
    double? total,
  }) = _GovernanceDto;

  factory GovernanceDto.fromJson(Map<String, dynamic> json) =>
      _$GovernanceDtoFromJson(json);
}

// Executives
@freezed
abstract class ExecutiveDto with _$ExecutiveDto {
  const factory ExecutiveDto({
    required String name,
    required String title,
    double? pay,
    String? currencyPay,
    String? gender,
    int? yearBorn,
  }) = _ExecutiveDto;

  factory ExecutiveDto.fromJson(Map<String, dynamic> json) =>
      _$ExecutiveDtoFromJson(json);
}
