import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String uid,
    required String name,
    required String favoriteSector,
    required List<Company> watchlist,
    required InvestingExperience investingExperience,
    @TimestampConverter() required DateTime createdAt,
    required bool isSubscribed,
    required Map<String, String> fcmTokens,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
