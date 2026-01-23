import 'package:flutter/material.dart';

class AppColors {
  // Primary
  static const Color primary = Color(0xFF155DFC); // Exact Figma Blue
  static const Color blueGradientStart = Color(0xFF2B7FFF);

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
  static const Color transparent = Colors.transparent;

  // Feature Specific
  static const Color mascotBackground = Color(0xFFEFF6FF); // Light Blue-50
  static const Color mascotSubtitle = Color(0xFF1447E6); // Deep Blue

  static const Color mascotCardGradientStart = Color(0xFFEFF6FF);
  static const Color mascotCardGradientEnd = Color(0xFFEEF2FF);
  // rgba(219,234,254,0.5) -> 0x  80  DB EAF E
  static const Color mascotCardBorder = Color(0x80DBEAFE);
  static const Color brandChipSelectedBackground = Color(0xFFDBEAFE);
  static const Color brandChipSectorBorder = Color(0xFFE2E8F0);

  // Watchlist Active
  static const Color watchlistActiveBackground = Color(0xFFEFF6FF);
  static const Color watchlistActiveBorder = Color(0xFFBEDBFF);

  // Success / State Colors
  static const Color brandChipOtherForeground = Color(0xFF314158);

  // Palette Additions
  static const Color blue500 = Color(0xFF3B82F6);
  static const Color indigoPrimary = Color(0xFF4F39F6);
  static const Color green100 = Color(0xFFDCFCE7);
  static const Color green800 = Color(0xFF166534);
  static const Color red100 = Color(0xFFFFE2E2);
  static const Color red800 = Color(0xFFB91C1C);
  static const Color orange100 = Color(0xFFFFEDD5);
  static const Color orange700 = Color(0xFFC2410C);
  static const Color green600 = Color(0xFF16A34A);
  static const Color green700 = Color(0xFF15803D);
  static const Color indigo100 = Color(0xFFE0E7FF);
  // static const Color blue100 = Color(0xFFDBEAFE); // Alias for brandChipSelectedBackground
  static const Color graphBlueAccent = Color(0xFF51A2FF);

  // Badge Specific
  static const Color criticalText = Color(0xFFE7000B);
  static const Color goodText = Color(0xFF006644);
  static const Color warningBackground = Color(0xFFFEFCE8);
  static const Color warningText = Color(0xFF9D6600);

  static const Color yellowHighlightBackground = Color(0xFFFEF9C2);
  static const Color yellowHighlightText = Color(0xFF9D6600);

  static const Color voidBackground = Color(0xFFF1F5F9);
  static const Color voidText = Color(0xFF64748B);

  // Slates
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B); // Text Tertiary variant
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);

  // Shadows
  static const Color shadowCard = Color(0x1A000000);
  static const Color shadowLight = Color(0x14000000); // 0.08 opacity approx
  static const Color shadowDark = Color(0x40000000); // 0.25 opacity

  // States
  static const Color successBackground = Color(0xFFECFDF5);
  static const Color successBorder = Color(0xFFA4F4CF);
  static const Color successIconBackground = Color(0xFFD0FAE5);
  static const Color successText = Color(0xFF047857);

  // Semantic
  static const Color success = Color(0xFF16A34A);
  static const Color error = Color(0xFFDC2626);
  static const Color slate600 = Color(0xFF475569);

  static const Color darkCritical = Color.fromARGB(255, 183, 28, 28);

  // Tooltips
  static const Color tooltipBackground = Color(0xFF0F172B);
}
