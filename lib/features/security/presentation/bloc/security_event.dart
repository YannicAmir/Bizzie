import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bizzie/features/security/domain/enums/security_analytics_enums.dart';

part 'security_event.freezed.dart';

@freezed
class SecurityEvent with _$SecurityEvent {
  const factory SecurityEvent.started() = Started;
  const factory SecurityEvent.lockoutActionTaken(SecurityLockoutAction action) =
      LockoutActionTaken;
  const factory SecurityEvent.threatDetected({
    required SecurityThreatType type,
    required bool isCritical,
  }) = ThreatDetected;
}
