import 'package:bizzie/shared/widgets/buttons/bizzie_close_icon.dart';
import 'package:material_ui/material_ui.dart';
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
            child: BizzieCloseIcon(color: theme.colorScheme.onSurface),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
