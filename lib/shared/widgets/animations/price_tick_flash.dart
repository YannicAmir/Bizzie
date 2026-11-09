import 'package:bizzie/app/themes/app_theme.dart';
import 'package:bizzie/core/utils/string_extensions.dart';
import 'package:bizzie/shared/models/price_tick.dart';
import 'package:bizzie/shared/utils/badge_theme_extensions.dart';
import 'package:flutter/material.dart';

const Duration _flashDuration = Duration(milliseconds: 1200);
const double _flashHoldWeight = 25;
const double _flashFadeWeight = 75;

class PriceTickFlash extends StatefulWidget {
  final double? price;
  final String text;
  final Widget Function(BuildContext context, PriceTick tick) builder;

  const PriceTickFlash({
    super.key,
    required this.price,
    required this.text,
    required this.builder,
  });

  @override
  State<PriceTickFlash> createState() => _PriceTickFlashState();
}

class _PriceTickFlashState extends State<PriceTickFlash>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: _flashDuration,
    value: 1,
  );
  late final Animation<double> _intensity = TweenSequence<double>([
    TweenSequenceItem(tween: ConstantTween(1), weight: _flashHoldWeight),
    TweenSequenceItem(
      tween: Tween<double>(
        begin: 1,
        end: 0,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: _flashFadeWeight,
    ),
  ]).animate(_controller);

  late String _unchangedText = widget.text;
  Color? _flashColor;

  @override
  void didUpdateWidget(covariant PriceTickFlash oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text == widget.text) return;

    _unchangedText = widget.text.commonPrefixWith(oldWidget.text);
    final flashColor = _flashColorFor(oldWidget.price, widget.price);
    if (flashColor == null || MediaQuery.disableAnimationsOf(context)) {
      _flashColor = null;
      _controller.value = 1;
      return;
    }
    _flashColor = flashColor;
    _controller.forward(from: 0);
  }

  Color? _flashColorFor(double? previous, double? current) {
    if (previous == null || current == null || previous == current) {
      return null;
    }
    final badgeTheme = Theme.of(context).extension<BadgeThemeExtension>();
    return current > previous
        ? badgeTheme.goodTextOrDefault
        : badgeTheme.criticalTextOrDefault;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _intensity,
      builder: (context, _) => widget.builder(
        context,
        PriceTick(
          unchangedText: _unchangedText,
          changedText: widget.text.substring(_unchangedText.length),
          flashColor: _flashColor,
          intensity: _intensity.value,
        ),
      ),
    );
  }
}

class PriceTickText extends StatelessWidget {
  final PriceTick tick;
  final TextStyle style;

  const PriceTickText({super.key, required this.tick, required this.style});

  @override
  Widget build(BuildContext context) {
    final changedColor = tick.isFlashing
        ? Color.lerp(style.color, tick.flashColor, tick.intensity)
        : style.color;

    return Text.rich(
      TextSpan(
        text: tick.unchangedText,
        children: [
          TextSpan(
            text: tick.changedText,
            style: style.copyWith(color: changedColor),
          ),
        ],
      ),
      style: style,
    );
  }
}
