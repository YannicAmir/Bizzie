import 'package:bizzie/shared/widgets/modals/bottom_modal_header.dart';
import 'package:flutter/material.dart';

class AppBottomModal extends StatelessWidget {
  final String title;
  final Widget Function(BuildContext context, ScrollController scrollController)
  builder;
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final Widget? subtitle;
  final bool useDraggable;
  final EdgeInsets? contentPadding;

  const AppBottomModal({
    super.key,
    required this.title,
    required this.builder,
    this.initialChildSize = 0.875,
    this.minChildSize = 0.5,
    this.maxChildSize = 0.875,
    this.subtitle,
    this.useDraggable = true,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (!useDraggable) {
      return Container(
        padding: EdgeInsets.only(
          bottom:
              MediaQuery.of(context).viewInsets.bottom +
              MediaQuery.of(context).padding.bottom +
              16,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomModalHeader(
              title: title,
              subtitle: subtitle,
              onClose: () => Navigator.pop(context),
            ),
            Padding(
              padding: contentPadding ?? EdgeInsets.zero,
              child: builder(context, ScrollController()),
            ),
          ],
        ),
      );
    }

    return DraggableScrollableSheet(
      initialChildSize: initialChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              BottomModalHeader(
                title: title,
                subtitle: subtitle,
                onClose: () => Navigator.pop(context),
              ),
              Expanded(
                child: Padding(
                  padding: contentPadding ?? EdgeInsets.zero,
                  child: builder(context, scrollController),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
