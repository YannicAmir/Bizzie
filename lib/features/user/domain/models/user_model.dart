import 'package:bizzie/core/utils/timestamp_converter.dart';
import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/user/domain/enums/investing_experience.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String uid,
    required String name,
    required String favoriteSector,
    @Default([]) List<Company> watchlist,
    required InvestingExperience investingExperience,
    @TimestampConverter() required DateTime createdAt,
    required bool isSubscribed,
    @Default(true) bool notificationsEnabled,
    @Default({}) Map<String, String> fcmTokens,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
