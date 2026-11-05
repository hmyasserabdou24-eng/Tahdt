import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';

/// Reusable primary & secondary button with loading state and icon support.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    if (isOutlined) {
      return SizedBox(
        width: double.infinity,
        height: 52,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: isDark ? AppColors.borderDark : AppColors.secondaryBlue,
              width: 1.4,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
          ),
          child: _buildChild(
            textColor: isDark ? AppColors.textPrimaryDark : AppColors.primaryNavy,
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: isDark ? AppColors.accentGold : AppColors.primaryNavy,
          foregroundColor: isDark ? AppColors.primaryNavy : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
        ),
        child: _buildChild(
          textColor: isDark ? AppColors.primaryNavy : Colors.white,
        ),
      ),
    );
  }

  Widget _buildChild({required Color textColor}) {
    if (isLoading) {
      return SizedBox(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(
          strokeWidth: 2.4,
          color: textColor,
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 20, color: textColor),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: textColor,
            ),
          ),
        ],
      );
    }

    return Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 15,
        color: textColor,
      ),
    );
  }
}
