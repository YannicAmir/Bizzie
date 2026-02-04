import 'package:freezed_annotation/freezed_annotation.dart';

enum SubscriptionPackageType {
  @JsonValue('monthly')
  monthly,
  @JsonValue('annual')
  annual,
  @JsonValue('sixMonth')
  sixMonth,
  @JsonValue('threeMonth')
  threeMonth,
  @JsonValue('twoMonth')
  twoMonth,
  @JsonValue('weekly')
  weekly,
  @JsonValue('lifetime')
  lifetime,
  @JsonValue('unknown')
  unknown,
}
