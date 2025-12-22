import 'package:flutter/material.dart';

class AppColors {
  // Primary
  static const Color primary = Color(0xFF155DFC); // Exact Figma Blue

  // Text
  static const Color textPrimary = Color(0xFF0F172B); // Dark Blue/Black
  static const Color textSecondary = Color(0xFF45556C); // Subtitle Blue/Grey
  static const Color textTertiary = Color(
    0xFF62748E,
  ); // Divider/Caption Blue/Grey

  // Backgrounds & Surfaces
  static const Color surface = Colors.white;
  static const Color background = Colors.white;
  static const Color inputBackground = Color(0xFFF8FAFC); // Light Grey

  // Borders
  static const Color inputBorder = Color(0xFFE2E8F0); // Border Grey

  // Social
  static const Color appleBlack = Colors.black;
  static const Color googleBackground = Color(0xFFF1F5F9);
  static const Color googleText = Color(0xFF0F172B);

  // General
  static const Color black = Colors.black;
  static const Color white = Colors.white;

  // Feature Specific
  static const Color mascotBackground = Color(0xFFEFF6FF); // Light Blue-50
  static const Color mascotSubtitle = Color(0xFF1447E6); // Deep Blue

  static const Color mascotCardGradientStart = Color(0xFFEFF6FF);
  static const Color mascotCardGradientEnd = Color(0xFFEEF2FF);
  // rgba(219,234,254,0.5) -> 0x  80  DB EAF E
  static const Color mascotCardBorder = Color(0x80DBEAFE);
}
