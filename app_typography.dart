import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Builds accessible, high-readability typography supporting Latin (EN/FR)
/// and Arabic (AR) scripts cleanly.
class AppTypography {
  const AppTypography._();

  static TextTheme buildTextTheme(Color primaryTextColor, Color secondaryTextColor, {required bool isArabic}) {
    final TextTheme base = isArabic
        ? GoogleFonts.cairoTextTheme()
        : GoogleFonts.plusJakartaSansTextTheme();

    return base.copyWith(
      displaySmall: base.displaySmall?.copyWith(
        fontSize: 30,
        fontWeight: FontWeight.w800,
        color: primaryTextColor,
        height: 1.25,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: primaryTextColor,
        height: 1.3,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: primaryTextColor,
        height: 1.35,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        height: 1.4,
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: primaryTextColor,
        height: 1.5,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: secondaryTextColor,
        height: 1.5,
      ),
      labelLarge: base.labelLarge?.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        letterSpacing: 0.2,
      ),
    );
  }
}
