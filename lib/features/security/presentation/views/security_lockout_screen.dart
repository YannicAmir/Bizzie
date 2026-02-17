import 'dart:io';

import 'package:bizzie/features/app_status/presentation/widgets/generic_status_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SecurityLockoutScreen extends StatelessWidget {
  const SecurityLockoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GenericStatusPage(
      icon: Icons.lock_outline_rounded,
      iconColor: theme.colorScheme.primary,
      title: 'Security Risk Detected',
      description:
          'This device does not meet the security requirements for Bizzie. Please use a verified device.',
      buttonText: 'Close App',
      onButtonPressed: () {
        try {
          SystemNavigator.pop();
        } catch (_) {}
        exit(0);
      },
    );
  }
}
