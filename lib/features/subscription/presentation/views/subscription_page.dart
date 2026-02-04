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

class _SubscriptionPageState extends State<SubscriptionPage>
    with WidgetsBindingObserver {
  bool _hasShownSuccess = false;

  bool _pendingSuccessOverlay = false;
  bool? _wasSubscribed;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Initialize _wasSubscribed based on current BLoC state to handle initial load
    final state = context.read<SubscriptionBloc>().state;
    _wasSubscribed = state.status.isSubscribed;

    // Safety: Reset purchase state when entering the page.
    // This prevents "Infinite Loading" if a previous session left the BLoC in a dirty state.
    context.read<SubscriptionBloc>().add(
      const SubscriptionEvent.resetPurchaseState(),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && _pendingSuccessOverlay) {
      _pendingSuccessOverlay = false;
      _safeShowSuccessOverlay();
      return;
    }
  }

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

                bool shouldShowOverlay = false;

                // Case 1: Explicit Purchase Success Override (e.g. Upgrade or new Purchase)
                if (state.maybeMap(
                  loaded: (s) => s.isLocalSuccessOverride,
                  orElse: () => false,
                )) {
                  shouldShowOverlay = true;
                }

                // Case 2: State Transition (False -> True)
                // This handles Restores or background updates where isLocalSuccessOverride might not be set
                final isSubscribed = state.status.isSubscribed;
                if (isSubscribed && (_wasSubscribed == false)) {
                  shouldShowOverlay = true;
                }

                // Update tracker
                _wasSubscribed = isSubscribed;

                if (shouldShowOverlay) {
                  _scheduleSuccessOverlay();
                }
              },
              child: BlocBuilder<SubscriptionBloc, SubscriptionState>(
                buildWhen: (previous, current) {
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

  void _scheduleSuccessOverlay() {
    final currentState = WidgetsBinding.instance.lifecycleState;

    if (currentState != AppLifecycleState.resumed) {
      _pendingSuccessOverlay = true;
    } else {
      _safeShowSuccessOverlay();
    }
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

    // Signal to the Bloc that the UI has handled the success state and is resumed,
    // so it can safely transition out of the purchase/loading state.
    context.read<SubscriptionBloc>().add(
      const SubscriptionEvent.purchaseUICompleted(),
    );
  }
}
