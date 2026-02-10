import 'package:bizzie/features/profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:bizzie/features/profile/presentation/bloc/edit_profile_event.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_secondary_button.dart';
import 'package:bizzie/shared/widgets/modals/app_bottom_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteAccountConfirmationSheet extends StatelessWidget {
  const DeleteAccountConfirmationSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBottomModal(
      useDraggable: false,
      title: 'Delete Account?',
      subtitle: const Text(
        'This action cannot be undone. Are you sure you want to delete your account?',
      ),
      builder: (context, scrollController) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                    context.read<EditProfileBloc>().add(
                      const EditProfileEvent.deleteAccountConfirmed(),
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    foregroundColor: Theme.of(context).colorScheme.onError,
                  ),
                  child: const Text('Delete'),
                ),
              ),
              const SizedBox(height: 16),
              BizzieSecondaryButton(
                title: 'Cancel',
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}
