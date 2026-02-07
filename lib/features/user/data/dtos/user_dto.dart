import 'package:bizzie/core/utils/timestamp_converter.dart';
import 'package:bizzie/features/user/domain/enums/investing_experience.dart';
import 'package:bizzie/features/user/domain/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
abstract class UserDto with _$UserDto {
  const UserDto._();

  const factory UserDto({
    required String uid,
    required String name,
    required String favoriteSector,
    String? favoriteSectorDisplay,
    required String investingExperience,
    @TimestampConverter() required DateTime createdAt,
    @Default(false) bool isSubscribed,
    required Map<String, String> fcmTokens,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  factory UserDto.fromDomain(UserModel domain) {
    return UserDto(
      uid: domain.uid,
      name: domain.name,
      favoriteSector: domain.favoriteSector,
      investingExperience: domain.investingExperience.name,
      createdAt: domain.createdAt,
      isSubscribed: domain.isSubscribed,
      fcmTokens: domain.fcmTokens,
    );
  }

  UserModel toDomain() {
    return UserModel(
      uid: uid,
      name: name,
      favoriteSector: favoriteSector,
      watchlist: [],
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
