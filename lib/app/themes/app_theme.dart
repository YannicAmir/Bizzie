import 'package:bizzie/app/themes/app_colors.dart';
import 'package:bizzie/app/themes/app_shadows.dart';
import 'package:bizzie/app/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.surface,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        onSurfaceVariant: AppColors.textSecondary,
        secondaryContainer: AppColors.mascotBackground,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme)
          .copyWith(
            displayLarge: AppTextStyles.h1,
            displayMedium: AppTextStyles.h2,
            displaySmall: AppTextStyles.h3,
            headlineMedium: AppTextStyles.h3,
            titleMedium: AppTextStyles.subtitle,
            bodyLarge: AppTextStyles.bodyLarge,
            bodyMedium: AppTextStyles.bodyMedium,
            bodySmall: AppTextStyles.bodySmall,
            labelLarge: AppTextStyles.button,
            labelSmall: AppTextStyles.caption,
          ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary, size: 20),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.inputBorder,
        thickness: 0.67,
        space: 1,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.inputBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.inputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        hintStyle: const TextStyle(color: AppColors.textTertiary),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.slate200,
        linearMinHeight: 4,
      ),
      extensions: [
        MascotThemeExtension(
          gradientColors: const [
            AppColors.mascotCardGradientStart,
            AppColors.mascotCardGradientEnd,
          ],
          borderColor: AppColors.mascotCardBorder,
          cardShadows: AppShadows.mascotCard,
          innerContainerShadows: AppShadows.mascotInner,
          badgeShadows: AppShadows.mascotBadge,
          subtitleColor: AppColors.mascotSubtitle,
          cardShadow: AppShadows.standardCard,
        ),
        SocialLoginThemeExtension(
          appleBackgroundColor: AppColors.appleBlack,
          appleForegroundColor: AppColors.surface,
          googleBackgroundColor: AppColors.googleBackground,
          googleForegroundColor: AppColors.textPrimary,
          googleTextColor: AppColors.googleText,
        ),
      ],
    );
  }
}

@immutable
class MascotThemeExtension extends ThemeExtension<MascotThemeExtension> {
  final List<Color> gradientColors;
  final Color borderColor;
  final List<BoxShadow> cardShadows;
  final List<BoxShadow> innerContainerShadows;
  final List<BoxShadow> badgeShadows;
  final Color subtitleColor;
  final List<BoxShadow> cardShadow;

  const MascotThemeExtension({
    required this.gradientColors,
    required this.borderColor,
    required this.cardShadows,
    required this.innerContainerShadows,
    required this.badgeShadows,
    required this.subtitleColor,
    required this.cardShadow,
  });

  @override
  MascotThemeExtension copyWith({
    List<Color>? gradientColors,
    Color? borderColor,
    List<BoxShadow>? cardShadows,
    List<BoxShadow>? innerContainerShadows,
    List<BoxShadow>? badgeShadows,
    Color? subtitleColor,
    List<BoxShadow>? cardShadow,
  }) {
    return MascotThemeExtension(
      gradientColors: gradientColors ?? this.gradientColors,
      borderColor: borderColor ?? this.borderColor,
      cardShadows: cardShadows ?? this.cardShadows,
      innerContainerShadows:
          innerContainerShadows ?? this.innerContainerShadows,
      badgeShadows: badgeShadows ?? this.badgeShadows,
      subtitleColor: subtitleColor ?? this.subtitleColor,
      cardShadow: cardShadow ?? this.cardShadow,
    );
  }

  @override
  MascotThemeExtension lerp(
    ThemeExtension<MascotThemeExtension>? other,
    double t,
  ) {
    if (other is! MascotThemeExtension) {
      return this;
    }
    return MascotThemeExtension(
      gradientColors: t < 0.5 ? gradientColors : other.gradientColors,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      cardShadows: BoxShadow.lerpList(cardShadows, other.cardShadows, t)!,
      innerContainerShadows: BoxShadow.lerpList(
        innerContainerShadows,
        other.innerContainerShadows,
        t,
      )!,
      badgeShadows: BoxShadow.lerpList(badgeShadows, other.badgeShadows, t)!,
      subtitleColor: Color.lerp(subtitleColor, other.subtitleColor, t)!,
      cardShadow: BoxShadow.lerpList(cardShadow, other.cardShadow, t)!,
    );
  }
}

@immutable
class SocialLoginThemeExtension
    extends ThemeExtension<SocialLoginThemeExtension> {
  final Color appleBackgroundColor;
  final Color appleForegroundColor;
  final Color googleBackgroundColor;
  final Color googleForegroundColor;
  final Color googleTextColor;

  const SocialLoginThemeExtension({
    required this.appleBackgroundColor,
    required this.appleForegroundColor,
    required this.googleBackgroundColor,
    required this.googleForegroundColor,
    required this.googleTextColor,
  });

  @override
  SocialLoginThemeExtension copyWith({
    Color? appleBackgroundColor,
    Color? appleForegroundColor,
    Color? googleBackgroundColor,
    Color? googleForegroundColor,
    Color? googleTextColor,
  }) {
    return SocialLoginThemeExtension(
      appleBackgroundColor: appleBackgroundColor ?? this.appleBackgroundColor,
      appleForegroundColor: appleForegroundColor ?? this.appleForegroundColor,
      googleBackgroundColor:
          googleBackgroundColor ?? this.googleBackgroundColor,
      googleForegroundColor:
          googleForegroundColor ?? this.googleForegroundColor,
      googleTextColor: googleTextColor ?? this.googleTextColor,
    );
  }

  @override
  SocialLoginThemeExtension lerp(
    ThemeExtension<SocialLoginThemeExtension>? other,
    double t,
  ) {
    if (other is! SocialLoginThemeExtension) {
      return this;
    }
    return SocialLoginThemeExtension(
      appleBackgroundColor: Color.lerp(
        appleBackgroundColor,
        other.appleBackgroundColor,
        t,
      )!,
      appleForegroundColor: Color.lerp(
        appleForegroundColor,
        other.appleForegroundColor,
        t,
      )!,
      googleBackgroundColor: Color.lerp(
        googleBackgroundColor,
        other.googleBackgroundColor,
        t,
      )!,
      googleForegroundColor: Color.lerp(
        googleForegroundColor,
        other.googleForegroundColor,
        t,
      )!,
      googleTextColor: Color.lerp(googleTextColor, other.googleTextColor, t)!,
    );
  }
}
