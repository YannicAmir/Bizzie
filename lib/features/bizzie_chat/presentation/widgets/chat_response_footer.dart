import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/bizzie_chat/presentation/widgets/chat_follow_up_chips.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatResponseFooter extends StatelessWidget {
  final List<String> followUps;
  final ValueChanged<String> onFollowUpTapped;

  const ChatResponseFooter({
    super.key,
    required this.followUps,
    required this.onFollowUpTapped,
  });

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
                icon: SvgPicture.asset(
                  AppAssets.likeIcon,
                  width: AppConstants.chatActionIconSize,
                  height: AppConstants.chatActionIconSize,
                  colorFilter: const ColorFilter.mode(
                    AppColors.slate500,
                    BlendMode.srcIn,
                  ),
                ),
                visualDensity: VisualDensity.compact,
              ),
              IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  AppAssets.dislikeIcon,
                  width: AppConstants.chatActionIconSize,
                  height: AppConstants.chatActionIconSize,
                  colorFilter: const ColorFilter.mode(
                    AppColors.slate500,
                    BlendMode.srcIn,
                  ),
                ),
                visualDensity: VisualDensity.compact,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.content_copy_outlined),
                iconSize: AppConstants.chatActionIconSize,
                visualDensity: VisualDensity.compact,
                color: AppColors.slate500,
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
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
