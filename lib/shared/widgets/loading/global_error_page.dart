import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/onboarding/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/presentation/utils/onboarding_assets_helper.dart';
import 'package:flutter/material.dart';
import 'package:bizzie/app/themes/app_assets.dart';

class GlobalErrorPage extends StatelessWidget {
  final String? sectorName;
  final VoidCallback onRetry;

  const GlobalErrorPage({super.key, this.sectorName, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMascot(),
              const SizedBox(height: 32),
              Text(
                'Something went wrong',
                style: AppTextStyles.h2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'We couldn\'t load your profile. Please check your connection and try again.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              FilledButton(
                onPressed: onRetry,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMascot() {
    Sector? sector;
    if (sectorName != null) {
      try {
        sector = Sector.values.byName(sectorName!);
      } catch (_) {
        sector = Sector.fromString(sectorName!);
      }
    }

    final String assetPath;
    if (sector != null) {
      assetPath = OnboardingAssetsHelper.getMascotForSector(sector);
    } else {
      assetPath = AppAssets.defaultMascot;
    }

    return SizedBox(
      height: 180,
      child: Image.asset(
        assetPath,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(
            Icons.error_outline,
            size: 80,
            color: AppColors.criticalText,
          );
        },
      ),
    );
  }
}
