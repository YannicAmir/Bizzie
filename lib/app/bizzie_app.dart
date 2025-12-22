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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BizzieApp extends StatefulWidget {
  const BizzieApp({super.key});

  @override
  State<BizzieApp> createState() => _BizzieAppState();
}

class _BizzieAppState extends State<BizzieApp> {
  late final IAuthRepository _authRepository;
  late final AuthBloc _authBloc;

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
        providers: [BlocProvider<AuthBloc>.value(value: _authBloc)],
        child: MaterialApp.router(
          theme: AppTheme.lightTheme,
          routerConfig: router,
        ),
      ),
    );
  }
}
