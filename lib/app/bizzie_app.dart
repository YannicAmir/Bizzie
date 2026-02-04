import 'package:bizzie/app/bizzie_app_view.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bizzie/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:bizzie/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bizzie/core/enums/environment.dart';
import 'package:bizzie/features/notifications/domain/models/notification_route.dart';

class BizzieApp extends StatelessWidget {
  final Environment environment;
  final NotificationRoute? initialNotificationRoute;

  const BizzieApp({
    super.key,
    required this.environment,
    this.initialNotificationRoute,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => getIt<AuthBloc>()),
        BlocProvider<NotificationBloc>(
          create: (_) => getIt<NotificationBloc>(),
        ),
        BlocProvider<UserBloc>(create: (_) => getIt<UserBloc>()),
        BlocProvider<WatchlistBloc>(create: (_) => getIt<WatchlistBloc>()),
        BlocProvider<SubscriptionBloc>(
          create: (_) => getIt<SubscriptionBloc>(),
        ),
        BlocProvider<ReportsBloc>(create: (_) => getIt<ReportsBloc>()),
      ],
      child: BizzieAppView(
        environment: environment,
        initialNotificationRoute: initialNotificationRoute,
      ),
    );
  }
}
