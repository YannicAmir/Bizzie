import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Duration _selectionAnimationDuration = Duration(milliseconds: 250);
const Curve _selectionAnimationCurve = Curves.easeInOut;
const double _pillSpacing = 8;
const double _pillBorderRadius = 100;
const EdgeInsets _pillPadding = EdgeInsets.symmetric(
  horizontal: 16,
  vertical: 8,
);

class WatchlistNewsTickerBar extends StatelessWidget {
  final List<String> tickers;
  final String selectedTicker;
  final ValueChanged<String> onTickerSelected;

  const WatchlistNewsTickerBar({
    super.key,
    required this.tickers,
    required this.selectedTicker,
    required this.onTickerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < tickers.length; i++) ...[
            if (i > 0) const SizedBox(width: _pillSpacing),
            _TickerPill(
              ticker: tickers[i],
              isSelected: tickers[i] == selectedTicker,
              onTap: () => onTickerSelected(tickers[i]),
            ),
          ],
        ],
      ),
    );
  }
}

class _TickerPill extends StatelessWidget {
  final String ticker;
  final bool isSelected;
  final VoidCallback onTap;

  const _TickerPill({
    required this.ticker,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      button: true,
      selected: isSelected,
      child: GestureDetector(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        child: AnimatedContainer(
          duration: _selectionAnimationDuration,
          curve: _selectionAnimationCurve,
          padding: _pillPadding,
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(_pillBorderRadius),
          ),
          child: AnimatedDefaultTextStyle(
            duration: _selectionAnimationDuration,
            curve: _selectionAnimationCurve,
            style: isSelected
                ? AppTextStyles.bodySmallBold.copyWith(
                    color: theme.colorScheme.surface,
                  )
                : AppTextStyles.bodySmallSecondary,
            child: Text(ticker),
          ),
        ),
      ),
    );
  }
}
