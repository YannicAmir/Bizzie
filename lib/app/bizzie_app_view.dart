import 'dart:async';
import 'package:bizzie/app/l10n/bizzie_localizations.dart';

import 'package:bizzie/app/global_overlay_wrapper.dart';
import 'package:bizzie/core/interfaces/i_notification_service.dart';
import 'package:bizzie/di/injection.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/router.dart';
import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_event.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_state.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_event.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_bloc.dart';
import 'package:bizzie/features/reports/presentation/bloc/reports_event.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_event.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';

import 'package:bizzie/core/enums/environment.dart';
import 'package:bizzie/features/notifications/domain/models/notification_route.dart';

class BizzieAppView extends StatefulWidget {
  final Environment environment;
  final NotificationRoute? initialNotificationRoute;

  const BizzieAppView({
    super.key,
    required this.environment,
    this.initialNotificationRoute,
  });

  @override
  State<BizzieAppView> createState() => _BizzieAppViewState();
}

class _BizzieAppViewState extends State<BizzieAppView>
    with WidgetsBindingObserver {
  late final GoRouter _router;
  late final StreamSubscription _notificationSubscription;

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _notificationSubscription.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<SubscriptionBloc>().add(
        const SubscriptionEvent.appResumed(),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _router = createRouter(
      context.read<AuthBloc>(),
      context.read<UserBloc>(),
      initialLocation: widget.initialNotificationRoute?.path,
    );
    context.read<AuthBloc>().add(const AuthEvent.statusRequested());
    context.read<SubscriptionBloc>().add(const SubscriptionEvent.initialized());

    _setupNotifications();
  }

  void _setupNotifications() {
    final notificationService = getIt<INotificationService>();
    _notificationSubscription = notificationService.routeStream.listen((route) {
      if (route.path == AppRoutes.discountedPaywall) {
        _router.push(route.path, extra: route.extra);
      } else {
        _router.go(route.path, extra: route.extra);
      }
    });
    notificationService.setupInteractions();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          authenticated: (user) {
            final currentPath = _router.routeInformationProvider.value.uri.path;
            final isFromCreateAccount = currentPath == AppRoutes.createAccount;

            context.read<UserBloc>().add(
              UserEvent.loadUser(uid: user.id, silent: isFromCreateAccount),
            );
            context.read<WatchlistBloc>().add(
              WatchlistEvent.loadRequested(uid: user.id),
            );
            context.read<NotificationBloc>().add(
              const NotificationEvent.setupRequested(),
            );
            context.read<SubscriptionBloc>().add(
              const SubscriptionEvent.initialized(),
            );
            context.read<ReportsBloc>().add(ReportsEvent.started(uid: user.id));
          },
          unauthenticated: () {
            context.read<UserBloc>().add(const UserEvent.clear());
            context.read<WatchlistBloc>().add(const WatchlistEvent.reset());
            context.read<NotificationBloc>().add(
              const NotificationEvent.reset(),
            );
            context.read<SubscriptionBloc>().add(
              const SubscriptionEvent.userIdentityChanged(null),
            );
            context.read<ReportsBloc>().add(const ReportsEvent.reset());
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
        localizationsDelegates: const [BizzieLocalizationsDelegate()],
        supportedLocales: BizzieLocalizations.supportedLocales,
        routerConfig: _router,
        debugShowCheckedModeBanner: widget.environment == Environment.dev,
        builder: (context, child) => GlobalOverlayWrapper(child: child),
      ),
    );
  }
}
