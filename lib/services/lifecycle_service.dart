import 'package:bizzie/core/enums/bizzie_lifecycle_state.dart';
import 'package:bizzie/core/interfaces/i_lifecycle_service.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@Singleton(as: ILifecycleService)
class LifecycleService
    with WidgetsBindingObserver
    implements ILifecycleService {
  final _lifecycleSubject = BehaviorSubject<BizzieLifecycleState>();

  LifecycleService() {
    WidgetsBinding.instance.addObserver(this);
    final currentState = WidgetsBinding.instance.lifecycleState;
    if (currentState != null) {
      _lifecycleSubject.add(_mapLifecycleState(currentState));
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _lifecycleSubject.add(_mapLifecycleState(state));
  }

  @override
  @disposeMethod
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _lifecycleSubject.close();
  }

  @override
  Stream<BizzieLifecycleState> get onLifecycleChanged =>
      _lifecycleSubject.stream;

  @override
  bool get isForeground {
    final state = _lifecycleSubject.valueOrNull;
    return state == BizzieLifecycleState.foreground;
  }

  BizzieLifecycleState _mapLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        return BizzieLifecycleState.foreground;
      case AppLifecycleState.inactive:
        return BizzieLifecycleState.inactive;
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        return BizzieLifecycleState.background;
      case AppLifecycleState.detached:
        return BizzieLifecycleState.detached;
    }
  }
}
