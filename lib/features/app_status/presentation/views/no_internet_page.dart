import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/app_status/presentation/bloc/app_status_bloc.dart';
import 'package:bizzie/features/app_status/presentation/widgets/generic_status_page.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        String mascotAsset = AppAssets.defaultMascot;

        state.whenOrNull(
          loaded: (user) {
            mascotAsset = AppAssets.getMascotForSector(user.favoriteSector);
          },
        );

        final appStatusState = context.watch<AppStatusBloc>().state;
        final bool isLoading = appStatusState.maybeMap(
          checked: (s) => s.isRefreshing,
          orElse: () => false,
        );

        return GenericStatusPage(
          imageAsset: mascotAsset,
          title: 'No Internet',
          description: 'Please check your connection and try again',
          buttonText: 'Try Again',
          onButtonPressed: () {
            context.read<AppStatusBloc>().add(const AppStatusEvent.refreshed());
          },
          isLoading: isLoading,
        );
      },
    );
  }
}
