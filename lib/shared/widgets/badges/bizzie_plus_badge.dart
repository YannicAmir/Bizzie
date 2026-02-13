import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BizziePlusBadge extends StatelessWidget {
  const BizziePlusBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final isSubscribed = state.maybeMap(
          loaded: (s) => s.user.isSubscribed,
          orElse: () => false,
        );

        if (!isSubscribed) {
          return const SizedBox.shrink();
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'Bizzie Plus',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.surface,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }
}
