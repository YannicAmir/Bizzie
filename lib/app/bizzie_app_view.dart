import 'package:bizzie/app/global_overlay_wrapper.dart';
import 'package:bizzie/app/router.dart';
import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_event.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_state.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';

class BizzieAppView extends StatefulWidget {
  const BizzieAppView({super.key});

  @override
  State<BizzieAppView> createState() => _BizzieAppViewState();
}

class _BizzieAppViewState extends State<BizzieAppView> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = createRouter(context.read<AuthBloc>(), context.read<UserBloc>());
    context.read<AuthBloc>().add(const AuthEvent.statusRequested());

    final currentState = context.read<AuthBloc>().state;
    final isDetermined = currentState.maybeMap(
      authenticated: (_) => true,
      unauthenticated: (_) => true,
      failure: (_) => true,
      orElse: () => false,
    );

    if (isDetermined) {
      FlutterNativeSplash.remove();

      currentState.mapOrNull(
        authenticated: (state) {
          context.read<UserBloc>().add(
            UserEvent.loadUser(state.user.id, silent: false),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          authenticated: (user) {
            context.read<UserBloc>().add(
              UserEvent.loadUser(user.id, silent: false),
            );
          },
          unauthenticated: () {
            context.read<UserBloc>().add(const UserEvent.clear());
          },
        );

        final isAuthDetermined = state.maybeMap(
          authenticated: (_) => true,
          unauthenticated: (_) => true,
          failure: (_) => true,
          orElse: () => false,
        );

        if (isAuthDetermined) {
          FlutterNativeSplash.remove();
        }
      },
      child: MaterialApp.router(
        theme: AppTheme.lightTheme,
        routerConfig: _router,
        builder: (context, child) => GlobalOverlayWrapper(child: child),
      ),
    );
  }
}
