import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/auth/presentation/views/create_account_page.dart';
import 'package:bizzie/features/auth/presentation/views/email_sent_page.dart';
import 'package:bizzie/features/auth/presentation/views/forgot_password_page.dart';
import 'package:bizzie/features/auth/presentation/views/login_page.dart';
import 'package:bizzie/features/home/presentation/views/home_page.dart';
import 'package:bizzie/features/notifications/presentation/views/notification_request_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: AppRoutes.createAccount,
      builder: (context, state) => const CreateAccountPage(),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: AppRoutes.emailSent,
      builder: (context, state) => const EmailSentPage(),
    ),
    GoRoute(
      path: AppRoutes.terms,
      builder: (context, state) =>
          const Scaffold(body: Center(child: Text('Terms of Service Screen'))),
    ),
    GoRoute(
      path: AppRoutes.privacy,
      builder: (context, state) =>
          const Scaffold(body: Center(child: Text('Privacy Policy Screen'))),
    ),
    GoRoute(
      path: AppRoutes.notificationRequest,
      builder: (context, state) => const NotificationRequestPage(),
    ),
  ],
);
