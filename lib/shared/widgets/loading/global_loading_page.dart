import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/onboarding/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/presentation/utils/onboarding_assets_helper.dart';
import 'package:flutter/material.dart';
import 'package:bizzie/app/themes/app_assets.dart';

class GlobalLoadingPage extends StatelessWidget {
  final String? sectorName;

  const GlobalLoadingPage({super.key, this.sectorName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMascot(),
            const SizedBox(height: 32),
            const CircularProgressIndicator(color: AppColors.primary),
            const SizedBox(height: 24),
            Text(
              'Setting things up for you...',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMascot() {
    Sector? sector;
    if (sectorName != null) {
      try {
        // Try by name (e.g. 'informationTechnology')
        sector = Sector.values.byName(sectorName!);
      } catch (_) {
        // Try by display name (e.g. 'Information Technology')
        sector = Sector.fromString(sectorName!);
      }
    }

    final String assetPath;
    if (sector != null) {
      assetPath = OnboardingAssetsHelper.getMascotForSector(sector);
    } else {
      assetPath = AppAssets
          .defaultMascot; // Ensure this exists or use OnboardingAssetsHelper default
    }

    // Using a fixed height to prevent layout shifts if assets vary slightly
    return SizedBox(
      height: 200,
      child: Image.asset(
        assetPath,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          // Fallback to simpler icon if asset missing
          return const Icon(
            Icons.rocket_launch,
            size: 80,
            color: AppColors.primary,
          );
        },
      ),
    );
  }
}
