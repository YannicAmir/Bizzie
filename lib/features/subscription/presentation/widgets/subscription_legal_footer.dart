import 'package:bizzie/core/interfaces/i_config_service.dart';
import 'package:bizzie/di/injection.dart';
import 'package:bizzie/features/settings/domain/usecases/launch_url_usecase.dart';
import 'package:flutter/material.dart';

class SubscriptionLegalFooter extends StatelessWidget {
  final VoidCallback onRestore;

  const SubscriptionLegalFooter({super.key, required this.onRestore});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final configService = getIt<IConfigService>();
    final launchUrl = getIt<LaunchUrlUseCase>();

    final textStyle = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () => launchUrl(configService.termsOfServiceUrl),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            splashFactory: NoSplash.splashFactory,
          ),
          child: Text('Terms of Service', style: textStyle),
        ),
        TextButton(
          onPressed: () => launchUrl(configService.privacyPolicyUrl),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            splashFactory: NoSplash.splashFactory,
          ),
          child: Text('Privacy Policy', style: textStyle),
        ),
        TextButton(
          onPressed: onRestore,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            splashFactory: NoSplash.splashFactory,
          ),
          child: Text('Restore Purchase', style: textStyle),
        ),
      ],
    );
  }
}
