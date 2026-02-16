import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/app_status/presentation/bloc/app_status_bloc.dart';
import 'package:bizzie/features/app_status/domain/models/app_status.dart';
import 'package:bizzie/features/app_status/presentation/views/force_upgrade_page.dart';
import 'package:bizzie/features/app_status/presentation/views/maintenance_page.dart';
import 'package:bizzie/features/app_status/presentation/views/no_internet_page.dart';

import 'package:bizzie/app/pages/global_error_page.dart';
import 'package:bizzie/app/pages/global_loading_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlobalOverlayWrapper extends StatelessWidget {
  final Widget? child;

  const GlobalOverlayWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        return BlocBuilder<AppStatusBloc, AppStatusState>(
          builder: (context, appStatusState) {
            return Stack(
              children: [
                if (child != null) child!,
                if (userState.maybeMap(
                  loading: (_) => true,
                  orElse: () => false,
                ))
                  userState.maybeMap(
                    loading: (loadingState) => GlobalLoadingPage(
                      sectorName: loadingState.cachedSector,
                    ),
                    orElse: () => const SizedBox.shrink(),
                  ),
                if (userState.maybeMap(
                  failure: (_) => true,
                  orElse: () => false,
                ))
                  userState.maybeMap(
                    failure: (failureState) => GlobalErrorPage(
                      sectorName: failureState.cachedSector,
                      onRetry: () => context.read<UserBloc>().add(
                        UserEvent.loadUser(uid: failureState.uid),
                      ),
                    ),
                    orElse: () => const SizedBox.shrink(),
                  ),

                appStatusState.maybeMap(
                  checked: (s) => s.status.maybeMap(
                    forceUpgrade: (status) => Positioned.fill(
                      child: ForceUpgradePage(status: status),
                    ),
                    maintenance: (_) =>
                        const Positioned.fill(child: MaintenancePage()),
                    noInternet: (_) =>
                        const Positioned.fill(child: NoInternetPage()),
                    orElse: () => const SizedBox.shrink(),
                  ),
                  orElse: () => const SizedBox.shrink(),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
