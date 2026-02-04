import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';

class DiscountTitleCard extends StatelessWidget {
  final String percentage;

  const DiscountTitleCard({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final absPercentage = percentage.replaceAll('-', '');

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          '$absPercentage OFF',
          style: AppTextStyles.h1.copyWith(color: theme.colorScheme.surface),
        ),
      ),
    );
  }
}
