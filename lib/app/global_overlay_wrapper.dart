import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';

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
      builder: (context, state) {
        return Stack(
          children: [
            if (child != null) child!,
            if (state.maybeMap(loading: (_) => true, orElse: () => false))
              state.maybeMap(
                loading: (loadingState) =>
                    GlobalLoadingPage(sectorName: loadingState.cachedSector),
                orElse: () => const SizedBox.shrink(),
              ),
            if (state.maybeMap(failure: (_) => true, orElse: () => false))
              state.maybeMap(
                failure: (failureState) => GlobalErrorPage(
                  sectorName: failureState.cachedSector,
                  onRetry: () => context.read<UserBloc>().add(
                    UserEvent.loadUser(failureState.uid),
                  ),
                ),
                orElse: () => const SizedBox.shrink(),
              ),
          ],
        );
      },
    );
  }
}
