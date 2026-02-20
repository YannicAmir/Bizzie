import 'dart:async';
import 'package:bizzie/features/security/domain/enums/security_analytics_enums.dart';
import 'package:bizzie/features/security/presentation/analytics/security_tracker.dart';
import 'package:bizzie/features/security/presentation/bloc/security_event.dart';
import 'package:bizzie/features/security/presentation/bloc/security_state.dart';
import 'package:bizzie/services/security_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SecurityBloc extends Bloc<SecurityEvent, SecurityState> {
  final SecurityService _securityService;
  final SecurityTracker _tracker;
  StreamSubscription? _threatSubscription;

  SecurityBloc(this._securityService, this._tracker) : super(const Safe()) {
    on<Started>(_onStarted);
    on<ThreatDetected>(_onThreatDetected);
    on<LockoutActionTaken>(_onLockoutActionTaken);
  }

  @override
  Future<void> close() {
    _threatSubscription?.cancel();
    return super.close();
  }

  void _onStarted(Started event, Emitter<SecurityState> emit) {
    _threatSubscription?.cancel();
    _threatSubscription = _securityService.threatStream.listen((threat) {
      add(
        SecurityEvent.threatDetected(
          type: SecurityThreatType.fromConstant(threat.type),
          isCritical: threat.isCritical,
        ),
      );
    });

    final lastThreat = _securityService.lastThreat;
    if (_securityService.isThreatDetected && lastThreat != null) {
      add(
        SecurityEvent.threatDetected(
          type: SecurityThreatType.fromConstant(lastThreat.type),
          isCritical: lastThreat.isCritical,
        ),
      );
    }
  }

  Future<void> _onThreatDetected(
    ThreatDetected event,
    Emitter<SecurityState> emit,
  ) async {
    try {
      await _tracker.logThreatDetected(
        type: event.type,
        isCritical: event.isCritical,
      );
      await _tracker.setSecurityThreatProperty(event.type);
    } catch (_) {}

    emit(const Lockout());

    try {
      await _tracker.logLockoutViewed();
    } catch (_) {}
  }

  Future<void> _onLockoutActionTaken(
    LockoutActionTaken event,
    Emitter<SecurityState> emit,
  ) async {
    try {
      await _tracker.logLockoutAction(event.action);
    } catch (_) {}
  }
}
