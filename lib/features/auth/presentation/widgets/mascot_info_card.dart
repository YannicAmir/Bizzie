import 'package:bizzie/app/themes/app_theme.dart';
import 'package:flutter/material.dart';

class MascotInfoCard extends StatelessWidget {
  final String name;
  final String sectorName;
  final String mascotAsset;

  const MascotInfoCard({
    super.key,
    required this.name,
    required this.sectorName,
    required this.mascotAsset,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mascotTheme = theme.extension<MascotThemeExtension>()!;

    return Container(
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: mascotTheme.gradientColors,
          transform: const GradientRotation(165 * 3.14159 / 180),
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: mascotTheme.borderColor, width: 0.665),
        boxShadow: mascotTheme.cardShadows,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 64,
            height: 64,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: mascotTheme.innerContainerShadows,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(mascotAsset, fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: mascotTheme.badgeShadows,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: theme.textTheme.displayMedium?.copyWith(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                  height: 28.5 / 19,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                sectorName,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: mascotTheme.subtitleColor,
                  height: 21 / 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
