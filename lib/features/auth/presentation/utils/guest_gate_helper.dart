import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/core/enums/guest_gate_trigger.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bizzie/features/auth/presentation/bloc/auth_event.dart';
import 'package:bizzie/shared/widgets/modals/bizzie_snackbar.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

const _accountCreatedMessage = 'Account created';

class GuestGateHelper {
  GuestGateHelper._();

  static Future<bool> ensureRegistered(
    BuildContext context, {
    required GuestGateTrigger trigger,
  }) async {
    if (!_isGuest(context)) return true;

    return await _openGate(
      context,
      startEvent: AuthEvent.guestGateShown(trigger: trigger),
    );
  }

  static Future<bool> linkAccount(
    BuildContext context, {
    required GuestGateTrigger trigger,
  }) => _openGate(
    context,
    startEvent: AuthEvent.guestLinkStarted(trigger: trigger),
  );

  static Future<bool> canProceedOrShowGate(
    BuildContext context, {
    required GuestGateTrigger trigger,
  }) async {
    if (!_isGuest(context)) return true;

    final authBloc = context.read<AuthBloc>();
    final guestId = authBloc.state.userId;
    final isRegistered = await ensureRegistered(context, trigger: trigger);
    return isRegistered && _isSameAccount(authBloc, guestId);
  }

  static Future<bool> openCreateAccount(BuildContext context) async {
    final authBloc = context.read<AuthBloc>();
    final guestId = authBloc.state.userId;
    final isRegistered =
        await context.push<bool>(AppRoutes.guestCreateAccount) ?? false;
    final isNewAccount = isRegistered && _isSameAccount(authBloc, guestId);
    if (isNewAccount && context.mounted) _showAccountCreated(context);
    return isRegistered;
  }

  static Future<bool> _openGate(
    BuildContext context, {
    required AuthEvent startEvent,
  }) async {
    final authBloc = context.read<AuthBloc>();
    authBloc.add(startEvent);
    final isRegistered = await openCreateAccount(context);
    if (!isRegistered) authBloc.add(const AuthEvent.guestGateDismissed());
    return isRegistered;
  }

  static bool _isGuest(BuildContext context) =>
      context.read<AuthBloc>().state.isGuest;

  static bool _isSameAccount(AuthBloc authBloc, String? guestId) =>
      guestId != null && authBloc.state.userId == guestId;

  static void _showAccountCreated(BuildContext context) {
    BizzieSnackBar.show(
      context,
      message: _accountCreatedMessage,
      type: BizzieSnackBarType.brand,
    );
  }
}
