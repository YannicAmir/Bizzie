import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/app_status/presentation/widgets/generic_status_page.dart';
import 'package:flutter/material.dart';

class MaintenancePage extends StatelessWidget {
  const MaintenancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const GenericStatusPage(
      imageAsset: AppAssets.bizzieAwayNote,
      title: 'Bizzie will be back!',
      description:
          'Looking for your favorite brands & products in the Stock Market.',
      isLargeImage: true,
    );
  }
}
