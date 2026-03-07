import 'package:bizzie/app/bizzie_app_view.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bizzie/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:bizzie/features/app_status/presentation/bloc/app_status_bloc.dart';
import 'package:bizzie/features/security/presentation/bloc/security_bloc.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:bizzie/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:bizzie/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bizzie/core/enums/environment.dart';

class BizzieApp extends StatelessWidget {
  final Environment environment;
  final Map<String, dynamic>? initialNotificationPayload;

  const BizzieApp({
    super.key,
    required this.environment,
    this.initialNotificationPayload,
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
        BlocProvider<AppStatusBloc>(create: (_) => getIt<AppStatusBloc>()),
        BlocProvider<SecurityBloc>(create: (_) => getIt<SecurityBloc>()),
        BlocProvider<OnboardingBloc>(create: (_) => getIt<OnboardingBloc>()),
        BlocProvider<ProfileBloc>(create: (_) => getIt<ProfileBloc>()),
      ],
      child: BizzieAppView(
        environment: environment,
        initialNotificationPayload: initialNotificationPayload,
      ),
    );
  }
}
