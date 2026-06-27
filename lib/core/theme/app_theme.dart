import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppColors {
  static const navyBlue  = Color(0xFF0D1B3E);
  static const navyLight = Color(0xFF1A2F5A);
  static const gold      = Color(0xFFF5C842);
  static const goldLight = Color(0xFFFADF7F);
  static const white     = Color(0xFFFFFFFF);
  static const offWhite  = Color(0xFFF8F7F4);
  static const grey100   = Color(0xFFF1F1F1);
  static const grey300   = Color(0xFFCCCCCC);
  static const grey600   = Color(0xFF757575);
  static const grey900   = Color(0xFF1A1A1A);
  static const error     = Color(0xFFE53935);
}

abstract class AppTheme {
  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark  => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary:    AppColors.navyBlue,
      onPrimary:  AppColors.white,
      secondary:  AppColors.gold,
      onSecondary: AppColors.navyBlue,
      surface:    isDark ? AppColors.navyLight : AppColors.white,
      onSurface:  isDark ? AppColors.white     : AppColors.grey900,
      error:      AppColors.error,
      onError:    AppColors.white,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme:  colorScheme,
      textTheme:    GoogleFonts.nunitoTextTheme(),
      scaffoldBackgroundColor: isDark ? AppColors.navyBlue : AppColors.offWhite,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.navyBlue,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.gold,
          foregroundColor: AppColors.navyBlue,
          minimumSize: const Size(double.infinity, 52),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: isDark ? AppColors.navyLight : AppColors.white,
      ),
    );
  }
}
