import 'package:flutter/material.dart';

class SectionVisibilityAnimator extends StatefulWidget {
  final Widget child;
  final bool isVisible;

  const SectionVisibilityAnimator({
    super.key,
    required this.child,
    required this.isVisible,
  });

  @override
  State<SectionVisibilityAnimator> createState() =>
      _SectionVisibilityAnimatorState();
}

class _SectionVisibilityAnimatorState extends State<SectionVisibilityAnimator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCubic,
    );

    if (widget.isVisible) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(covariant SectionVisibilityAnimator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible != oldWidget.isVisible) {
      if (widget.isVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _animation,
      alignment: const Alignment(-1.0, -1.0),
      child: widget.child,
    );
  }
}
