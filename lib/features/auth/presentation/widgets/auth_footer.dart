import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/di/injection.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_event.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final configService = getIt<IConfigService>();
    final linkStyle = theme.textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.primary,
      decoration: TextDecoration.underline,
    );

    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
          children: [
            const TextSpan(text: 'By continuing, you agree to our '),
            TextSpan(
              text: 'Terms of Service',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.read<AuthBloc>().add(
                    AuthEvent.legalLinkOpened(configService.termsOfServiceUrl),
                  );
                },
            ),
            const TextSpan(text: ' and '),
            TextSpan(
              text: 'Privacy Policy',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  context.read<AuthBloc>().add(
                    AuthEvent.legalLinkOpened(configService.privacyPolicyUrl),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
