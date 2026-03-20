import 'package:bizzie/features/profile/presentation/widgets/delete_account_confirmation_sheet.dart';
import 'package:bizzie/features/profile/domain/enums/reauth_action.dart';
import 'package:bizzie/features/profile/presentation/widgets/profile_field_with_header.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/app_bar/bizzie_app_bar.dart';
import 'package:bizzie/shared/widgets/loading/bizzie_loader.dart';
import 'package:bizzie/shared/widgets/error/bizzie_error.dart';
import 'package:bizzie/app/routes/app_routes.dart';
import 'package:bizzie/features/profile/presentation/bloc/edit_profile_bloc.dart';
import 'package:bizzie/features/profile/presentation/bloc/edit_profile_event.dart';
import 'package:bizzie/features/profile/presentation/bloc/edit_profile_state.dart';
import 'package:bizzie/shared/utils/validators.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/shared/widgets/inputs/auth_text_field.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/shared/widgets/modals/bizzie_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';
import 'package:bizzie/features/profile/presentation/widgets/reauth_bottom_sheet.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          GetIt.I<EditProfileBloc>()..add(const EditProfileEvent.started()),
      child: const _EditProfileViewContent(),
    );
  }
}

class _EditProfileViewContent extends StatefulWidget {
  const _EditProfileViewContent();

  @override
  State<_EditProfileViewContent> createState() =>
      _EditProfileViewContentState();
}

class _EditProfileViewContentState extends State<_EditProfileViewContent> {
  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController(text: '••••••••');
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _firstNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSavePressed(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<EditProfileBloc>().add(
        const EditProfileEvent.saveRequested(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<EditProfileBloc, EditProfileState>(
          listenWhen: (previous, current) {
            final wasShowing = previous.maybeMap(
              form: (f) => f.isShowReauthModal,
              orElse: () => false,
            );
            final isShowing = current.maybeMap(
              form: (f) => f.isShowReauthModal,
              orElse: () => false,
            );
            return !wasShowing && isShowing;
          },
          listener: (context, state) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => BlocProvider.value(
                value: context.read<EditProfileBloc>(),
                child: const ReAuthBottomSheet(),
              ),
            ).then((_) {
              if (!context.mounted) return;
              final bloc = context.read<EditProfileBloc>();
              final currentState = bloc.state;
              final stillThinkingOpen = currentState.maybeMap(
                form: (f) => f.isShowReauthModal,
                orElse: () => false,
              );

              if (stillThinkingOpen) {
                bloc.add(const EditProfileEvent.reauthModalDismissed());
              } else {
                currentState.mapOrNull(
                  form: (f) {
                    if (f.pendingReauthAction == ReauthAction.deleteAccount) {
                      bloc.add(const EditProfileEvent.showDeleteConfirmation());
                    }
                  },
                );
              }
            });
          },
        ),
        BlocListener<EditProfileBloc, EditProfileState>(
          listenWhen: (previous, current) {
            final wasShowing = previous.maybeMap(
              form: (f) => f.isShowDeleteConfirmation,
              orElse: () => false,
            );
            final isShowing = current.maybeMap(
              form: (f) => f.isShowDeleteConfirmation,
              orElse: () => false,
            );
            return !wasShowing && isShowing;
          },
          listener: (context, state) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => BlocProvider.value(
                value: context.read<EditProfileBloc>(),
                child: const DeleteAccountConfirmationSheet(),
              ),
            ).then((_) {
              if (!context.mounted) return;
              final bloc = context.read<EditProfileBloc>();
              final stillShowing = bloc.state.maybeMap(
                form: (f) => f.isShowDeleteConfirmation,
                orElse: () => false,
              );
              if (stillShowing) {
                bloc.add(const EditProfileEvent.deleteConfirmationDismissed());
              }
            });
          },
        ),
        BlocListener<EditProfileBloc, EditProfileState>(
          listener: (context, state) {
            state.mapOrNull(
              success: (_) => context.pop(),
              deleted: (_) {
                // Do not pop here. The global router listener will redirect
                // to login/onboarding once the auth state changes.
                // Popping manually causes a race condition crash.
              },
              form: (s) {
                if (s.saveFailure != null) {
                  BizzieSnackBar.show(
                    context,
                    message: s.saveFailure!.message,
                    type: BizzieSnackBarType.error,
                  );
                }
              },
              failure: (s) {
                BizzieSnackBar.show(
                  context,
                  message: s.failure.errorMessage,
                  type: BizzieSnackBarType.error,
                );
              },
            );
          },
        ),
      ],
      child: Scaffold(
        appBar: const BizzieAppBar(title: 'Edit Profile'),
        body: SafeArea(
          child: BlocConsumer<EditProfileBloc, EditProfileState>(
            listener: (context, state) {
              state.mapOrNull(
                form: (s) {
                  if (_firstNameController.text != s.firstName) {
                    _firstNameController.text = s.firstName;
                  }
                  if (_emailController.text != s.email) {
                    _emailController.text = s.email;
                  }
                },
              );
            },
            listenWhen: (previous, current) {
              return previous.maybeMap(
                    loading: (_) => true,
                    orElse: () => false,
                  ) &&
                  current.maybeMap(form: (_) => true, orElse: () => false);
            },
            builder: (context, state) {
              return state.map(
                initial: (s) => BizzieLoader(
                  message: 'Loading your profile...',
                  mascotAssetPath: AppAssets.getMascotForSector(
                    s.favoriteSector ?? '',
                  ),
                ),
                loading: (s) => BizzieLoader(
                  message: 'Loading your profile...',
                  mascotAssetPath: AppAssets.getMascotForSector(
                    s.favoriteSector ?? '',
                  ),
                ),
                success: (s) => BizzieLoader(
                  message: 'Profile updated successfully!',
                  mascotAssetPath: AppAssets.getMascotForSector(
                    s.favoriteSector ?? '',
                  ),
                ),
                failure: (s) => BizzieError(
                  message: s.failure.errorMessage,
                  mascotAssetPath: AppAssets.getMascotForSector(
                    s.favoriteSector ?? '',
                  ),
                  onRetry: () => context.read<EditProfileBloc>().add(
                    const EditProfileEvent.started(),
                  ),
                ),
                deleted: (s) => BizzieLoader(
                  message: 'Deleting account',
                  mascotAssetPath: AppAssets.getMascotForSector(
                    s.favoriteSector ?? '',
                  ),
                ),
                form: (s) {
                  return Padding(
                    padding: AppConstants.pagePadding,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _ProfileForm(
                            firstNameController: _firstNameController,
                            emailController: _emailController,
                            passwordController: _passwordController,
                            onFirstNameChanged: (val) => context
                                .read<EditProfileBloc>()
                                .add(EditProfileEvent.firstNameChanged(val)),
                            onEmailChanged: (val) => context
                                .read<EditProfileBloc>()
                                .add(EditProfileEvent.emailChanged(val)),
                            hasPasswordProvider: s.hasPasswordProvider,
                            onPasswordTap: () =>
                                context.pushNamed(AppRoutes.changePassword),
                          ),
                          const Spacer(),
                          BizziePrimaryButton(
                            title: 'Save Changes',
                            onPressed: state.canSave
                                ? () => _onSavePressed(context)
                                : null,
                            isLoading: s.isSubmitting,
                          ),
                          const SizedBox(height: 16),
                          _DeleteAccountButton(
                            onPressed: s.isDeleting || s.isSubmitting
                                ? null
                                : () => context.read<EditProfileBloc>().add(
                                    const EditProfileEvent.deleteAccountRequested(),
                                  ),
                            isLoading: s.isDeleting,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ProfileForm extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final ValueChanged<String> onFirstNameChanged;
  final ValueChanged<String> onEmailChanged;
  final bool hasPasswordProvider;
  final VoidCallback onPasswordTap;

  const _ProfileForm({
    required this.firstNameController,
    required this.emailController,
    required this.passwordController,
    required this.onFirstNameChanged,
    required this.onEmailChanged,
    required this.hasPasswordProvider,
    required this.onPasswordTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileFieldWithHeader(
          header: 'Name',
          child: AuthTextField(
            controller: firstNameController,
            hintText: '',
            iconPath: AppAssets.homeProfileUnselectedIcon,
            validator: Validators.validateName,
            onChanged: onFirstNameChanged,
          ),
        ),
        if (hasPasswordProvider) ...[
          ProfileFieldWithHeader(
            header: 'Email',
            child: AuthTextField(
              controller: emailController,
              hintText: '',
              iconPath: AppAssets.authEmailIcon,
              readOnly: true,
              hideReadOnlyFocus: true,
              validator: Validators.validateEmail,
              onChanged: onEmailChanged,
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          ProfileFieldWithHeader(
            header: 'Password',
            bottomMargin: 0,
            child: AuthTextField(
              controller: passwordController,
              hintText: '',
              iconPath: AppAssets.authLockIcon,
              readOnly: true,
              onTap: onPasswordTap,
            ),
          ),
        ],
      ],
    );
  }
}

class _DeleteAccountButton extends StatelessWidget {
  final VoidCallback? onPressed;

  final bool isLoading;
  const _DeleteAccountButton({required this.onPressed, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: theme.colorScheme.error,
        splashFactory: NoSplash.splashFactory,
      ),
      child: const Text('Delete Account'),
    );
  }
}
