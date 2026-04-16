import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

class ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool isEnabled;
  final String companyName;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
    required this.companyName,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.chatInputPaddingH,
        vertical: AppConstants.chatInputPaddingV,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(top: BorderSide(color: colorScheme.outline)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.inputBackground,
                borderRadius: BorderRadius.circular(AppConstants.chatInputBorderRadius),
                border: Border.all(color: colorScheme.outline),
              ),
              child: TextField(
                controller: controller,
                enabled: isEnabled,
                maxLines: 4,
                minLines: 1,
                maxLength: 500,
                style: AppTextStyles.bodyMedium,
                textCapitalization: TextCapitalization.sentences,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) {
                  if (isEnabled) onSend();
                },
                decoration: InputDecoration(
                  hintText: companyName.isNotEmpty
                      ? 'Ask Bizzie about $companyName...'
                      : 'Ask Bizzie...',
                  hintStyle: AppTextStyles.bodyMediumSecondary,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.chatInputPaddingH,
                    vertical: AppConstants.chatInputPaddingV,
                  ),
                  counterText: '',
                ),
              ),
            ),
          ),
          const SizedBox(width: AppConstants.chatSendButtonSpacing),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, _) {
              final canSend = isEnabled && value.text.trim().isNotEmpty;
              return _SendButton(onTap: canSend ? onSend : null);
            },
          ),
        ],
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _SendButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isActive = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: AppConstants.chatSendButtonSize,
        height: AppConstants.chatSendButtonSize,
        decoration: BoxDecoration(
          color: isActive ? colorScheme.primary : AppColors.slate200,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.arrow_upward_rounded,
          color: isActive ? colorScheme.onPrimary : AppColors.slate400,
          size: AppConstants.chatSendIconSize,
        ),
      ),
    );
  }
}
