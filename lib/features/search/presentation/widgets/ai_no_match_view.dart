import 'package:flutter/material.dart';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';

class AiNoMatchView extends StatelessWidget {
  final String productName;
  final VoidCallback onRetry;

  const AiNoMatchView({
    super.key,
    required this.productName,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 196),
          Text(
            "Stocks related to '$productName'",
            style: AppTextStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'There are no companies listed on the stock market that produce this product.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          BizziePrimaryButton(
            onPressed: onRetry,
            title: 'Try a different search',
          ),
        ],
      ),
    );
  }
}
