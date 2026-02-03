import 'package:bizzie/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_event.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_state.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/bloc/user_state_extensions.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_loaded_content.dart';
import 'package:bizzie/shared/widgets/error/bizzie_error.dart';
import 'package:bizzie/shared/widgets/loading/bizzie_loader.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_success_overlay.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  // Flag to prevent double-triggering the success overlay
  // (e.g. from Restore Success + Stream Update happening in rapid succession)
  bool _hasShownSuccess = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocSelector<UserBloc, UserState, String>(
      selector: (state) => state.mascotAsset,
      builder: (context, mascotAsset) {
        return Scaffold(
          body: SafeArea(
            child: BlocListener<SubscriptionBloc, SubscriptionState>(
              listener: (context, state) {
                if (state.failure != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.failure!.message),
                      backgroundColor: theme.colorScheme.error,
                    ),
                  );
                }

                if (state.maybeMap(
                  loaded: (s) => s.isLocalSuccessOverride,
                  orElse: () => false,
                )) {
                  _safeShowSuccessOverlay();
                }

                // Handle Restore Success:
                // If the user is now subscribed (via restore) and loading has finished,
                // trigger the success flow if it hasn't been triggered already.
                if (state.status.isSubscribed && !state.isLoading) {
                  // Verify we aren't in a transient error state
                  if (state.failure == null) {
                    _safeShowSuccessOverlay();
                  }
                }
              },
              child: BlocBuilder<SubscriptionBloc, SubscriptionState>(
                buildWhen: (previous, current) {
                  // Allow rebuilds even if subscribed so we can transition out of loading states.
                  return true;
                },
                builder: (context, subscriptionState) {
                  return subscriptionState.map(
                    initial: (_) => BizzieLoader(
                      message: 'Loading subscription',
                      mascotAssetPath: mascotAsset,
                    ),
                    loading: (_) => BizzieLoader(
                      message: 'Loading subscription',
                      mascotAssetPath: mascotAsset,
                    ),
                    loaded: (s) => SubscriptionLoadedContent(
                      state: s,
                      mascotAsset: mascotAsset,
                    ),
                    failure: (s) => BizzieError(
                      message: s.failure.message,
                      onRetry: () => context.read<SubscriptionBloc>().add(
                        const SubscriptionEvent.offeringsRequested(),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void _safeShowSuccessOverlay() {
    if (_hasShownSuccess) return;
    if (!mounted) return;

    _hasShownSuccess = true;

    final userState = context.read<UserBloc>().state;
    final userName = userState.maybeMap(
      loaded: (s) => s.user.name,
      orElse: () => null,
    );

    SubscriptionSuccessOverlay.show(
      context,
      userName: userName ?? 'Friend',
      onDismiss: () {
        if (mounted) {
          context.go(AppRoutes.home);
        }
      },
    );
  }
}
