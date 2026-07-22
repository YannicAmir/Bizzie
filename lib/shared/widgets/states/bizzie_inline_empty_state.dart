import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class BizzieInlineEmptyState extends StatelessWidget {
  final String mascotAsset;
  final String message;
  final String actionLabel;
  final VoidCallback onAction;

  const BizzieInlineEmptyState({
    super.key,
    required this.mascotAsset,
    required this.message,
    required this.actionLabel,
    required this.onAction,
  });

  static const double _mascotSize = 56;
  static const double _mascotSpacing = 16;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: _mascotSize,
          width: _mascotSize,
          child: Image.asset(
            mascotAsset,
            fit: BoxFit.contain,
            excludeFromSemantics: true,
          ),
        ),
        const SizedBox(width: _mascotSpacing),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message, style: AppTextStyles.bodyMediumSecondary),
              InkWell(
                onTap: onAction,
                splashColor: theme.colorScheme.scrim,
                highlightColor: theme.colorScheme.scrim,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    actionLabel,
                    style: AppTextStyles.bodyMediumBold.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
