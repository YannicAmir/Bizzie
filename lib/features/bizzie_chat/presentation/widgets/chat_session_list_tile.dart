import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/bizzie_chat/domain/models/chat_session.dart';
import 'package:flutter/material.dart';

const double _kTilePaddingV = 12.0;

class ChatSessionListTile extends StatelessWidget {
  final ChatSession session;
  final VoidCallback onTap;

  const ChatSessionListTile({
    super.key,
    required this.session,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: _kTilePaddingV),
        child: Text(
          session.title,
          style: AppTextStyles.bodyMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
