import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Headings
  static final TextStyle h1 = GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.w800, // ExtraBold
    height: 1.5,
    letterSpacing: 0.406,
    color: AppColors.textPrimary,
  );

  static final TextStyle h2 = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w700, // Bold
    height: 1.5,
    letterSpacing: 0.3,
    color: AppColors.textPrimary,
  );

  static final TextStyle h3 = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w700, // Bold
    height: 1.5,
    letterSpacing: 0.3,
    color: AppColors.textPrimary,
  );

  // Body Texts
  static final TextStyle subtitle = GoogleFonts.inter(
    fontSize: 17,
    fontWeight: FontWeight.normal,
    height: 1.5,
    letterSpacing: -0.4316,
    color: AppColors.textSecondary,
  );

  static final TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 17,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    letterSpacing: -0.4316,
  );

  static final TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    letterSpacing: -0.2, // Small negative spacing often good for small text
  );

  static final TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    letterSpacing: -0.2344,
  );

  static final TextStyle caption = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.normal,
    height: 1.5,
    letterSpacing: -0.2344,
    color: AppColors.textTertiary,
  );

  // Buttons & Interactive
  static final TextStyle button = GoogleFonts.inter(
    fontSize: 17,
    fontWeight: FontWeight.w600, // SemiBold
    letterSpacing: -0.4316,
    height: 1.5,
  );

  static final TextStyle smallLink = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    height: 1.5,
    color: AppColors.textSecondary,
  );

  static final TextStyle smallLinkBold = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    height: 1.5,
    color: AppColors.primary,
    decoration: TextDecoration.underline,
  );

  static final TextStyle forgotPassword = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600, // SemiBold
    height: 1.5,
    letterSpacing: -0.1504,
    color: AppColors.primary,
  );

  // Hints
  static final TextStyle inputHint = GoogleFonts.inter(
    fontSize: 17,
    fontWeight: FontWeight.normal,
    letterSpacing: -0.4316,
    color: AppColors.textSecondary,
    height: 1.0,
  );
}
