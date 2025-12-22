import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class MascotInfoCard extends StatelessWidget {
  const MascotInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.mascotCardGradientStart,
            AppColors.mascotCardGradientEnd,
          ],
          transform: GradientRotation(165 * 3.14159 / 180),
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.mascotCardBorder, width: 0.665),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.1),
            offset: const Offset(0, 1),
            blurRadius: 3,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.1),
            offset: const Offset(0, 1),
            blurRadius: 2,
            spreadRadius: -1,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Mascot Image & Dot
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
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.white,
                      width: 2, // Figma 1.994px
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.1),
                        offset: const Offset(0, 4),
                        blurRadius: 6,
                        spreadRadius: -1,
                      ),
                      BoxShadow(
                        color: AppColors.black.withValues(alpha: 0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                        spreadRadius: -2,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14), // Inner radius
                    child: Image.asset(
                      AppAssets.defaultMascot,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Notification Dot
                Positioned(
                  top: -4,
                  right: -4, // Overlapping edge
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: AppColors.primary, // #155DFC
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.white,
                        width: 2, // Figma 1.994px
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withValues(alpha: 0.1),
                          offset: const Offset(0, 1),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16), // Gap between image and text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Yannic',
                style: AppTextStyles.h2.copyWith(
                  fontSize: 19,
                  fontWeight: FontWeight.bold, // w700
                  color: AppColors.textPrimary,
                  height: 28.5 / 19, // Line height ratio
                  letterSpacing: -0.4453,
                ),
              ),
              // Gap 2px (Figma gap-[1.994px])
              const SizedBox(height: 2),
              Text(
                'Information Technology',
                style: AppTextStyles.bodySmall.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500, // Medium
                  color: AppColors.mascotSubtitle, // Distinct blue from primary
                  height: 21 / 14,
                  letterSpacing: -0.1504,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
