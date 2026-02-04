import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';
import 'package:bizzie/features/subscription/domain/extensions/subscription_package_extensions.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:flutter/material.dart';

class SubscriptionBottomActions extends StatelessWidget {
  final bool isAnnual;
  final bool isLoading;
  final SubscriptionPackage? selectedPackage;
  final VoidCallback onTap;

  const SubscriptionBottomActions({
    super.key,
    required this.isAnnual,
    required this.isLoading,
    required this.selectedPackage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isEligibleForTrial = selectedPackage?.isEligibleForTrial ?? false;
    final buttonTitle = isEligibleForTrial ? 'Start Free Trial' : 'Continue';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IgnorePointer(
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  theme.colorScheme.surface.withAlpha(0),
                  theme.colorScheme.surface,
                ],
              ),
            ),
          ),
        ),
        Container(
          color: theme.colorScheme.surface,
          padding: AppConstants.pagePadding.copyWith(top: 0, bottom: 8),
          child: Column(
            children: [
              BizziePrimaryButton(
                title: buttonTitle,
                isLoading: isLoading,
                onPressed: onTap,
              ),
              const SizedBox(height: 8),
              Text(
                selectedPackage?.renewalDisclaimer ??
                    (isAnnual
                        ? 'Auto-renews for \$240/year. Cancel anytime.'
                        : 'Auto-renews for \$34.95/month. Cancel anytime.'),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
