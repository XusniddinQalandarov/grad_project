import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Application text styles following Material 3 typography guidelines
/// All text styles are responsive and adapt to the theme
class AppTextStyles {
  // Private constructor to prevent instantiation
  AppTextStyles._();

  // Display Styles
  static TextStyle displayLarge(BuildContext context) => TextStyle(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        height: 1.12,
        color: AppColors.textPrimary(Theme.of(context).brightness),
      );

  static TextStyle displayMedium(BuildContext context) => TextStyle(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.16,
        color: AppColors.textPrimary(Theme.of(context).brightness),
      );

  static TextStyle displaySmall(BuildContext context) => TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.22,
        color: AppColors.textPrimary(Theme.of(context).brightness),
      );

  // Headline Styles
  static TextStyle headlineLarge(BuildContext context) => TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.25,
        color: AppColors.textPrimary(Theme.of(context).brightness),
      );

  static TextStyle headlineMedium(BuildContext context) => TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.29,
        color: AppColors.textPrimary(Theme.of(context).brightness),
      );

  static TextStyle headlineSmall(BuildContext context) => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.33,
        color: AppColors.textPrimary(Theme.of(context).brightness),
      );

  // Title Styles
  static TextStyle titleLarge(BuildContext context) => TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        height: 1.27,
        color: AppColors.textPrimary(Theme.of(context).brightness),
      );

  static TextStyle titleMedium(BuildContext context) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        height: 1.50,
        color: AppColors.textPrimary(Theme.of(context).brightness),
      );

  static TextStyle titleSmall(BuildContext context) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
        color: AppColors.textPrimary(Theme.of(context).brightness),
      );

  // Label Styles
  static TextStyle labelLarge(BuildContext context) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
        color: AppColors.textPrimary(Theme.of(context).brightness),
      );

  static TextStyle labelMedium(BuildContext context) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.33,
        color: AppColors.textSecondary(Theme.of(context).brightness),
      );

  static TextStyle labelSmall(BuildContext context) => TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.45,
        color: AppColors.textSecondary(Theme.of(context).brightness),
      );

  // Body Styles
  static TextStyle bodyLarge(BuildContext context) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.50,
        color: AppColors.textPrimary(Theme.of(context).brightness),
      );

  static TextStyle bodyMedium(BuildContext context) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.43,
        color: AppColors.textSecondary(Theme.of(context).brightness),
      );

  static TextStyle bodySmall(BuildContext context) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.33,
        color: AppColors.textSecondary(Theme.of(context).brightness),
      );

  // Custom Styles
  static TextStyle button(BuildContext context) => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
        color: AppColors.textPrimary(Theme.of(context).brightness),
      );

  static TextStyle caption(BuildContext context) => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.33,
        color: AppColors.textTertiary(Theme.of(context).brightness),
      );

  static TextStyle overline(BuildContext context) => TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        letterSpacing: 1.5,
        height: 1.6,
        color: AppColors.textTertiary(Theme.of(context).brightness),
      );
}
