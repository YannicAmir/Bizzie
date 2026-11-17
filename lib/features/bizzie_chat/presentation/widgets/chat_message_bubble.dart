import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/bizzie_chat/domain/enums/chat_message_role.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_message.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:material_ui/material_ui.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

final TextStyle _markdownBodyStyle = AppTextStyles.bodyMedium.copyWith(
  height: AppConstants.chatMarkdownLineHeight,
);

GptMarkdownThemeData _buildMarkdownTheme(BuildContext context) {
  final theme = Theme.of(context);
  final colorScheme = theme.colorScheme;
  return GptMarkdownThemeData(
    brightness: theme.brightness,
    h1: AppTextStyles.h1,
    h2: AppTextStyles.h2,
    h3: AppTextStyles.h3,
    inlineCode: InlineCodeStyle(
      fontFamily: AppTextStyles.bodyMedium.fontFamily,
    ),
    styleSheet: GptMarkdownStyleSheet(
      codeBlock: CodeBlockStyle(
        backgroundColor: colorScheme.tertiaryContainer,
        borderRadius: const Radius.circular(
          AppConstants.chatMarkdownCodeRadius,
        ),
        fontFamily: AppTextStyles.bodyMedium.fontFamily,
        fontSize: AppTextStyles.bodyMedium.fontSize,
        showLanguageLabel: false,
        showCopyButton: false,
      ),
      blockQuote: BlockQuoteStyle(
        backgroundColor: colorScheme.secondaryContainer,
        barColor: colorScheme.primary,
        barWidth: AppConstants.chatMarkdownBlockquoteBorderWidth,
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.chatMarkdownBlockquotePaddingH,
          vertical: AppConstants.chatMarkdownBlockquotePaddingV,
        ),
      ),
      list: ListStyle(
        indent: AppConstants.chatMarkdownListIndent,
        markerTextStyle: _markdownBodyStyle,
      ),
      blockSpacing: AppConstants.chatMarkdownBlockSpacing,
    ),
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
    final markdown = GptMarkdownTheme(
      gptThemeData: _buildMarkdownTheme(context),
      child: GptMarkdown(
        content,
        style: _markdownBodyStyle,
        onLinkTap: (_, _) {},
      ),
    );

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
          if (selectable) SelectionArea(child: markdown) else markdown,
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
