import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_gift_modal.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PaywallHelper {
  PaywallHelper._();

  static Future<void> showPaywallSequence(BuildContext context) async {
    final theme = Theme.of(context);
    // 1. Show regular paywall
    await context.push(AppRoutes.paywall);

    if (context.mounted) {
      // 2. Check if user is now subscribed
      final userState = context.read<UserBloc>().state;
      final isSubscribed = userState.maybeMap(
        loaded: (s) => s.user.isSubscribed,
        orElse: () => false,
      );

      if (!isSubscribed) {
        // 3. Show gift modal if not subscribed
        // The gift modal itself handles the redirection to discounted-paywall on dismissal
        showModalBottomSheet(
          context: context,
          backgroundColor: theme.colorScheme.scrim,
          builder: (context) => const SubscriptionGiftModal(),
        );
      }
    }
  }
}
