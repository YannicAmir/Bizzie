import 'package:flutter/material.dart';

class BizzieEntranceScale extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;

  const BizzieEntranceScale({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.curve = Curves.easeOutBack,
  });

  @override
  State<BizzieEntranceScale> createState() => _BizzieEntranceScaleState();
}

class _BizzieEntranceScaleState extends State<BizzieEntranceScale>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _scaleAnimation = CurvedAnimation(parent: _controller, curve: widget.curve);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: _scaleAnimation, child: widget.child);
  }
}
