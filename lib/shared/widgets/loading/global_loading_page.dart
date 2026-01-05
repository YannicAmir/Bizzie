import 'package:bizzie/app/themes/app_colors.dart';

import 'package:bizzie/features/onboarding/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/presentation/utils/onboarding_assets_helper.dart';
import 'package:flutter/material.dart';
import 'package:bizzie/app/themes/app_assets.dart';

class GlobalLoadingPage extends StatelessWidget {
  final String? sectorName;

  const GlobalLoadingPage({super.key, this.sectorName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 180,
                  height: 180,
                  child: CircularProgressIndicator(
                    strokeWidth: 10,
                    color: theme.colorScheme.primary,
                  ),
                ),
                SizedBox(
                  height: 90,
                  child: _MascotView(sectorName: sectorName),
                ),
              ],
            ),
            const SizedBox(height: 64),
            Text(
              'Setting things up for you',
              style: theme.textTheme.displayMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                height: 1.2,
                letterSpacing: 0.383,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MascotView extends StatelessWidget {
  final String? sectorName;

  const _MascotView({this.sectorName});

  @override
  Widget build(BuildContext context) {
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

    return Image.asset(
      assetPath,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          Icons.rocket_launch,
          size: 80,
          color: Theme.of(context).colorScheme.primary,
        );
      },
    );
  }
}
