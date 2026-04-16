import 'package:bizzie/features/bizzie_chat/domain/enums/chat_message_role.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_message.dart';
import 'package:bizzie/features/bizzie_chat/presentation/widgets/bizzie_thinking_indicator.dart';
import 'package:bizzie/features/bizzie_chat/presentation/widgets/chat_empty_state.dart';
import 'package:bizzie/features/bizzie_chat/presentation/widgets/chat_message_bubble.dart';
import 'package:bizzie/features/bizzie_chat/presentation/widgets/chat_response_footer.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

class ChatMessageList extends StatelessWidget {
  final List<ChatMessage> messages;
  final bool isStreaming;
  final String? streamingContent;
  final bool showSpacer;
  final List<String> followUps;
  final ValueChanged<String> onFollowUpTapped;
  final ScrollController scrollController;
  final String mascotAsset;
  final GlobalKey lastUserMessageKey;

  const ChatMessageList({
    super.key,
    required this.messages,
    required this.isStreaming,
    required this.streamingContent,
    required this.showSpacer,
    required this.followUps,
    required this.onFollowUpTapped,
    required this.scrollController,
    required this.mascotAsset,
    required this.lastUserMessageKey,
  });

  @override
  Widget build(BuildContext context) {
    if (messages.isEmpty && !isStreaming) {
      return const ChatEmptyState();
    }

    final hasStreamingContent =
        streamingContent != null && streamingContent!.isNotEmpty;
    final showFooter = !showSpacer && messages.isNotEmpty;
    final itemCount =
        messages.length + (showSpacer ? 2 : (showFooter ? 1 : 0));

    return LayoutBuilder(
      builder: (context, constraints) {
        final spacerHeight = constraints.maxHeight;

        return ListView.builder(
          controller: scrollController,
          physics: const ClampingScrollPhysics(),
          padding: AppConstants.chatListPadding,
          itemCount: itemCount,
          itemBuilder: (context, index) {
            if (showSpacer && index == messages.length + 1) {
              return SizedBox(height: spacerHeight);
            }

            if (index == messages.length) {
              if (showSpacer) {
                if (hasStreamingContent) {
                  return AssistantMessageBubble(
                    content: streamingContent!,
                    mascotAsset: mascotAsset,
                    selectable: false,
                  );
                }
                return BizzieThinkingIndicator(mascotAsset: mascotAsset);
              }
              if (showFooter) {
                return ChatResponseFooter(
                  followUps: followUps,
                  onFollowUpTapped: onFollowUpTapped,
                );
              }
              return const SizedBox.shrink();
            }

            final msg = messages[index];
            final lastUserIndex = messages.lastIndexWhere(
              (m) => m.role == ChatMessageRole.user,
            );

            if (msg.role == ChatMessageRole.assistant) {
              return AssistantMessageBubble(
                content: msg.content,
                mascotAsset: mascotAsset,
                selectable: true,
              );
            }

            return ChatMessageBubble(
              key: index == lastUserIndex ? lastUserMessageKey : null,
              message: msg,
              mascotAsset: mascotAsset,
            );
          },
        );
      },
    );
  }
}
