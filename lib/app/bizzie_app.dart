import 'package:bizzie/app/router.dart';
import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/features/auth/data/datasources/remote_auth_data_source.dart';
import 'package:bizzie/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bizzie/features/auth/domain/interfaces/i_auth_repository.dart';
import 'package:bizzie/features/auth/domain/usecases/delete_account.dart';
import 'package:bizzie/features/auth/domain/usecases/reset_password.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_in_with_apple.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_in_with_email.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_out.dart';
import 'package:bizzie/features/auth/domain/usecases/sign_up_with_email.dart';
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
  late final IAuthRepository _authRepository;
  late final AuthBloc _authBloc;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();

    final remoteDataSource = RemoteAuthDataSourceImpl();
    _authRepository = AuthRepositoryImpl(remoteDataSource: remoteDataSource);

    _authBloc = AuthBloc(
      authRepository: _authRepository,
      signInWithGoogle: SignInWithGoogle(_authRepository),
      signInWithApple: SignInWithApple(_authRepository),
      signInWithEmail: SignInWithEmail(_authRepository),
      signUpWithEmail: SignUpWithEmail(_authRepository),
      signOut: SignOut(_authRepository),
      resetPassword: ResetPassword(_authRepository),
      deleteAccount: DeleteAccount(_authRepository),
    );

    _authBloc.add(const AuthStatusRequested());

    _router = createRouter(_authBloc);
  }

  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<IAuthRepository>.value(value: _authRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>.value(value: _authBloc),
          BlocProvider<NotificationBloc>(
            create: (_) => getIt<NotificationBloc>(),
          ),
          BlocProvider<UserBloc>(create: (_) => getIt<UserBloc>()),
        ],
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            state.whenOrNull(
              authenticated: (user) {
                context.read<UserBloc>().add(UserEvent.loadUser(user.id));
              },
              unauthenticated: () {
                context.read<UserBloc>().add(const UserEvent.clear());
              },
            );
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
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    FlutterNativeSplash.remove();
                  });

                  return Stack(
                    children: [
                      if (child != null) child,
                      if (state is UserState &&
                          state.maybeMap(
                            loading: (_) => true,
                            orElse: () => false,
                          ))
                        state.maybeMap(
                          loading: (loadingState) => GlobalLoadingPage(
                            sectorName: loadingState.cachedSector,
                          ),
                          orElse: () => const SizedBox.shrink(),
                        ),
                      if (state is UserState &&
                          state.maybeMap(
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
      ),
    );
  }
}
