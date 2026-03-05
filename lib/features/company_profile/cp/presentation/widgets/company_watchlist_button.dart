import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_event.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_state.dart';
import 'package:bizzie/features/watchlist/presentation/extensions/watchlist_state_extensions.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanyWatchlistButton extends StatelessWidget {
  final String ticker;
  final String? companyName;
  final String tabName;
  final DateTime entranceTime;

  const CompanyWatchlistButton({
    super.key,
    required this.ticker,
    this.companyName,
    required this.tabName,
    required this.entranceTime,
  });

  @override
  Widget build(BuildContext context) {
    const animationDuration = Duration(milliseconds: 300);
    const animationCurve = Curves.easeInOut;

    return BlocSelector<WatchlistBloc, WatchlistState, bool>(
      selector: (state) => state.isInWatchlist(ticker),
      builder: (context, isInWatchlist) {
        final theme = Theme.of(context);
        final backgroundColor = isInWatchlist
            ? theme.colorScheme.primary
            : theme.colorScheme.secondary;
        final foregroundColor = isInWatchlist
            ? theme.colorScheme.surface
            : theme.colorScheme.primary;

        return GestureDetector(
          onTap: () {
            final bloc = context.read<WatchlistBloc>();
            final durationOnPageSeconds = DateTime.now()
                .difference(entranceTime)
                .inSeconds;

            if (isInWatchlist) {
              HapticFeedback.lightImpact();
              bloc.add(
                WatchlistEvent.removeRequested(
                  ticker: ticker,
                  tabName: tabName,
                  durationOnPageSeconds: durationOnPageSeconds,
                ),
              );
            } else {
              HapticFeedback.heavyImpact();
              HapticFeedback.vibrate();
              bloc.add(
                WatchlistEvent.addRequested(
                  ticker: ticker,
                  name: companyName,
                  tabName: tabName,
                  durationOnPageSeconds: durationOnPageSeconds,
                ),
              );
            }
          },
          child: AnimatedContainer(
            duration: animationDuration,
            curve: animationCurve,
            height: AppConstants.smallButtonHeight,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(
                AppConstants.componyProfileButtonBorderRadius,
              ),
            ),
            child: Center(
              child: AnimatedSize(
                duration: animationDuration,
                curve: animationCurve,
                child: AnimatedSwitcher(
                  duration: animationDuration,
                  switchInCurve: animationCurve,
                  switchOutCurve: animationCurve,
                  layoutBuilder: (currentChild, previousChildren) {
                    return Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        ...previousChildren,
                        if (currentChild != null) currentChild,
                      ],
                    );
                  },
                  child: isInWatchlist
                      ? _ButtonContent(
                          key: const ValueKey('in_watchlist'),
                          icon: Icons.check,
                          label: 'In Watchlist',
                          color: foregroundColor,
                          duration: animationDuration,
                          curve: animationCurve,
                        )
                      : _ButtonContent(
                          key: const ValueKey('watch'),
                          icon: Icons.add,
                          label: 'Watch',
                          color: foregroundColor,
                          duration: animationDuration,
                          curve: animationCurve,
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
    super.key,
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
