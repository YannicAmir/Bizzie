import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

class ChatScrollToBottomButton extends StatelessWidget {
  final VoidCallback onTap;

  const ChatScrollToBottomButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppConstants.chatFabSize,
        height: AppConstants.chatFabSize,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: theme.colorScheme.surface,
          size: AppConstants.chatFabIconSize,
        ),
      ),
    );
  }
}
