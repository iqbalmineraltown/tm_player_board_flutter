import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'mars_colors.dart';

/// Application theme with Mars-inspired dark mode design
class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: MarsColors.marsRed,
        secondary: MarsColors.terraformGreen,
        surface: MarsColors.surfaceDark,
        error: MarsColors.error,
        onPrimary: MarsColors.textPrimary,
        onSecondary: MarsColors.textPrimary,
        onSurface: MarsColors.textPrimary,
        onError: MarsColors.textPrimary,
      ),
      scaffoldBackgroundColor: MarsColors.spaceBlack,
      cardTheme: CardThemeData(
        color: MarsColors.cardDark,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: MarsColors.surfaceDark,
        foregroundColor: MarsColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.orbitron(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: MarsColors.textPrimary,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.orbitron(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: MarsColors.textPrimary,
        ),
        displayMedium: GoogleFonts.orbitron(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: MarsColors.textPrimary,
        ),
        displaySmall: GoogleFonts.orbitron(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: MarsColors.textPrimary,
        ),
        headlineMedium: GoogleFonts.orbitron(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: MarsColors.textPrimary,
        ),
        titleLarge: GoogleFonts.spaceMono(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: MarsColors.textPrimary,
        ),
        bodyLarge: GoogleFonts.spaceMono(
          fontSize: 14,
          color: MarsColors.textPrimary,
        ),
        bodyMedium: GoogleFonts.spaceMono(
          fontSize: 12,
          color: MarsColors.textSecondary,
        ),
        labelLarge: GoogleFonts.spaceMono(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: MarsColors.textPrimary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MarsColors.marsRed,
          foregroundColor: MarsColors.textPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: MarsColors.textPrimary,
          side: const BorderSide(color: MarsColors.marsRed),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      iconTheme: const IconThemeData(
        color: MarsColors.textPrimary,
        size: 24,
      ),
      dividerTheme: const DividerThemeData(
        color: MarsColors.elevatedDark,
        thickness: 1,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: MarsColors.elevatedDark,
        contentTextStyle: GoogleFonts.spaceMono(
          color: MarsColors.textPrimary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
