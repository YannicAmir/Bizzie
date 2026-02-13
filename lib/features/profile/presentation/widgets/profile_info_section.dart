import 'package:bizzie/app/l10n/bizzie_localizations.dart';
import 'package:bizzie/features/profile/presentation/l10n/profile_localizations.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileInfoSection extends StatelessWidget {
  final String displayName;
  final DateTime joinedDate;

  const ProfileInfoSection({
    super.key,
    required this.displayName,
    required this.joinedDate,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = BizzieLocalizations.of(context);
    final formattedDate = DateFormat.yMMMM('en_US').format(joinedDate);

    return Column(
      children: [
        Text(
          displayName,
          style: AppTextStyles.h1.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          l10n.profileJoined(formattedDate),
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
