import 'package:bizzie/shared/widgets/loading/bizzie_loader.dart';
import 'package:bizzie/core/domain/models/sector.dart';
import 'package:bizzie/features/onboarding/presentation/utils/onboarding_assets_helper.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:flutter/material.dart';

class GlobalLoadingPage extends StatelessWidget {
  final String? sectorName;

  const GlobalLoadingPage({super.key, this.sectorName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String mascotPath = AppAssets.defaultMascot;
    if (sectorName != null) {
      final sector = Sector.fromString(sectorName!);
      if (sector != null) {
        mascotPath = OnboardingAssetsHelper.getMascotForSector(sector);
      }
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BizzieLoader(
        message: 'Setting things up for you',
        mascotAssetPath: mascotPath,
      ),
    );
  }
}
