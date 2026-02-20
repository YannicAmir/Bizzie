import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bizzie/app/themes/app_assets.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/shared/utils/paywall_helper.dart';
import 'package:bizzie/core/enums/paywall_source.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';

class AiSearchPromptView extends StatelessWidget {
  final String query;
  final VoidCallback onSearchTap;

  const AiSearchPromptView({
    super.key,
    required this.query,
    required this.onSearchTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final isSubscribed = state.maybeMap(
          loaded: (s) => s.user.isSubscribed,
          orElse: () => false,
        );

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 196),
              Text(
                'Searching a brand or product?',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Bizzie\'s AI can check if "$query" is owned by a public company.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              BizziePrimaryButton(
                onPressed: () {
                  if (isSubscribed) {
                    onSearchTap();
                  } else {
                    PaywallHelper.showPaywallSequence(
                      context,
                      source: PaywallSource.search,
                    );
                  }
                },
                title: 'Search for "$query"',
                prefixIcon: !isSubscribed
                    ? SvgPicture.asset(
                        AppAssets.authLockIcon,
                        width: 18,
                        height: 18,
                        colorFilter: ColorFilter.mode(
                          theme.colorScheme.surface,
                          BlendMode.srcIn,
                        ),
                      )
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }
}
