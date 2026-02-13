import 'package:bizzie/app/themes/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class BizzieAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BizzieAppBar({
    super.key,
    required this.title,
    this.onClose,
    this.centerTitle = false,
  });

  final String title;
  final VoidCallback? onClose;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      title: Text(title, style: theme.textTheme.displayMedium),
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      actions: [
        GestureDetector(
          onTap: onClose ?? () => context.pop(),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 16.0),
            child: SvgPicture.asset(
              AppAssets.modalCloseIcon,
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                theme.colorScheme.onSurface,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
