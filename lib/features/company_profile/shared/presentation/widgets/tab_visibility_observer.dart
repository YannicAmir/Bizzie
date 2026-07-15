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
  bool _isVisible = false;
  BizzieLifecycleState? _lastLifecycle;

  @override
  void initState() {
    super.initState();
    final activeState = _activeOf(context.read<CompanyProfileBloc>().state);

    if (activeState != null) {
      _isVisible = _isTabActive(activeState);
      _lastLifecycle = activeState.lifecycleState;

      if (_isVisible) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) _notifyTabShown();
        });
      }
    }
  }

  Active? _activeOf(CompanyProfileState state) =>
      state.mapOrNull(active: (active) => active);

  bool _isTabActive(Active? activeState) =>
      activeState != null && activeState.activeTabName == widget.tabName;

  void _notifyTabShown() => _safeNotify(widget.onTabShown, 'onTabShown');

  void _safeNotify(VoidCallback? callback, String callbackName) {
    if (callback == null) return;
    try {
      callback();
    } on Object catch (e, stack) {
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
        final prevActive = _activeOf(previous);
        final currActive = _activeOf(current);

        if (prevActive == null && currActive == null) return false;

        if (prevActive == null || currActive == null) return true;

        if (prevActive.activeTabName != currActive.activeTabName) return true;

        if (_isTabActive(currActive) &&
            prevActive.lifecycleState != currActive.lifecycleState) {
          return true;
        }

        return false;
      },
      listener: (context, state) {
        final activeState = _activeOf(state);
        final isNowActive = _isTabActive(activeState);

        if (isNowActive && !_isVisible) {
          _isVisible = true;
          _notifyTabShown();
        } else if (!isNowActive && _isVisible) {
          _isVisible = false;
          _safeNotify(widget.onTabHidden, 'onTabHidden');
        }

        if (activeState != null &&
            isNowActive &&
            activeState.lifecycleState != _lastLifecycle) {
          final previousLifecycle = _lastLifecycle;
          _lastLifecycle = activeState.lifecycleState;

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
