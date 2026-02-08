import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PasswordRequirementRow extends StatefulWidget {
  const PasswordRequirementRow({
    super.key,
    required this.text,
    required this.isMet,
  });

  final String text;
  final bool isMet;

  @override
  State<PasswordRequirementRow> createState() => _PasswordRequirementRowState();
}

class _PasswordRequirementRowState extends State<PasswordRequirementRow> {
  @override
  void didUpdateWidget(covariant PasswordRequirementRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isMet && !oldWidget.isMet) {
      HapticFeedback.lightImpact();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = widget.isMet
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurfaceVariant;

    return Row(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Icon(
            widget.isMet ? Icons.check_circle : Icons.circle_outlined,
            key: ValueKey(widget.isMet),
            size: 20,
            color: color,
          ),
        ),
        const SizedBox(width: 8),
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: theme.textTheme.bodyMedium!.copyWith(
            color: color,
            fontWeight: widget.isMet ? FontWeight.bold : FontWeight.normal,
          ),
          child: Text(widget.text),
        ),
      ],
    );
  }
}
