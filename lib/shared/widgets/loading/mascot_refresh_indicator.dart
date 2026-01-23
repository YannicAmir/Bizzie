import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MascotRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const MascotRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final mascotAsset = state.maybeMap(
          loaded: (u) => AppAssets.getMascotForSector(u.user.favoriteSector),
          orElse: () => AppAssets.defaultMascot,
        );

        return CustomRefreshIndicator(
          onRefresh: () async {
            await onRefresh();
          },
          builder:
              (
                BuildContext context,
                Widget child,
                IndicatorController controller,
              ) {
                return Stack(
                  children: [
                    if (!controller.isIdle && !controller.isLoading)
                      Positioned(
                        top: 20 * controller.value,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Opacity(
                            opacity: controller.value.clamp(0.0, 1.0),
                            child: Transform.scale(
                              scale: controller.value.clamp(0.0, 1.0),
                              child: Image.asset(
                                mascotAsset,
                                height: 40,
                                width: 40,
                              ),
                            ),
                          ),
                        ),
                      ),
                    child,
                  ],
                );
              },
          child: child,
        );
      },
    );
  }
}
