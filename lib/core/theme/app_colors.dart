import 'package:flutter/material.dart';

/// Application color palette following Material 3 guidelines
/// Supports both light and dark themes
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Light Theme Colors
  static const Color lightPrimary = Color(0xFF1976D2);
  static const Color lightSecondary = Color(0xFF0288D1);
  static const Color lightBackground = Color(0xFFFFFBFE);
  static const Color lightSurface = Color(0xFFFFFBFE);
  static const Color lightError = Color(0xFFB3261E);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightOnSecondary = Color(0xFFFFFFFF);
  static const Color lightOnBackground = Color(0xFF1C1B1F);
  static const Color lightOnSurface = Color(0xFF1C1B1F);
  static const Color lightOnError = Color(0xFFFFFFFF);
  static const Color lightOutline = Color(0xFF79747E);
  static const Color lightSurfaceVariant = Color(0xFFE7E0EC);
  
  // Text Colors - Light Theme
  static const Color lightTextPrimary = Color(0xFF1C1B1F);
  static const Color lightTextSecondary = Color(0xFF49454F);
  static const Color lightTextTertiary = Color(0xFF79747E);

  // Dark Theme Colors
  static const Color darkPrimary = Color(0xFF64B5F6);
  static const Color darkSecondary = Color(0xFF4FC3F7);
  static const Color darkBackground = Color(0xFF1C1B1F);
  static const Color darkSurface = Color(0xFF1C1B1F);
  static const Color darkError = Color(0xFFF2B8B5);
  static const Color darkOnPrimary = Color(0xFF0D47A1);
  static const Color darkOnSecondary = Color(0xFF332D41);
  static const Color darkOnBackground = Color(0xFFE6E1E5);
  static const Color darkOnSurface = Color(0xFFE6E1E5);
  static const Color darkOnError = Color(0xFF601410);
  static const Color darkOutline = Color(0xFF938F99);
  static const Color darkSurfaceVariant = Color(0xFF49454F);
  
  // Text Colors - Dark Theme
  static const Color darkTextPrimary = Color(0xFFE6E1E5);
  static const Color darkTextSecondary = Color(0xFFCAC4D0);
  static const Color darkTextTertiary = Color(0xFF938F99);

  // Semantic Colors (independent of theme)
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFA726);
  static const Color info = Color(0xFF29B6F6);
  static const Color error = Color(0xFFD32F2F);
  
  // Utility Colors
  static const Color divider = Color(0xFFE0E0E0);
  static const Color shadow = Color(0x1F000000);
  static const Color transparent = Color(0x00000000);

  /// Get text primary color based on brightness
  static Color textPrimary(Brightness brightness) =>
      brightness == Brightness.light ? lightTextPrimary : darkTextPrimary;

  /// Get text secondary color based on brightness
  static Color textSecondary(Brightness brightness) =>
      brightness == Brightness.light ? lightTextSecondary : darkTextSecondary;

  /// Get text tertiary color based on brightness
  static Color textTertiary(Brightness brightness) =>
      brightness == Brightness.light ? lightTextTertiary : darkTextTertiary;

  /// Get background color based on brightness
  static Color background(Brightness brightness) =>
      brightness == Brightness.light ? lightBackground : darkBackground;

  /// Get surface color based on brightness
  static Color surface(Brightness brightness) =>
      brightness == Brightness.light ? lightSurface : darkSurface;

  /// Get primary color based on brightness
  static Color primary(Brightness brightness) =>
      brightness == Brightness.light ? lightPrimary : darkPrimary;

  /// Get secondary color based on brightness
  static Color secondary(Brightness brightness) =>
      brightness == Brightness.light ? lightSecondary : darkSecondary;
}
