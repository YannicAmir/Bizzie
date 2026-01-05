import 'package:bizzie/app/router.dart';
import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_event.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_state.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';

import 'package:bizzie/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:bizzie/shared/widgets/loading/global_loading_page.dart';
import 'package:bizzie/shared/widgets/loading/global_error_page.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:bizzie/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class BizzieApp extends StatefulWidget {
  const BizzieApp({super.key});

  @override
  State<BizzieApp> createState() => _BizzieAppState();
}

class _BizzieAppState extends State<BizzieApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    getIt<AuthBloc>().add(const AuthStatusRequested());
    _router = createRouter(getIt<AuthBloc>(), getIt<UserBloc>());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => getIt<AuthBloc>()),
        BlocProvider<NotificationBloc>(
          create: (_) => getIt<NotificationBloc>(),
        ),
        BlocProvider<UserBloc>(create: (_) => getIt<UserBloc>()),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          state.whenOrNull(
            authenticated: (user) {
              context.read<UserBloc>().add(
                UserEvent.loadUser(user.id, silent: true),
              );
            },
            unauthenticated: () {
              context.read<UserBloc>().add(const UserEvent.clear());
            },
          );

          // Also check here for state changes to remove splash
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
          builder: (context, child) {
            return BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                // If we are not loading, we can remove the splash (if not already done).
                // Doing this in post-frame callback ensures the new frame (child or loading page) is ready.
                // Ideally, we remove splash immediately if we are showing SOMETHING (Loading Page or App).
                // Since we always show Stack children, we can remove it now.
                // Check if Auth state is determined to decide on removing splash
                final authState = context.read<AuthBloc>().state;
                final isAuthDetermined = authState.maybeMap(
                  authenticated: (_) => true,
                  unauthenticated: (_) => true,
                  failure: (_) => true,
                  orElse: () => false,
                );

                if (isAuthDetermined) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    FlutterNativeSplash.remove();
                  });
                }

                return Stack(
                  children: [
                    if (child != null) child,
                    if (state.maybeMap(
                      loading: (_) => true,
                      orElse: () => false,
                    ))
                      state.maybeMap(
                        loading: (loadingState) => GlobalLoadingPage(
                          sectorName: loadingState.cachedSector,
                        ),
                        orElse: () => const SizedBox.shrink(),
                      ),
                    if (state.maybeMap(
                      failure: (_) => true,
                      orElse: () => false,
                    ))
                      state.maybeMap(
                        failure: (failureState) => GlobalErrorPage(
                          sectorName: failureState.cachedSector,
                          onRetry: () => context.read<UserBloc>().add(
                            UserEvent.loadUser(
                              context.read<AuthBloc>().state.maybeWhen(
                                authenticated: (u) => u.id,
                                orElse: () => '',
                              ),
                            ),
                          ),
                        ),
                        orElse: () => const SizedBox.shrink(),
                      ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
