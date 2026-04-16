import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

class ChatFollowUpDropdown extends StatefulWidget {
  final List<String> followUps;
  final ValueChanged<String> onFollowUpTapped;

  const ChatFollowUpDropdown({
    super.key,
    required this.followUps,
    required this.onFollowUpTapped,
  });

  @override
  State<ChatFollowUpDropdown> createState() => _ChatFollowUpDropdownState();
}

class _ChatFollowUpDropdownState extends State<ChatFollowUpDropdown> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    if (widget.followUps.isEmpty) return const SizedBox.shrink();

    final onSurfaceVariant = Theme.of(context).colorScheme.onSurfaceVariant;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppConstants.chatFollowUpHeaderPaddingV,
            ),
            child: Row(
              children: [
                Text(
                  'Follow-up Questions',
                  style: AppTextStyles.bodyMediumBold,
                ),
                const Spacer(),
                AnimatedRotation(
                  turns: _expanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: AppConstants.chatFollowUpChevronSize,
                    color: onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: _expanded
              ? Padding(
                  padding: const EdgeInsets.only(
                    left: AppConstants.chatFollowUpHeaderPaddingH,
                    right: AppConstants.chatFollowUpHeaderPaddingH,
                    bottom: AppConstants.chatFollowUpItemPaddingV,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (final q in widget.followUps)
                        GestureDetector(
                          onTap: () => widget.onFollowUpTapped(q),
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppConstants.chatFollowUpItemPaddingV,
                            ),
                            child: Text(q, style: AppTextStyles.bodyMedium),
                          ),
                        ),
                    ],
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
