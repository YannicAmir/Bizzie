import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:material_ui/material_ui.dart';

enum FilingCardActionStyle { primary, secondary }

class FilingCardActionButton extends StatelessWidget {
  final Widget Function(Color color) iconBuilder;
  final String label;
  final FilingCardActionStyle style;
  final AlignmentGeometry alignment;
  final VoidCallback onTap;

  const FilingCardActionButton({
    super.key,
    required this.iconBuilder,
    required this.label,
    required this.style,
    required this.onTap,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final badgeTheme = theme.extension<BadgeThemeExtension>();
    final color = switch (style) {
      FilingCardActionStyle.primary =>
        badgeTheme?.neutralText ?? theme.colorScheme.primary,
      FilingCardActionStyle.secondary =>
        badgeTheme?.voidText ?? theme.colorScheme.onSurfaceVariant,
    };

    return Tooltip(
      message: label,
      excludeFromSemantics: true,
      child: Semantics(
        button: true,
        label: label,
        excludeSemantics: true,
        child: InkResponse(
          onTap: onTap,
          radius: AppConstants.minTouchTargetSize.width / 2,
          child: SizedBox.fromSize(
            size: AppConstants.minTouchTargetSize,
            child: Align(alignment: alignment, child: iconBuilder(color)),
          ),
        ),
      ),
    );
  }
}

class FilingCardActionsRow extends StatelessWidget {
  final Widget? leading;
  final Widget trailing;

  const FilingCardActionsRow({super.key, this.leading, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [?leading, trailing],
    );
  }
}
