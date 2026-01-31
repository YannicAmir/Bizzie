import 'package:bizzie/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_event.dart';
import 'package:bizzie/features/subscription/presentation/bloc/subscription_state.dart';
import 'package:bizzie/features/user/presentation/bloc/user_bloc.dart';
import 'package:bizzie/features/user/presentation/bloc/user_state_extensions.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_mascot.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_close_button.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_feature_highlights.dart';
import 'package:bizzie/features/subscription/presentation/widgets/subscription_header.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:bizzie/shared/widgets/buttons/bizzie_primary_button.dart';
import 'package:bizzie/shared/widgets/error/bizzie_error.dart';
import 'package:bizzie/shared/widgets/loading/bizzie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  bool _isAnnual = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: BlocListener<SubscriptionBloc, SubscriptionState>(
          listener: (context, state) {
            if (state.failure != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.failure!.message),
                  backgroundColor: theme.colorScheme.error,
                ),
              );
            }
          },
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, userState) {
              return BlocBuilder<SubscriptionBloc, SubscriptionState>(
                builder: (context, subscriptionState) {
                  return subscriptionState.map(
                    initial: (_) => BizzieLoader(
                      message: 'Loading subscription',
                      mascotAssetPath: userState.mascotAsset,
                    ),
                    loading: (_) => BizzieLoader(
                      message: 'Loading subscription',
                      mascotAssetPath: userState.mascotAsset,
                    ),
                    loaded: (s) => _SubscriptionLoadedContent(
                      state: s,
                      userState: userState,
                      isAnnual: _isAnnual,
                      onAnnualToggle: (value) =>
                          setState(() => _isAnnual = value),
                    ),
                    failure: (s) => BizzieError(
                      message: s.failure.message,
                      onRetry: () => context.read<SubscriptionBloc>().add(
                        const SubscriptionEvent.offeringsRequested(),
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

class _SubscriptionLoadedContent extends StatelessWidget {
  final SubscriptionStateLoaded state;
  final UserState userState;
  final bool isAnnual;
  final ValueChanged<bool> onAnnualToggle;

  const _SubscriptionLoadedContent({
    required this.state,
    required this.userState,
    required this.isAnnual,
    required this.onAnnualToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Positioned.fill(
          child: SingleChildScrollView(
            padding: AppConstants.pagePadding.copyWith(bottom: 100),
            child: Column(
              children: [
                const Row(children: [Spacer(), SubscriptionCloseButton()]),
                const SizedBox(height: 8),
                SubscriptionMascot(asset: userState.mascotAsset),
                const SizedBox(height: 16),
                const SubscriptionHeader(),
                const SizedBox(height: 32),
                _SubscriptionPlanButton(
                  title: 'Annual',
                  price: state.annualPackage?.priceString ?? '---',
                  subPrice: state.annualPackage != null
                      ? '(\$${(state.annualPackage!.price / 12).toStringAsFixed(2)} / mo)'
                      : null,
                  trialText: state.annualPackage != null
                      ? '7-Day Free Trial'
                      : null,
                  isSelected: isAnnual,
                  badgeText: 'Save 43%',
                  onTap: () => onAnnualToggle(true),
                ),
                const SizedBox(height: 16),
                _SubscriptionPlanButton(
                  title: 'Monthly',
                  price: state.monthlyPackage?.priceString ?? '---',
                  isSelected: !isAnnual,
                  onTap: () => onAnnualToggle(false),
                ),
                const SizedBox(height: 24),
                const SubscriptionFeatureHighlights(),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IgnorePointer(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        theme.colorScheme.surface.withAlpha(0),
                        theme.colorScheme.surface,
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                color: theme.colorScheme.surface,
                padding: AppConstants.pagePadding.copyWith(top: 0, bottom: 8),
                child: _BottomActionSection(
                  isAnnual: isAnnual,
                  isLoading: state.isPurchasing,
                  onTap: () {
                    final package = isAnnual
                        ? state.annualPackage
                        : state.monthlyPackage;
                    if (package != null) {
                      context.read<SubscriptionBloc>().add(
                        SubscriptionEvent.purchaseRequested(package),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SubscriptionPlanButton extends StatelessWidget {
  final String title;
  final String price;
  final String? subPrice;
  final String? trialText;
  final bool isSelected;
  final String? badgeText;
  final VoidCallback onTap;

  const _SubscriptionPlanButton({
    required this.title,
    required this.price,
    this.subPrice,
    this.trialText,
    required this.isSelected,
    this.badgeText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.colorScheme.secondary
                  : theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.outline,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(price, style: theme.textTheme.displayMedium),
                          if (subPrice != null) ...[
                            const SizedBox(width: 8),
                            Text(
                              subPrice!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ],
                      ),
                      if (trialText != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          trialText!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (isSelected)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: theme.colorScheme.surface,
                      size: 20,
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (badgeText != null)
          Positioned(
            top: -10,
            right: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                badgeText!,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.surface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _BottomActionSection extends StatelessWidget {
  final bool isAnnual;
  final bool isLoading;
  final VoidCallback onTap;

  const _BottomActionSection({
    required this.isAnnual,
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        BizziePrimaryButton(
          title: isAnnual ? 'Start Free Trial' : 'Continue',
          isLoading: isLoading,
          onPressed: onTap,
        ),
        const SizedBox(height: 8),
        Text(
          isAnnual
              ? 'Auto-renews for \$240/year. Cancel anytime.'
              : 'Auto-renews for \$34.95/month. Cancel anytime.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
