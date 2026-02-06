import 'package:bizzie/app/l10n/bizzie_localizations.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/profile/presentation/l10n/profile_localizations.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipPath(
      clipper: _ProfileHeaderClipper(),
      child: Container(
        height: 250,
        color: theme.colorScheme.primary,
        child: Stack(
          children: [
            Positioned(
              top: 60,
              left: 16,
              child: BlocBuilder<SubscriptionBloc, SubscriptionState>(
                builder: (context, state) {
                  if (state.status.isSubscribed) {
                    return const _PremiumBadge();
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            const Positioned(top: 60, right: 16, child: _SettingsButton()),
          ],
        ),
      ),
    );
  }
}

class _PremiumBadge extends StatelessWidget {
  const _PremiumBadge();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = BizzieLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(AppAssets.bizziePlusIcon, width: 24, height: 24),
          const SizedBox(width: 8),
          Text(
            l10n.bizziePlus,
            style: AppTextStyles.bodyMedium.copyWith(
              color: theme.colorScheme.surface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  const _SettingsButton();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimary.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.settings, color: theme.colorScheme.surface),
    );
  }
}

class _ProfileHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 20,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
