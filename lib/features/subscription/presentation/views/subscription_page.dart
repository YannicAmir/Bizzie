import 'package:bizzie/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_event.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_state.dart';
import 'package:bizzie/features/subscription/domain/enums/paywall_type.dart';
import 'package:bizzie/features/subscription/presentation/extensions/subscription_state_extensions.dart';
import 'package:bizzie/features/subscription/presentation/utils/onboarding_paywall_reporter.dart';
import 'package:bizzie/features/subscription/presentation/utils/paywall_helper.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_loaded_content.dart';
import 'package:bizzie/shared/widgets/error/bizzie_error.dart';
import 'package:bizzie/shared/widgets/loading/bizzie_loader.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_success_overlay.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/modals/bizzie_snackbar.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SubscriptionPage extends StatefulWidget {
  final bool isUpgradeFlow;
  final PaywallSource source;
  final String? tabName;
  final String? featureName;
  final VoidCallback? onEnter;

  const SubscriptionPage({
    super.key,
    this.isUpgradeFlow = false,
    this.source = PaywallSource.unknown,
    this.tabName,
    this.featureName,
    this.onEnter,
  });

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
    final state = context.read<SubscriptionBloc>().state;
    _wasSubscribed = state.status.isSubscribed;

    context.read<SubscriptionBloc>().add(
      const SubscriptionEvent.resetPurchaseState(),
    );

    context.read<SubscriptionBloc>().add(
      SubscriptionEvent.viewed(
        source: widget.source,
        paywallType: PaywallType.regular,
        tabName: widget.tabName,
        featureName: widget.featureName,
      ),
    );
    OnboardingPaywallReporter.paywallViewed(
      context,
      source: widget.source,
      paywallType: PaywallType.regular,
    );

    if (widget.onEnter != null) {
      Future.delayed(AppConstants.paywallOnEnterDelay, () {
        if (mounted) widget.onEnter!();
      });
    }
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
    return BlocSelector<UserBloc, UserState, String>(
      selector: (state) => state.mascotAsset,
      builder: (context, mascotAsset) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: Scaffold(
            body: SafeArea(
              child: BlocListener<SubscriptionBloc, SubscriptionState>(
                listenWhen: (previous, current) =>
                    previous.completedPurchaseType == null &&
                    current.completedPurchaseType != null,
                listener: (context, state) {
                  final purchasedPackageType = state.completedPurchaseType;
                  if (purchasedPackageType == null) return;
                  OnboardingPaywallReporter.purchaseCompleted(
                    context,
                    source: widget.source,
                    packageType: purchasedPackageType,
                  );
                },
                child: BlocListener<SubscriptionBloc, SubscriptionState>(
                  listener: (context, state) {
                    if (state.failure != null) {
                      BizzieSnackBar.show(
                        context,
                        message: state.failure!.message,
                        type: BizzieSnackBarType.error,
                      );
                    }
                    bool shouldShowOverlay = false;

                    if (state.maybeMap(
                      loaded: (s) => s.isLocalSuccessOverride,
                      orElse: () => false,
                    )) {
                      shouldShowOverlay = true;
                    }

                    final isSubscribed = state.status.isSubscribed;
                    if (isSubscribed && (_wasSubscribed == false)) {
                      shouldShowOverlay = true;
                    }
                    _wasSubscribed = isSubscribed;

                    if (shouldShowOverlay) {
                      _scheduleSuccessOverlay();
                    }
                  },
                  child: BlocBuilder<SubscriptionBloc, SubscriptionState>(
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
                          message: s.failure.errorMessage,
                          onRetry: () => context.read<SubscriptionBloc>().add(
                            const SubscriptionEvent.offeringsRequested(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
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

    SubscriptionSuccessOverlay.show(
      context,
      userName: context.read<UserBloc>().state.displayName,
      onDismiss: () {
        if (mounted) {
          if (widget.isUpgradeFlow) {
            context.pop(true);
          } else {
            PaywallHelper.closePaywall(context);
          }
        }
      },
    );

    context.read<SubscriptionBloc>().add(
      const SubscriptionEvent.purchaseUICompleted(),
    );
  }
}
