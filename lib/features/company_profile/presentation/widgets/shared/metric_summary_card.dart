import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/app_badge.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MetricSummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final String badgeText;
  final AppBadgeStyle badgeStyle;
  final String subtitle;

  const MetricSummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.badgeText,
    required this.badgeStyle,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      // Design system compliance: Use standard colors or assume this matches previous implementation
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.slate200, width: 0.665),
        borderRadius: BorderRadius.circular(
          AppConstants.mainSectionBorderRadius,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Label + Value + Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left: Label + Value
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.slate500,
                      letterSpacing: -0.076,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.slate900,
                      letterSpacing: 0.38,
                    ),
                  ),
                ],
              ),
              // Right: Badge
              AppBadge(text: badgeText, style: badgeStyle),
            ],
          ),
          const SizedBox(height: 16),
          // Row 2: Description Text
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.slate600,
              letterSpacing: -0.076,
            ),
          ),
        ],
      ),
    );
  }
}
