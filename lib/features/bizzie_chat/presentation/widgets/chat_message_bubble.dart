import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/bizzie_chat/domain/enums/chat_message_role.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_message.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

MarkdownStyleSheet _buildMarkdownStyleSheet(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  return MarkdownStyleSheet(
    p: AppTextStyles.bodyMedium.copyWith(height: AppConstants.chatMarkdownLineHeight),
    strong: AppTextStyles.bodyMediumBold.copyWith(height: AppConstants.chatMarkdownLineHeight),
    em: AppTextStyles.bodyMedium.copyWith(fontStyle: FontStyle.italic),
    h1: AppTextStyles.h1,
    h2: AppTextStyles.h2,
    h3: AppTextStyles.h3,
    listBullet: AppTextStyles.bodyMedium.copyWith(height: AppConstants.chatMarkdownLineHeight),
    code: AppTextStyles.bodyMedium,
    codeblockDecoration: BoxDecoration(
      color: colorScheme.tertiaryContainer,
      borderRadius: BorderRadius.circular(AppConstants.chatMarkdownCodeRadius),
    ),
    blockquoteDecoration: BoxDecoration(
      color: colorScheme.secondaryContainer,
      border: Border(
        left: BorderSide(
          color: colorScheme.primary,
          width: AppConstants.chatMarkdownBlockquoteBorderWidth,
        ),
      ),
    ),
    blockquotePadding: const EdgeInsets.symmetric(
      horizontal: AppConstants.chatMarkdownBlockquotePaddingH,
      vertical: AppConstants.chatMarkdownBlockquotePaddingV,
    ),
    blockSpacing: AppConstants.chatMarkdownBlockSpacing,
    listIndent: AppConstants.chatMarkdownListIndent,
  );
}

class AssistantMessageBubble extends StatelessWidget {
  final String content;
  final String mascotAsset;
  final bool selectable;

  const AssistantMessageBubble({
    super.key,
    required this.content,
    required this.mascotAsset,
    this.selectable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppConstants.chatBubbleVerticalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            mascotAsset,
            width: AppConstants.chatBubbleMascotSize,
            height: AppConstants.chatBubbleMascotSize,
          ),
          const SizedBox(height: AppConstants.chatBubbleMascotSpacing),
          MarkdownBody(
            data: content,
            selectable: selectable,
            softLineBreak: true,
            styleSheet: _buildMarkdownStyleSheet(context),
            onTapLink: (_, __, ___) {},
          ),
        ],
      ),
    );
  }
}

class ChatMessageBubble extends StatelessWidget {
  final ChatMessage message;
  final String mascotAsset;

  const ChatMessageBubble({
    super.key,
    required this.message,
    required this.mascotAsset,
  });

  bool get _isUser => message.role == ChatMessageRole.user;

  @override
  Widget build(BuildContext context) {
    if (_isUser) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppConstants.chatUserBubbleVerticalPadding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Flexible(child: _UserBubble(content: message.content))],
        ),
      );
    }

    return AssistantMessageBubble(
      content: message.content,
      mascotAsset: mascotAsset,
      selectable: true,
    );
  }
}

class _UserBubble extends StatelessWidget {
  final String content;
  const _UserBubble({required this.content});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.chatBubblePaddingH,
        vertical: AppConstants.chatBubblePaddingV,
      ),
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppConstants.chatBubbleRadiusLarge),
          topRight: Radius.circular(AppConstants.chatBubbleRadiusLarge),
          bottomLeft: Radius.circular(AppConstants.chatBubbleRadiusLarge),
          bottomRight: Radius.circular(AppConstants.chatBubbleRadiusSmall),
        ),
      ),
      child: SelectableText(
        content,
        style: AppTextStyles.bodyMedium.copyWith(color: colorScheme.onPrimary),
      ),
    );
  }
}
