import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

const _skipTourLabel = 'Skip tour';

class CompanyProfileTourSkipButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CompanyProfileTourSkipButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.textPrimary,
        foregroundColor: Theme.of(context).colorScheme.surface,
        textStyle: AppTextStyles.bodyMediumBold,
        minimumSize: const Size.square(kMinInteractiveDimension),
        shape: const StadiumBorder(),
      ),
      child: const Text(_skipTourLabel),
    );
  }
}
