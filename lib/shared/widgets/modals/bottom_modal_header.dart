import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomModalHeader extends StatelessWidget {
  final String title;
  final Widget? subtitle;
  final VoidCallback? onClose;

  const BottomModalHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        const _DragHandle(),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.displayMedium),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    subtitle!,
                  ],
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: onClose ?? () => Navigator.pop(context),
                child: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: SvgPicture.asset(
                    AppAssets.modalCloseIcon,
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DragHandle extends StatelessWidget {
  const _DragHandle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: AppColors.slate300,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
