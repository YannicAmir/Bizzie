import 'package:bizzie/core/enums/guest_gate_trigger.dart';
import 'package:bizzie/features/auth/presentation/utils/guest_gate_helper.dart';
import 'package:bizzie/features/subscription/domain/models/subscription_package.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_event.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubscriptionPurchaseGate {
  SubscriptionPurchaseGate._();

  static Future<void> requestRestore(BuildContext context) => _addIfRegistered(
    context,
    trigger: GuestGateTrigger.restore,
    event: const SubscriptionEvent.restoreRequested(),
  );

  static Future<void> requestPurchase(
    BuildContext context, {
    required SubscriptionPackage package,
  }) => _addIfRegistered(
    context,
    trigger: GuestGateTrigger.subscribe,
    event: SubscriptionEvent.purchaseRequested(package),
  );

  static Future<void> _addIfRegistered(
    BuildContext context, {
    required GuestGateTrigger trigger,
    required SubscriptionEvent event,
  }) async {
    final bloc = context.read<SubscriptionBloc>();
    final canProceed = await GuestGateHelper.canProceedOrShowGate(
      context,
      trigger: trigger,
    );
    if (!canProceed) return;
    bloc.add(event);
  }
}
