import 'package:bizzie/shared/widgets/error/bizzie_error.dart';
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

    return Scaffold(
      body: BizzieError(
        message:
            'We couldn\'t load your profile. Please check your connection and try again.',
        mascotAssetPath: assetPath,
        onRetry: onRetry,
      ),
    );
  }
}
