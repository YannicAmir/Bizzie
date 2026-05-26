import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/bizzie_chat/domain/enums/rating_type.dart';
import 'package:bizzie/features/bizzie_chat/presentation/widgets/chat_follow_up_chips.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatResponseFooter extends StatelessWidget {
  final List<String> followUps;
  final ValueChanged<String> onFollowUpTapped;
  final RatingType? currentRating;
  final String aiResponse;
  final VoidCallback? onLike;
  final VoidCallback? onDislike;

  const ChatResponseFooter({
    super.key,
    required this.followUps,
    required this.onFollowUpTapped,
    required this.aiResponse,
    this.currentRating,
    this.onLike,
    this.onDislike,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final likeColor = currentRating == RatingType.positive
        ? colorScheme.primary
        : colorScheme.onSurfaceVariant;
    final dislikeColor = currentRating == RatingType.negative
        ? colorScheme.primary
        : colorScheme.onSurfaceVariant;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (followUps.isNotEmpty)
          ChatFollowUpDropdown(
            followUps: followUps,
            onFollowUpTapped: onFollowUpTapped,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppConstants.chatFooterFeedbackPaddingV,
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: onLike,
                icon: SvgPicture.asset(
                  AppAssets.likeIcon,
                  width: AppConstants.chatActionIconSize,
                  height: AppConstants.chatActionIconSize,
                  colorFilter: ColorFilter.mode(likeColor, BlendMode.srcIn),
                ),
                visualDensity: VisualDensity.compact,
              ),
              IconButton(
                onPressed: onDislike,
                icon: SvgPicture.asset(
                  AppAssets.dislikeIcon,
                  width: AppConstants.chatActionIconSize,
                  height: AppConstants.chatActionIconSize,
                  colorFilter: ColorFilter.mode(dislikeColor, BlendMode.srcIn),
                ),
                visualDensity: VisualDensity.compact,
              ),
              IconButton(
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: aiResponse));
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Copied to clipboard')),
                    );
                  }
                },
                icon: const Icon(Icons.content_copy_outlined),
                iconSize: AppConstants.chatActionIconSize,
                visualDensity: VisualDensity.compact,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
        AppConstants.secondarySectionSpacing,
        Padding(
          padding: const EdgeInsets.only(
            bottom: AppConstants.chatFooterDisclaimerPaddingBottom,
          ),
          child: Text(
            'Bizzie AI can make mistakes. Please verify all information presented.',
            style: AppTextStyles.smallLink,
          ),
        ),
      ],
    );
  }
}
