import 'package:bizzie/features/settings/domain/enums/guest_logout_choice.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/shared/widgets/modals/app_bottom_modal.dart';
import 'package:flutter/material.dart';

class GuestLogoutConfirmationSheet extends StatelessWidget {
  const GuestLogoutConfirmationSheet({super.key});

  static Future<GuestLogoutChoice> show(BuildContext context) async {
    final choice = await showModalBottomSheet<GuestLogoutChoice>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const GuestLogoutConfirmationSheet(),
    );
    return choice ?? GuestLogoutChoice.dismissed;
  }

  @override
  Widget build(BuildContext context) {
    return AppBottomModal(
      useDraggable: false,
      title: 'Log out of guest account?',
      subtitle: const Text(
        "You're using a guest account. If you log out, your watchlist and preferences will be lost. Create an account to keep them.",
      ),
      builder: (context, _) {
        return Padding(
          padding: AppConstants.confirmationSheetPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppConstants.subSectionSpacing,
              BizziePrimaryButton(
                title: 'Create Account',
                onPressed: () =>
                    Navigator.pop(context, GuestLogoutChoice.createAccount),
              ),
              AppConstants.secondarySectionSpacing,
              const _LogOutAnywayButton(),
              AppConstants.subSectionSpacing,
            ],
          ),
        );
      },
    );
  }
}

class _LogOutAnywayButton extends StatelessWidget {
  const _LogOutAnywayButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppConstants.mainButtonHeight,
      child: TextButton(
        onPressed: () => Navigator.pop(context, GuestLogoutChoice.logOut),
        style: TextButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.error,
        ),
        child: const Text('Log out anyway'),
      ),
    );
  }
}
