import 'package:freezed_annotation/freezed_annotation.dart';

part 'security_state.freezed.dart';

@freezed
class SecurityState with _$SecurityState {
  const factory SecurityState.safe() = Safe;
  const factory SecurityState.lockout() = Lockout;
}
