import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

class ChatEmptyState extends StatelessWidget {
  const ChatEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.chatEmptyStatePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: AppConstants.chatEmptyStateIconContainerSize,
              height: AppConstants.chatEmptyStateIconContainerSize,
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.auto_awesome_rounded,
                color: colorScheme.primary,
                size: AppConstants.chatEmptyStateIconSize,
              ),
            ),
            AppConstants.secondarySectionSpacing,
            Text(
              'Ask Bizzie',
              style: AppTextStyles.h3,
              textAlign: TextAlign.center,
            ),
            AppConstants.subSectionSpacing,
            Text(
              'Get AI insights on financials, performance, and more.',
              style: AppTextStyles.bodyMediumSecondary,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
