import 'dart:math';
import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/shared/widgets/animations/bizzie_confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SubscriptionSuccessOverlay extends StatefulWidget {
  final String userName;
  final VoidCallback onDismiss;

  const SubscriptionSuccessOverlay({
    super.key,
    required this.userName,
    required this.onDismiss,
  });

  static void show(
    BuildContext context, {
    required String userName,
    required VoidCallback onDismiss,
  }) {
    final theme = Theme.of(context);

    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: theme.colorScheme.surface,
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return SubscriptionSuccessOverlay(
          userName: userName,
          onDismiss: onDismiss,
        );
      },
    );
  }

  @override
  State<SubscriptionSuccessOverlay> createState() =>
      _SubscriptionSuccessOverlayState();
}

class _SubscriptionSuccessOverlayState extends State<SubscriptionSuccessOverlay>
    with TickerProviderStateMixin {
  late AnimationController _checkController;
  late Animation<double> _checkAnimation;
  late AnimationController _confettiController;
  final List<BizzieConfettiParticle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    HapticFeedback.heavyImpact();

    _checkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _checkAnimation = CurvedAnimation(
      parent: _checkController,
      curve: Curves.elasticOut,
    );

    _confettiController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..addListener(() {
            setState(() {
              for (var particle in _particles) {
                particle.update();
              }
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _dismiss();
            }
          });

    _createParticles();

    _checkController.forward();
    _confettiController.forward();
  }

  void _dismiss() {
    if (mounted) {
      widget.onDismiss();
    }
  }

  void _createParticles() {
    final colors = [AppColors.primary, AppColors.success];
    for (int i = 0; i < 60; i++) {
      _particles.add(
        BizzieConfettiParticle(
          color: colors[_random.nextInt(colors.length)],
          random: _random,
        ),
      );
    }
  }

  @override
  void dispose() {
    _checkController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            painter: BizzieConfettiPainter(particles: _particles),
            size: Size.infinite,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScaleTransition(
                  scale: _checkAnimation,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      color: theme.colorScheme.surface,
                      size: 64,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                FadeTransition(
                  opacity: _checkAnimation,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            style: theme.textTheme.displayLarge,
                            children: [
                              const TextSpan(text: 'Welcome to Bizzie Plus, '),
                              TextSpan(
                                text: widget.userName,
                                style: TextStyle(
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              const TextSpan(text: '!'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          'Enjoy AI report summaries, AI product search, and more',
                          textAlign: TextAlign.left,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
