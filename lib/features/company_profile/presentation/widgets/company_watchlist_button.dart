import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_event.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_state.dart';
import 'package:bizzie/features/watchlist/presentation/extensions/watchlist_state_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyWatchlistButton extends StatelessWidget {
  final String ticker;
  final String? companyName;

  const CompanyWatchlistButton({
    super.key,
    required this.ticker,
    this.companyName,
  });

  @override
  Widget build(BuildContext context) {
    const animationDuration = Duration(milliseconds: 300);
    const animationCurve = Curves.easeInOut;

    return BlocSelector<WatchlistBloc, WatchlistState, bool>(
      selector: (state) => state.isInWatchlist(ticker),
      builder: (context, isInWatchlist) {
        final backgroundColor = isInWatchlist
            ? AppColors.primary
            : AppColors.watchlistActiveBackground;
        final foregroundColor = isInWatchlist
            ? AppColors.white
            : AppColors.primary;

        return Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Center(
            child: GestureDetector(
              onTap: () {
                final bloc = context.read<WatchlistBloc>();
                if (isInWatchlist) {
                  HapticFeedback.lightImpact();
                  bloc.add(WatchlistEvent.removeRequested(ticker));
                } else {
                  HapticFeedback.heavyImpact();
                  HapticFeedback.vibrate();
                  bloc.add(
                    WatchlistEvent.addRequested(
                      ticker: ticker,
                      name: companyName,
                    ),
                  );
                }
              },
              child: AnimatedContainer(
                duration: animationDuration,
                curve: animationCurve,
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: AnimatedCrossFade(
                    duration: animationDuration,
                    firstCurve: animationCurve,
                    secondCurve: animationCurve,
                    sizeCurve: animationCurve,
                    alignment: Alignment.center,
                    crossFadeState: isInWatchlist
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    firstChild: _ButtonContent(
                      icon: Icons.add,
                      label: 'Watch',
                      color: foregroundColor,
                      duration: animationDuration,
                      curve: animationCurve,
                    ),
                    secondChild: _ButtonContent(
                      icon: Icons.check,
                      label: 'In Watchlist',
                      color: foregroundColor,
                      duration: animationDuration,
                      curve: animationCurve,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ButtonContent extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Duration duration;
  final Curve curve;

  const _ButtonContent({
    required this.icon,
    required this.label,
    required this.color,
    required this.duration,
    required this.curve,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(width: 4),
        AnimatedDefaultTextStyle(
          duration: duration,
          curve: curve,
          style: AppTextStyles.bodyLargeBold.copyWith(color: color),
          child: Text(label),
        ),
      ],
    );
  }
}
