import 'dart:math';
import 'package:flutter/material.dart';

class BizzieConfettiParticle {
  late double x;
  late double y;
  late double vx;
  late double vy;
  late double size;
  late double rotation;
  late double rotationSpeed;
  final Color color;

  BizzieConfettiParticle({required this.color, required Random random}) {
    x = random.nextDouble() * 400;
    y = -20 - random.nextDouble() * 100;
    vx = (random.nextDouble() - 0.5) * 4;
    vy = random.nextDouble() * 5 + 2;
    size = random.nextDouble() * 8 + 4;
    rotation = random.nextDouble() * 2 * pi;
    rotationSpeed = (random.nextDouble() - 0.5) * 0.2;
  }

  void update() {
    x += vx;
    y += vy;
    rotation += rotationSpeed;
  }
}

class BizzieConfettiPainter extends CustomPainter {
  final List<BizzieConfettiParticle> particles;

  BizzieConfettiPainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (var p in particles) {
      paint.color = p.color;
      final rect = Rect.fromCenter(
        center: Offset(p.x % size.width, p.y),
        width: p.size,
        height: p.size * 0.6,
      );
      canvas.save();
      canvas.translate(rect.center.dx, rect.center.dy);
      canvas.rotate(p.rotation);
      canvas.drawRect(
        Rect.fromLTWH(-p.size / 2, -p.size * 0.3, p.size, p.size * 0.6),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
