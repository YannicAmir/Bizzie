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

  static Future<bool> showPaywallSequence(
    BuildContext context, {
    required PaywallSource source,
    String? tabName,
    String? featureName,
    VoidCallback? onBackgroundSwapRequested,
  }) async {
    final theme = Theme.of(context);

    // 1. Show regular paywall
    final Map<String, String> queryParams = {'source': source.name};
    if (tabName != null) queryParams['tabName'] = tabName;
    if (featureName != null) queryParams['featureName'] = featureName;

    await context.pushNamed(
      AppRoutes.paywall,
      queryParameters: queryParams,
      extra: onBackgroundSwapRequested,
    );

    if (context.mounted) {
      // 2. Check if user is now subscribed
      if (_checkIsSubscribed(context)) return true;

      // 3. Show gift modal if not subscribed
      final result = await showModalBottomSheet<bool>(
        context: context,
        backgroundColor: theme.colorScheme.scrim,
        builder: (context) => SubscriptionGiftModal(source: source),
      );

      if (context.mounted) {
        if (result != true) {
          context.read<SubscriptionBloc>().add(
            SubscriptionEvent.giftDismissed(source: source),
          );
        } else {
          // 4. Show discount paywall
          await context.pushNamed(
            AppRoutes.discountedPaywall,
            queryParameters: queryParams,
          );

          if (context.mounted) {
            return _checkIsSubscribed(context);
          }
        }
      }
    }
    return false;
  }

  static bool _checkIsSubscribed(BuildContext context) {
    final userState = context.read<UserBloc>().state;
    final subscriptionState = context.read<SubscriptionBloc>().state;

    final isSubscribedViaUser = userState.maybeMap(
      loaded: (s) => s.user.isSubscribed,
      orElse: () => false,
    );
    final isSubscribedViaSubscription = subscriptionState.status.isSubscribed;

    return isSubscribedViaUser || isSubscribedViaSubscription;
  }
}
