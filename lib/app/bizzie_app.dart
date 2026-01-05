import 'package:bizzie/app/bizzie_app_view.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_bloc.dart';

import 'package:bizzie/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BizzieApp extends StatelessWidget {
  const BizzieApp({super.key});

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
      child: const BizzieAppView(),
    );
  }
}
