import 'dart:async';

import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_event.dart';
import 'package:bizzie/features/watchlist/presentation/bloc/watchlist_state.dart';
import 'package:bizzie/features/watchlist/presentation/extensions/watchlist_state_extensions.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _inWatchlistLabel = 'In Watchlist';
const _watchLabel = 'Watch';
const _animationDuration = Duration(milliseconds: 300);
const _animationCurve = Curves.easeInOut;

class CompanyWatchlistButton extends StatelessWidget {
  final String ticker;
  final String? companyName;
  final ValueGetter<String> currentTabName;
  final DateTime entranceTime;

  const CompanyWatchlistButton({
    super.key,
    required this.ticker,
    this.companyName,
    required this.currentTabName,
    required this.entranceTime,
  });

  void _handleTap(BuildContext context, {required bool isInWatchlist}) {
    final bloc = context.read<WatchlistBloc>();
    final tabName = currentTabName();
    final durationOnPageSeconds = DateTime.now()
        .difference(entranceTime)
        .inSeconds;

    if (isInWatchlist) {
      unawaited(HapticFeedback.lightImpact());
      bloc.add(
        WatchlistEvent.removeRequested(
          ticker: ticker,
          tabName: tabName,
          durationOnPageSeconds: durationOnPageSeconds,
        ),
      );
    } else {
      unawaited(HapticFeedback.heavyImpact());
      unawaited(HapticFeedback.vibrate());
      bloc.add(
        WatchlistEvent.addRequested(
          ticker: ticker,
          name: companyName,
          tabName: tabName,
          durationOnPageSeconds: durationOnPageSeconds,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
          onTap: () => _handleTap(context, isInWatchlist: isInWatchlist),
          child: AnimatedContainer(
            duration: _animationDuration,
            curve: _animationCurve,
            height: AppConstants.smallButtonHeight,
            padding: AppConstants.companyProfileButtonPadding,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(
                AppConstants.companyProfileButtonBorderRadius,
              ),
            ),
            child: _AnimatedButtonSwitcher(
              isInWatchlist: isInWatchlist,
              foregroundColor: foregroundColor,
            ),
          ),
        );
      },
    );
  }
}

class _AnimatedButtonSwitcher extends StatelessWidget {
  final bool isInWatchlist;
  final Color foregroundColor;

  const _AnimatedButtonSwitcher({
    required this.isInWatchlist,
    required this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSize(
        duration: _animationDuration,
        curve: _animationCurve,
        child: AnimatedSwitcher(
          duration: _animationDuration,
          switchInCurve: _animationCurve,
          switchOutCurve: _animationCurve,
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
                  label: _inWatchlistLabel,
                  color: foregroundColor,
                )
              : _ButtonContent(
                  key: const ValueKey('watch'),
                  icon: Icons.add,
                  label: _watchLabel,
                  color: foregroundColor,
                ),
        ),
      ),
    );
  }
}

class _ButtonContent extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _ButtonContent({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: AppConstants.companyProfileButtonIconSize,
          color: color,
        ),
        const SizedBox(width: AppConstants.companyProfileButtonIconSpacing),
        AnimatedDefaultTextStyle(
          duration: _animationDuration,
          curve: _animationCurve,
          style: AppTextStyles.bodyLargeBold.copyWith(color: color),
          child: Text(label),
        ),
      ],
    );
  }
}
