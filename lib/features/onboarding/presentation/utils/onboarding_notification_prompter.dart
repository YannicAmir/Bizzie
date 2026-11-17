import 'dart:async';

import 'package:bizzie/app/router.dart';
import 'package:bizzie/core/logging/bizzie_logger.dart';
import 'package:bizzie/features/notifications/presentation/bloc/notification_bloc.dart';
import 'package:bizzie/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final _logger = BizzieLogger('OnboardingNotificationPrompter');

const _notificationSetupTimeout = Duration(minutes: 2);

class OnboardingNotificationPrompter {
  OnboardingNotificationPrompter._();

  static Future<void> promptOnboardingNotifications(
    BuildContext context,
  ) async {
    final onboardingBloc = context.read<OnboardingBloc>();
    final isGranted = await promptAndPersistGrant(context);
    onboardingBloc.add(
      OnboardingEvent.notificationsToggled(enabled: isGranted),
    );
  }

  static Future<bool> promptAndPersistGrant(BuildContext context) async {
    final onboardingBloc = context.read<OnboardingBloc>();
    final isGranted = await _requestNotificationSetup();
    if (isGranted) {
      onboardingBloc.add(
        const OnboardingEvent.notificationGrantPersistRequested(),
      );
    }
    return isGranted;
  }

  static Future<bool> _requestNotificationSetup() async {
    final rootContext = rootNavigatorKey.currentContext;
    if (rootContext == null || !rootContext.mounted) {
      _logger.warning('Root navigator unavailable; notification setup skipped');
      return false;
    }

    final notificationBloc = rootContext.read<NotificationBloc>();
    final setupOutcome = notificationBloc.stream
        .firstWhere(_isSetupOutcome)
        .timeout(_notificationSetupTimeout);
    notificationBloc.add(const NotificationEvent.setupRequested());

    try {
      final outcome = await setupOutcome;
      return outcome.status is NotificationStatusSuccess;
    } on TimeoutException {
      _logger.warning(
        'Notification setup produced no outcome within '
        '$_notificationSetupTimeout',
      );
      return false;
    } on StateError {
      _logger.warning('Notification state stream closed before setup outcome');
      return false;
    }
  }

  static bool _isSetupOutcome(NotificationState state) =>
      state.status is NotificationStatusSuccess ||
      state.status is NotificationStatusFailure;
}
