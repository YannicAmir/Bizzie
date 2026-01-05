import 'package:bizzie/features/onboarding/domain/models/company.dart';
import 'package:bizzie/features/onboarding/domain/models/onboarding_data.dart';
import 'package:bizzie/features/onboarding/domain/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}

@freezed
abstract class UserDto with _$UserDto {
  const UserDto._();

  const factory UserDto({
    required String uid,
    required String name,
    required String favoriteSector,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'favoriteSectorDisplay') String? favoriteSectorDisplay,
    required List<Map<String, dynamic>> watchlist,
    required String investingExperience,
    @TimestampConverter() required DateTime createdAt,
    @Default(false) bool isSubscribed,
    required Map<String, String> fcmTokens,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  UserModel toDomain() {
    return UserModel(
      uid: uid,
      name: name,
      favoriteSector: favoriteSector,
      watchlist: watchlist.map((e) => Company.fromJson(e)).toList(),
      investingExperience: InvestingExperience.values.firstWhere(
        (e) => e.name == investingExperience,
        orElse: () => InvestingExperience.beginner,
      ),
      createdAt: createdAt,
      isSubscribed: isSubscribed,
      fcmTokens: fcmTokens,
    );
  }
}
