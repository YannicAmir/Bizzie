import 'package:bizzie/di/injection.dart';
import 'package:bizzie/features/feedback/presentation/bloc/feedback_bloc.dart';
import 'package:bizzie/features/feedback/presentation/bloc/feedback_event.dart';
import 'package:bizzie/features/feedback/presentation/bloc/feedback_state.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/utils/validators.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/shared/widgets/inputs/bizzie_text_field.dart';
import 'package:bizzie/shared/widgets/modals/app_bottom_modal.dart';
import 'package:bizzie/shared/widgets/modals/bizzie_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FeedbackModal extends StatefulWidget {
  final String? intentSource;

  const FeedbackModal({this.intentSource, super.key});

  static void show(BuildContext context, {String? intentSource}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider(
        create: (context) => getIt<FeedbackBloc>(),
        child: FeedbackModal(intentSource: intentSource),
      ),
    );
  }

  @override
  State<FeedbackModal> createState() => _FeedbackModalState();
}

class _FeedbackModalState extends State<FeedbackModal> {
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<FeedbackBloc>().add(
          FeedbackEvent.viewed(intentSource: widget.intentSource),
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedbackBloc, FeedbackState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (isCoolingDown) {
            context.pop();

            HapticFeedback.lightImpact();

            BizzieSnackBar.show(
              context,
              message: 'Thank you for your feedback!',
              type: BizzieSnackBarType.success,
            );
          },
          failure: (failure, isCoolingDown) {
            BizzieSnackBar.show(
              context,
              message: failure.message,
              type: BizzieSnackBarType.error,
            );
          },
        );
      },
      builder: (context, state) {
        final isLoading = state.maybeMap(
          loading: (_) => true,
          orElse: () => false,
        );

        final isCoolingDown = state.isCoolingDown;
        final isButtonEnabled = !isLoading && !isCoolingDown;

        return AppBottomModal(
          title: 'Send Feedback',
          subtitle: const Text(
            'We would love to hear your thoughts, suggestions, or issues.',
          ),
          useDraggable: false,
          builder: (context, scrollController) => SingleChildScrollView(
            controller: scrollController,
            padding: AppConstants.pagePadding.copyWith(top: 0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  BizzieTextField(
                    controller: _messageController,
                    hintText: 'Tell us what you think...',
                    maxLines: 5,
                    maxLength: 1000,
                    autofocus: true,
                    textCapitalization: TextCapitalization.sentences,
                    validator: (value) => Validators.validateNotEmpty(
                      value,
                      'Please enter your feedback',
                    ),
                    onChanged: (value) {
                      context.read<FeedbackBloc>().add(
                        FeedbackEvent.messageChanged(value),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  BizziePrimaryButton(
                    title: isCoolingDown ? 'Please wait...' : 'Submit Feedback',
                    isLoading: isLoading,
                    onPressed: isButtonEnabled
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              context.read<FeedbackBloc>().add(
                                FeedbackEvent.submit(_messageController.text),
                              );
                            }
                          }
                        : null,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
