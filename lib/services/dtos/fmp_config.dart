import 'package:freezed_annotation/freezed_annotation.dart';

part 'fmp_config.freezed.dart';
part 'fmp_config.g.dart';

@freezed
abstract class FmpConfig with _$FmpConfig {
  const factory FmpConfig({
    required String baseUrl,
    required String v3Url,
    required String v4Url,
  }) = _FmpConfig;

  factory FmpConfig.fromJson(Map<String, dynamic> json) =>
      _$FmpConfigFromJson(json);
}
