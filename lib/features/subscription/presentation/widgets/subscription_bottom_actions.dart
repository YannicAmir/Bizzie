import 'package:bizzie/shared/widgets/bottom_fade_gradient.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:flutter/material.dart';

class SubscriptionBottomActions extends StatelessWidget {
  final bool isLoading;
  final String buttonTitle;
  final String disclaimer;
  final VoidCallback onTap;

  const SubscriptionBottomActions({
    super.key,
    required this.isLoading,
    required this.buttonTitle,
    required this.disclaimer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const BottomFadeGradient(),
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
                disclaimer,
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
