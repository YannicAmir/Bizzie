import 'package:bizzie/features/profile/presentation/widgets/profile_field_with_header.dart';
import 'package:bizzie/features/user/domain/usecases/get_user_usecase.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';

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
  late final GetUserUseCase _getUserUseCase;

  @override
  void initState() {
    super.initState();
    _getUserUseCase = GetIt.I<GetUserUseCase>();
  }

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
    return BlocListener<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        state.mapOrNull(
          success: (_) => context.pop(),
          form: (s) {
            if (s.saveFailure != null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(s.saveFailure!.message)));
            }
          },
          failure: (s) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(s.failure.message)));
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
          leading: BackButton(color: Theme.of(context).colorScheme.onSurface),
        ),
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
                initial: (_) => BizzieLoader(
                  message: 'Loading your profile...',
                  mascotAssetPath: AppAssets.getMascotForSector(
                    _getUserUseCase.cachedSector ?? '',
                  ),
                ),
                loading: (s) => BizzieLoader(
                  message: 'Loading your profile...',
                  mascotAssetPath: AppAssets.getMascotForSector(
                    s.favoriteSector ?? '',
                  ),
                ),
                success: (_) => const SizedBox.shrink(),
                failure: (s) => BizzieError(
                  message: s.failure.message,
                  mascotAssetPath: AppAssets.getMascotForSector(
                    s.favoriteSector ?? '',
                  ),
                  onRetry: () => context.read<EditProfileBloc>().add(
                    const EditProfileEvent.started(),
                  ),
                ),
                form: (s) {
                  if (_firstNameController.text.isEmpty &&
                      s.firstName.isNotEmpty) {
                    _firstNameController.text = s.firstName;
                  }
                  if (_emailController.text.isEmpty && s.email.isNotEmpty) {
                    _emailController.text = s.email;
                  }

                  final hasChanges =
                      s.firstName != s.originalFirstName ||
                      s.email != s.originalEmail;
                  final canSave = hasChanges && !s.isSubmitting;

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
                          ),
                          const Spacer(),
                          BizziePrimaryButton(
                            title: 'Save Changes',
                            onPressed: canSave
                                ? () => _onSavePressed(context)
                                : null,
                            isLoading: s.isSubmitting,
                          ),
                          const SizedBox(height: 16),
                          _DeleteAccountButton(
                            onPressed: () => _showDeleteConfirmation(context),
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

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Account?'),
        content: const Text(
          'This action cannot be undone. Are you sure you want to delete your account?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<EditProfileBloc>().add(
                const EditProfileEvent.deleteAccountRequested(),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
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

  const _ProfileForm({
    required this.firstNameController,
    required this.emailController,
    required this.passwordController,
    required this.onFirstNameChanged,
    required this.onEmailChanged,
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
            validator: (val) =>
                val == null || val.isEmpty ? 'Name cannot be empty' : null,
            onChanged: onFirstNameChanged,
          ),
        ),
        ProfileFieldWithHeader(
          header: 'Email',
          child: AuthTextField(
            controller: emailController,
            hintText: '',
            iconPath: AppAssets.authEmailIcon,
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
            onTap: () => context.pushNamed(AppRoutes.changePassword),
          ),
        ),
      ],
    );
  }
}

class _DeleteAccountButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _DeleteAccountButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.error,
      ),
      child: const Text('Delete Account'),
    );
  }
}
