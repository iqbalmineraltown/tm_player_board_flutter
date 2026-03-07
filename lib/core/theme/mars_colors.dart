import 'package:flutter/material.dart';

/// Mars-themed color palette for the Terraforming Mars player board
class MarsColors {
  MarsColors._();

  // Primary - Mars Red tones
  static const Color marsRed = Color(0xFFC1440E);
  static const Color marsRust = Color(0xFF8B3A3A);
  static const Color marsOrange = Color(0xFFCD5C5C);
  static const Color marsBrown = Color(0xFF5D3A1A);

  // Backgrounds - Dark Space theme
  static const Color spaceBlack = Color(0xFF0D0D0D);
  static const Color surfaceDark = Color(0xFF1A1A1A);
  static const Color cardDark = Color(0xFF252525);
  static const Color elevatedDark = Color(0xFF2D2D2D);

  // Accent - Terraforming colors
  static const Color terraformGreen = Color(0xFF4CAF50);
  static const Color oceanBlue = Color(0xFF2196F3);
  static const Color atmosphereBlue = Color(0xFF03A9F4);

  // Text colors
  static const Color textPrimary = Color(0xFFF5F5F5);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textMuted = Color(0xFF757575);

  // Semantic colors
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFE53935);
  static const Color info = Color(0xFF2196F3);

  // Button colors
  static const Color buttonPrimary = marsRed;
  static const Color buttonSecondary = elevatedDark;
  static const Color buttonIncrement = Color(0xFF2E7D32);
  static const Color buttonDecrement = Color(0xFFC62828);
}
