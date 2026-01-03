import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
abstract class UserDto with _$UserDto {
  const factory UserDto({
    required String uid,
    required String name,
    required String favoriteSector,
    required String favoriteSectorDisplay,
    required List<Map<String, dynamic>> watchlist,
    required String investingExperience,
    @Default(false) bool isSubscribed,
    required Map<String, String> fcmTokens,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}
