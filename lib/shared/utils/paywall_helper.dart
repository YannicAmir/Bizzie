import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_event.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_gift_modal.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PaywallHelper {
  PaywallHelper._();

  static Future<void> showPaywallSequence(
    BuildContext context, {
    required PaywallSource source,
    String? tabName,
    String? featureName,
  }) async {
    final theme = Theme.of(context);
    // 1. Show regular paywall
    String route = '${AppRoutes.paywall}?source=${source.name}';
    if (tabName != null) route += '&tabName=$tabName';
    if (featureName != null) route += '&featureName=$featureName';

    await context.push(route);

    if (context.mounted) {
      // 2. Check if user is now subscribed
      final userState = context.read<UserBloc>().state;
      final subscriptionState = context.read<SubscriptionBloc>().state;

      final isSubscribedViaUser = userState.maybeMap(
        loaded: (s) => s.user.isSubscribed,
        orElse: () => false,
      );
      final isSubscribedViaSubscription = subscriptionState.status.isSubscribed;

      final isSubscribed = isSubscribedViaUser || isSubscribedViaSubscription;

      if (!isSubscribed) {
        // 3. Show gift modal if not subscribed
        final result = await showModalBottomSheet<bool>(
          context: context,
          backgroundColor: theme.colorScheme.scrim,
          builder: (context) => SubscriptionGiftModal(source: source),
        );

        if (context.mounted && result != true) {
          context.read<SubscriptionBloc>().add(
            SubscriptionEvent.giftDismissed(source: source),
          );
        }
      }
    }
  }
}
