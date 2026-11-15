import 'package:bizzie/features/auth/domain/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user_dto.freezed.dart';
part 'auth_user_dto.g.dart';

@freezed
abstract class AuthUserDto with _$AuthUserDto {
  const AuthUserDto._();

  const factory AuthUserDto({
    required String uid,
    String? email,
    String? displayName,
    String? photoUrl,
    @Default([]) List<String> providers,
    @Default(false) bool isAnonymous,
  }) = _AuthUserDto;

  factory AuthUserDto.fromJson(Map<String, dynamic> json) =>
      _$AuthUserDtoFromJson(json);

  factory AuthUserDto.fromFirebaseUser(User user) {
    return AuthUserDto(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
      providers: user.providerData.map((info) => info.providerId).toList(),
      isAnonymous: user.isAnonymous,
    );
  }

  UserModel toDomain() {
    return UserModel(
      id: uid,
      email: email ?? '',
      displayName: displayName,
      photoUrl: photoUrl,
      providers: providers,
      isAnonymous: isAnonymous,
    );
  }
}
