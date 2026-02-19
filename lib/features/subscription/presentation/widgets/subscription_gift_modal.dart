import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_event.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/shared/widgets/modals/app_bottom_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubscriptionGiftModal extends StatefulWidget {
  final PaywallSource source;

  const SubscriptionGiftModal({super.key, this.source = PaywallSource.unknown});

  @override
  State<SubscriptionGiftModal> createState() => _SubscriptionGiftModalState();
}

class _SubscriptionGiftModalState extends State<SubscriptionGiftModal> {
  @override
  void initState() {
    super.initState();
    context.read<SubscriptionBloc>().add(
      SubscriptionEvent.giftModalViewed(source: widget.source),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBottomModal(
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
                  context.read<SubscriptionBloc>().add(
                    SubscriptionEvent.giftClaimed(source: widget.source),
                  );
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
