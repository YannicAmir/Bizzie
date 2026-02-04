import 'package:flutter/material.dart';

class BottomFadeGradient extends StatelessWidget {
  final double height;
  final Color? color;

  const BottomFadeGradient({super.key, this.height = 40, this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final fadeColor = color ?? theme.colorScheme.surface;

    return IgnorePointer(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [fadeColor.withAlpha(0), fadeColor],
          ),
        ),
      ),
    );
  }
}
