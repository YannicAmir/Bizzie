import 'package:bizzie/app/l10n/bizzie_localizations.dart';
import 'package:bizzie/features/profile/presentation/l10n/profile_localizations.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePremiumCard extends StatelessWidget {
  const ProfilePremiumCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(
          AppConstants.mainSectionBorderRadius,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppConstants.mainSectionContainerPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_HeaderContent(), SizedBox(height: 24), _SeeMoreButton()],
        ),
      ),
    );
  }
}

class _HeaderContent extends StatelessWidget {
  const _HeaderContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = BizzieLocalizations.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimary.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            AppAssets.bizziePlusIcon,
            width: 24,
            height: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.upgradeToBizziePlus,
                style: theme.textTheme.displaySmall?.copyWith(
                  color: theme.colorScheme.surface,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.subscribeToUnlock,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.surface,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SeeMoreButton extends StatelessWidget {
  const _SeeMoreButton();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = BizzieLocalizations.of(context);

    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: () {
          context.push(AppRoutes.paywall);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.surface,
          foregroundColor: theme.colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(l10n.seeMoreDetails),
      ),
    );
  }
}
