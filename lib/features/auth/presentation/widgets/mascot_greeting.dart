import 'package:flutter/material.dart';

const _revealDuration = Duration(milliseconds: 400);

class MascotGreeting extends StatefulWidget {
  final String name;

  const MascotGreeting({super.key, required this.name});

  @override
  State<MascotGreeting> createState() => _MascotGreetingState();
}

class _MascotGreetingState extends State<MascotGreeting>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: _revealDuration,
    value: widget.name.isEmpty ? 0 : 1,
  );
  late final Animation<double> _reveal = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutCubic,
  );
  late String _displayedName = widget.name;

  @override
  void didUpdateWidget(covariant MascotGreeting oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.name == oldWidget.name) return;
    if (widget.name.isEmpty) {
      _controller.reverse();
      return;
    }
    _displayedName = widget.name;
    _controller.forward(from: oldWidget.name.isEmpty ? _controller.value : 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final nameStyle = TextStyle(color: Theme.of(context).colorScheme.primary);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text('Hi'),
        Flexible(
          child: SizeTransition(
            sizeFactor: _reveal,
            axis: Axis.horizontal,
            alignment: Alignment.centerLeft,
            child: Text.rich(
              TextSpan(
                children: [
                  const TextSpan(text: ', '),
                  TextSpan(text: _displayedName, style: nameStyle),
                ],
              ),
            ),
          ),
        ),
        const Text('!'),
      ],
    );
  }
}
