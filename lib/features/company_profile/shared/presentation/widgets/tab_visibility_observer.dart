import 'package:bizzie/core/enums/bizzie_lifecycle_state.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_bloc.dart';
import 'package:bizzie/features/company_profile/cp/presentation/bloc/company_profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  BizzieLifecycleState? _lastLifecycleState;

  @override
  void initState() {
    super.initState();
    final bloc = context.read<CompanyProfileBloc>();
    final activeState = bloc.state.mapOrNull(active: (s) => s);

    if (activeState != null) {
      _lastLifecycleState = activeState.lifecycleState;
      if (activeState.activeTabName == widget.tabName) {
        _isVisible = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) widget.onTabShown?.call();
        });
      }
    }
  }

  @override
  void dispose() {
    if (_isVisible) {
      widget.onTabHidden?.call();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompanyProfileBloc, CompanyProfileState>(
      listenWhen: (previous, current) {
        final prevActive = previous.mapOrNull(active: (a) => a);
        final currActive = current.mapOrNull(active: (a) => a);

        if (prevActive == null || currActive == null) return false;

        if (prevActive.activeTabName != currActive.activeTabName) return true;

        if (currActive.activeTabName == widget.tabName &&
            prevActive.lifecycleState != currActive.lifecycleState) {
          return true;
        }

        return false;
      },
      listener: (context, state) {
        state.mapOrNull(
          active: (activeState) {
            final bool isCurrentlyActive =
                activeState.activeTabName == widget.tabName;

            if (isCurrentlyActive && !_isVisible) {
              _isVisible = true;
              widget.onTabShown?.call();
            } else if (!isCurrentlyActive && _isVisible) {
              _isVisible = false;
              widget.onTabHidden?.call();
            }

            if (isCurrentlyActive &&
                activeState.lifecycleState != _lastLifecycleState) {
              _lastLifecycleState = activeState.lifecycleState;
              if (activeState.lifecycleState ==
                  BizzieLifecycleState.background) {
                widget.onAppBackgrounded?.call();
              } else if (activeState.lifecycleState ==
                  BizzieLifecycleState.foreground) {
                widget.onAppForegrounded?.call();
              }
            }
          },
        );
      },
      child: widget.child,
    );
  }
}
