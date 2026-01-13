import 'package:freezed_annotation/freezed_annotation.dart';

class ForceDouble implements JsonConverter<double, dynamic> {
  const ForceDouble();

  @override
  double fromJson(dynamic json) {
    if (json is num) {
      return json.toDouble();
    } else if (json is String) {
      return double.tryParse(json) ?? 0.0;
    }
    return 0.0;
  }

  @override
  dynamic toJson(double object) => object;
}

class ForceDoubleNullable implements JsonConverter<double?, dynamic> {
  const ForceDoubleNullable();

  @override
  double? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is num) {
      return json.toDouble();
    } else if (json is String) {
      return double.tryParse(json);
    }
    return null;
  }

  @override
  dynamic toJson(double? object) => object;
}
