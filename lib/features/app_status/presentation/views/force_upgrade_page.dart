import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/app_status/domain/models/app_status.dart';
import 'package:bizzie/shared/utils/url_launcher_utils.dart';
import 'package:flutter/material.dart';

import 'package:bizzie/features/app_status/presentation/widgets/generic_status_page.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForceUpgradePage extends StatelessWidget {
  final AppStatus status;

  const ForceUpgradePage({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final String storeUrl = status.maybeMap(
      forceUpgrade: (s) => s.storeUrl,
      orElse: () => '',
    );

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        String mascotAsset = AppAssets.defaultMascot;

        state.whenOrNull(
          loaded: (user) {
            mascotAsset = AppAssets.getMascotForSector(user.favoriteSector);
          },
        );

        return GenericStatusPage(
          imageAsset: mascotAsset,
          title: 'Update Required',
          description:
              'A new version of Bizzie is available. Please update to continue using the app and access the latest features.',
          buttonText: 'Update Now',
          onButtonPressed: () {
            UrlLauncherUtils.launch(
              storeUrl,
              onError: (message) {
                if (context.mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(message)));
                }
              },
            );
          },
        );
      },
    );
  }
}
