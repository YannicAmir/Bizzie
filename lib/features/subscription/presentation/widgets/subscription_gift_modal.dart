import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/shared/widgets/modals/app_bottom_modal.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SubscriptionGiftModal extends StatelessWidget {
  const SubscriptionGiftModal({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              context.pushNamed(AppRoutes.discountedPaywall);
            }
          });
        }
      },
      child: AppBottomModal(
        title: 'We have a gift for you!',
        subtitle: const Text(
          'Enjoy 40% off the annual plan when you upgrade today.',
        ),
        useDraggable: false,
        builder: (context, scrollController) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 24),
                BizziePrimaryButton(
                  title: 'Claim your gift!',
                  onPressed: () {
                    context.pop();
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}
