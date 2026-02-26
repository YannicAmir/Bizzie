import 'package:bizzie/core/enums/bizzie_lifecycle_state.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_bloc.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final _logger = BizzieLogger('TabVisibilityObserver');

class TabVisibilityObserver extends StatefulWidget {
  final String tabName;
  final VoidCallback? onTabShown;
  final VoidCallback? onTabHidden;
  final VoidCallback? onAppBackgrounded;
  final VoidCallback? onAppForegrounded;
  final Widget child;

  const TabVisibilityObserver({
    super.key,
    required this.tabName,
    required this.child,
    this.onTabShown,
    this.onTabHidden,
    this.onAppBackgrounded,
    this.onAppForegrounded,
  });

  @override
  State<TabVisibilityObserver> createState() => _TabVisibilityObserverState();
}

class _TabVisibilityObserverState extends State<TabVisibilityObserver> {
  _ObserverState _state = const _ObserverState();

  @override
  void initState() {
    super.initState();
    final bloc = context.read<CompanyProfileBloc>();
    final activeState = bloc.state.mapOrNull(active: (s) => s);

    if (activeState != null) {
      final isVisible = activeState.activeTabName == widget.tabName;
      _state = _state.copyWith(
        isVisible: isVisible,
        lastLifecycle: activeState.lifecycleState,
      );

      if (isVisible) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _safeNotify(widget.onTabShown, 'onTabShown');
        });
      }
    }
  }

  @override
  void dispose() {
    if (_state.isVisible) {
      _safeNotify(widget.onTabHidden, 'onTabHidden');
    }
    super.dispose();
  }

  void _safeNotify(VoidCallback? callback, String callbackName) {
    if (callback == null) return;
    try {
      callback();
    } catch (e, stack) {
      _logger.severe(
        'Callback execution failed for $callbackName in tab: ${widget.tabName}',
        e,
        stack,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompanyProfileBloc, CompanyProfileState>(
      listenWhen: (previous, current) {
        final prevActive = previous.mapOrNull(active: (a) => a);
        final currActive = current.mapOrNull(active: (a) => a);

        if (prevActive == null && currActive == null) return false;

        if (prevActive == null || currActive == null) return true;

        if (prevActive.activeTabName != currActive.activeTabName) return true;

        if (currActive.activeTabName == widget.tabName &&
            prevActive.lifecycleState != currActive.lifecycleState) {
          return true;
        }

        return false;
      },
      listener: (context, state) {
        final activeState = state.mapOrNull(active: (a) => a);
        final bool isNowActive =
            activeState != null && activeState.activeTabName == widget.tabName;

        // 1. Handle Visibility Transitions
        if (isNowActive && !_state.isVisible) {
          _state = _state.copyWith(isVisible: true);
          _safeNotify(widget.onTabShown, 'onTabShown');
        } else if (!isNowActive && _state.isVisible) {
          _state = _state.copyWith(isVisible: false);
          _safeNotify(widget.onTabHidden, 'onTabHidden');
        }

        // 2. Handle Lifecycle Transitions (only if tab is active)
        if (activeState != null &&
            isNowActive &&
            activeState.lifecycleState != _state.lastLifecycle) {
          final previousLifecycle = _state.lastLifecycle;
          _state = _state.copyWith(lastLifecycle: activeState.lifecycleState);

          if (activeState.lifecycleState == BizzieLifecycleState.background) {
            _safeNotify(widget.onAppBackgrounded, 'onAppBackgrounded');
          } else if (activeState.lifecycleState ==
                  BizzieLifecycleState.foreground &&
              previousLifecycle == BizzieLifecycleState.background) {
            _safeNotify(widget.onAppForegrounded, 'onAppForegrounded');
          }
        }
      },
      child: widget.child,
    );
  }
}

/// Private state snapshot for atomic transitions within [TabVisibilityObserver].
class _ObserverState {
  final bool isVisible;
  final BizzieLifecycleState? lastLifecycle;

  const _ObserverState({this.isVisible = false, this.lastLifecycle});

  _ObserverState copyWith({
    bool? isVisible,
    BizzieLifecycleState? lastLifecycle,
  }) {
    return _ObserverState(
      isVisible: isVisible ?? this.isVisible,
      lastLifecycle: lastLifecycle ?? this.lastLifecycle,
    );
  }
}
