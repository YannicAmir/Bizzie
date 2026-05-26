import 'dart:async';
import 'dart:math';

import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:bizzie/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';

const List<String> _kThinkingWords = [
  'Bootstrapping',
  'Stock marketing',
  'Analyzing',
  'Soft-circling',
  'Researching',
  'Scuttlebutting',
  'Hedging',
  'Thinking',
  'Pivoting',
  'Printing',
  'Factoring',
  'Consolidating',
  'Compounding',
  'Vesting',
  'Financing',
  'Synthesizing',
  'Fetching',
  'Diverging',
  'Oscillating',
  'Capitalizing',
  'Procuring',
];

const int _kRevealMs = 45;
const int _kPauseMs = 1200;
const double _kIndicatorPaddingV = 6.0;

class BizzieThinkingIndicator extends StatefulWidget {
  final String mascotAsset;

  const BizzieThinkingIndicator({super.key, required this.mascotAsset});

  @override
  State<BizzieThinkingIndicator> createState() =>
      _BizzieThinkingIndicatorState();
}

class _BizzieThinkingIndicatorState extends State<BizzieThinkingIndicator> {
  final _random = Random();
  late int _wordIndex;
  int _visibleCount = 0;
  bool _revealing = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _wordIndex = _random.nextInt(_kThinkingWords.length);
    _schedule();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _word => _kThinkingWords[_wordIndex];

  void _schedule() {
    if (!mounted) return;

    if (_revealing) {
      if (_visibleCount < _word.length) {
        _timer = Timer(const Duration(milliseconds: _kRevealMs), () {
          if (!mounted) return;
          setState(() => _visibleCount++);
          _schedule();
        });
      } else {
        _timer = Timer(const Duration(milliseconds: _kPauseMs), () {
          if (!mounted) return;
          _revealing = false;
          _schedule();
        });
      }
    } else {
      if (_visibleCount > 0) {
        _timer = Timer(const Duration(milliseconds: _kRevealMs), () {
          if (!mounted) return;
          setState(() => _visibleCount--);
          _schedule();
        });
      } else {
        int next;
        do {
          next = _random.nextInt(_kThinkingWords.length);
        } while (next == _wordIndex && _kThinkingWords.length > 1);
        _wordIndex = next;
        _revealing = true;
        _schedule();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final visible = _word.substring(0, _visibleCount);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: _kIndicatorPaddingV),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            widget.mascotAsset,
            width: AppConstants.chatMascotThinkingSize,
            height: AppConstants.chatMascotThinkingSize,
          ),
          const SizedBox(width: AppConstants.chatThinkingRowSpacing),
          Text(visible, style: AppTextStyles.bodyMediumSecondary),
        ],
      ),
    );
  }
}
