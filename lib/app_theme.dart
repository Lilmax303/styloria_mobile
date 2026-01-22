// lib/app_theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Luxury core
  static const bgDark = Color(0xFF0B0F14);
  static const surfaceDark = Color(0xFF111827);
  static const surfaceDark2 = Color(0xFF0F172A);

  static const bgLight = Color(0xFFF7F7F8);
  static const surfaceLight = Colors.white;

  // “Gold” accent (primary)
  static const gold = Color(0xFFD4AF37);
  static const goldPressed = Color(0xFFB8922E);

  // Text
  static const textDarkPrimary = Color(0xFFF5F7FA);
  static const textDarkSecondary = Color(0xFFA8B0BC);

  static const textLightPrimary = Color(0xFF0B0F14);
  static const textLightSecondary = Color(0xFF4B5563);

  // Borders
  static const borderDark = Color(0x1FFFFFFF); // ~6% white
  static const borderLight = Color(0x14000000); // ~8% black
}

class AppTheme {
  static ThemeData light() {
    final colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.gold,
      onPrimary: AppColors.textLightPrimary,
      secondary: AppColors.gold,
      onSecondary: AppColors.textLightPrimary,
      error: const Color(0xFFB42318),
      onError: Colors.white,
      surface: AppColors.surfaceLight,
      onSurface: AppColors.textLightPrimary,
      surfaceContainerHighest: const Color(0xFFF1F2F4),
      outline: AppColors.borderLight,
    );

    final textTheme = GoogleFonts.manropeTextTheme().copyWith(
      // Suggested “premium” sizing
      titleLarge: GoogleFonts.manrope(fontSize: 22, fontWeight: FontWeight.w700),
      titleMedium: GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.w700),
      bodyLarge: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w500),
      bodyMedium: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w500),
      labelLarge: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w600),
      labelMedium: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w600),
      bodySmall: GoogleFonts.manrope(fontSize: 12.5, fontWeight: FontWeight.w500),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.bgLight,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surfaceLight,
        foregroundColor: AppColors.textLightPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceLight,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFFF1F2F4),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.gold,
          foregroundColor: AppColors.textLightPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ).copyWith(
          overlayColor: WidgetStatePropertyAll(AppColors.goldPressed.withOpacity(0.15)),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceLight,
        selectedItemColor: AppColors.textLightPrimary,
        unselectedItemColor: AppColors.textLightSecondary,
      ),
    );
  }

  static ThemeData dark() {
    final colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.gold,
      onPrimary: AppColors.bgDark,
      secondary: AppColors.gold,
      onSecondary: AppColors.bgDark,
      error: const Color(0xFFFF6B6B),
      onError: Colors.black,
      surface: AppColors.surfaceDark,
      onSurface: AppColors.textDarkPrimary,
      surfaceContainerHighest: AppColors.surfaceDark2,
      outline: AppColors.borderDark,
    );

    final textTheme = GoogleFonts.manropeTextTheme(ThemeData.dark().textTheme).copyWith(
      titleLarge: GoogleFonts.manrope(fontSize: 22, fontWeight: FontWeight.w700),
      titleMedium: GoogleFonts.manrope(fontSize: 18, fontWeight: FontWeight.w700),
      bodyLarge: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w500),
      bodyMedium: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w500),
      labelLarge: GoogleFonts.manrope(fontSize: 16, fontWeight: FontWeight.w600),
      labelMedium: GoogleFonts.manrope(fontSize: 14, fontWeight: FontWeight.w600),
      bodySmall: GoogleFonts.manrope(fontSize: 12.5, fontWeight: FontWeight.w500),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.bgDark,
      textTheme: textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.bgDark,
        foregroundColor: AppColors.textDarkPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceDark,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceDark2,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: AppColors.borderDark),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.gold,
          foregroundColor: AppColors.bgDark,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ).copyWith(
          overlayColor: WidgetStatePropertyAll(AppColors.goldPressed.withOpacity(0.18)),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF070A0F),
        selectedItemColor: AppColors.textDarkPrimary,
        unselectedItemColor: AppColors.textDarkSecondary,
      ),
    );
  }
}