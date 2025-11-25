import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Button variants
enum AppButtonVariant {
  primary,
  secondary,
  text,
  outlined,
}

/// Reusable button component with multiple variants
/// Adapts to light/dark theme automatically
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final double? width;
  final double? height;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.width,
    this.height,
  });

  const AppButton.primary({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.width,
    this.height,
  }) : variant = AppButtonVariant.primary;

  const AppButton.secondary({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.width,
    this.height,
  }) : variant = AppButtonVariant.secondary;

  const AppButton.text({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.width,
    this.height,
  }) : variant = AppButtonVariant.text;

  const AppButton.outlined({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.width,
    this.height,
  }) : variant = AppButtonVariant.outlined;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDisabled = onPressed == null && !isLoading;

    Widget button = switch (variant) {
      AppButtonVariant.primary => _buildPrimaryButton(context, brightness, isDisabled),
      AppButtonVariant.secondary => _buildSecondaryButton(context, brightness, isDisabled),
      AppButtonVariant.text => _buildTextButton(context, brightness, isDisabled),
      AppButtonVariant.outlined => _buildOutlinedButton(context, brightness, isDisabled),
    };

    if (isFullWidth) {
      button = SizedBox(width: double.infinity, child: button);
    } else if (width != null) {
      button = SizedBox(width: width, child: button);
    }

    if (height != null) {
      button = SizedBox(height: height, child: button);
    }

    return button;
  }

  Widget _buildPrimaryButton(BuildContext context, Brightness brightness, bool isDisabled) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary(brightness),
        foregroundColor: brightness == Brightness.light
            ? AppColors.lightOnPrimary
            : AppColors.darkOnPrimary,
        disabledBackgroundColor: AppColors.primary(brightness).withOpacity(0.38),
        disabledForegroundColor: brightness == Brightness.light
            ? AppColors.lightOnPrimary.withOpacity(0.38)
            : AppColors.darkOnPrimary.withOpacity(0.38),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      child: _buildButtonContent(context),
    );
  }

  Widget _buildSecondaryButton(BuildContext context, Brightness brightness, bool isDisabled) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary(brightness),
        foregroundColor: brightness == Brightness.light
            ? AppColors.lightOnSecondary
            : AppColors.darkOnSecondary,
        disabledBackgroundColor: AppColors.secondary(brightness).withOpacity(0.38),
        disabledForegroundColor: brightness == Brightness.light
            ? AppColors.lightOnSecondary.withOpacity(0.38)
            : AppColors.darkOnSecondary.withOpacity(0.38),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      child: _buildButtonContent(context),
    );
  }

  Widget _buildTextButton(BuildContext context, Brightness brightness, bool isDisabled) {
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary(brightness),
        disabledForegroundColor: AppColors.primary(brightness).withOpacity(0.38),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: _buildButtonContent(context),
    );
  }

  Widget _buildOutlinedButton(BuildContext context, Brightness brightness, bool isDisabled) {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary(brightness),
        disabledForegroundColor: AppColors.primary(brightness).withOpacity(0.38),
        side: BorderSide(
          color: isDisabled
              ? AppColors.primary(brightness).withOpacity(0.38)
              : AppColors.primary(brightness),
          width: 1.5,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: _buildButtonContent(context),
    );
  }

  Widget _buildButtonContent(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            variant == AppButtonVariant.text || variant == AppButtonVariant.outlined
                ? AppColors.primary(Theme.of(context).brightness)
                : AppColors.lightOnPrimary,
          ),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(text, style: AppTextStyles.button(context)),
        ],
      );
    }

    return Text(text, style: AppTextStyles.button(context));
  }
}
