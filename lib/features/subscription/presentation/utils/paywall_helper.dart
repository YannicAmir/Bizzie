import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/core/constants/paywall_query_params.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_event.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_gift_modal.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/extensions/user_state_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PaywallHelper {
  PaywallHelper._();

  static Future<bool> showLockedTabPaywall(
    BuildContext context, {
    required String tabName,
    String? featureName,
  }) => showPaywallSequence(
    context,
    source: PaywallSource.company_profile,
    tabName: tabName,
    featureName: featureName,
  );

  static Future<bool> showPaywallSequence(
    BuildContext context, {
    required PaywallSource source,
    String? tabName,
    String? featureName,
    VoidCallback? onBackgroundSwapRequested,
  }) async {
    final theme = Theme.of(context);
    final queryParams = <String, String>{
      PaywallQueryParams.source: source.name,
      if (tabName != null) PaywallQueryParams.tabName: tabName,
      if (featureName != null) PaywallQueryParams.featureName: featureName,
    };

    await context.pushNamed(
      AppRoutes.paywall,
      queryParameters: queryParams,
      extra: onBackgroundSwapRequested,
    );
    if (!context.mounted) return false;
    if (_checkIsSubscribed(context)) return true;

    return _showGiftFallbackSequence(
      context,
      theme: theme,
      source: source,
      queryParams: queryParams,
    );
  }

  static Future<bool> _showGiftFallbackSequence(
    BuildContext context, {
    required ThemeData theme,
    required PaywallSource source,
    required Map<String, String> queryParams,
  }) async {
    final giftAccepted = await _showGiftModal(
      context,
      theme: theme,
      source: source,
    );
    if (!context.mounted) return false;
    if (!giftAccepted) {
      context.read<SubscriptionBloc>().add(
        SubscriptionEvent.giftDismissed(source: source),
      );
      return false;
    }

    await context.pushNamed(
      AppRoutes.discountedPaywall,
      queryParameters: queryParams,
    );
    if (!context.mounted) return false;
    return _checkIsSubscribed(context);
  }

  static Future<bool> _showGiftModal(
    BuildContext context, {
    required ThemeData theme,
    required PaywallSource source,
  }) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: theme.colorScheme.scrim,
      builder: (context) => SubscriptionGiftModal(source: source),
    );
    return result ?? false;
  }

  static bool _checkIsSubscribed(BuildContext context) {
    final isSubscribedViaUser = context.read<UserBloc>().state.isSubscribed;
    final isSubscribedViaSubscription =
        context.read<SubscriptionBloc>().state.status.isSubscribed;

    return isSubscribedViaUser || isSubscribedViaSubscription;
  }
}
