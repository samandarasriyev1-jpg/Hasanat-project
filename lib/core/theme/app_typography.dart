import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Tipografika: sarlavhalar uchun elegant, matn uchun o'qimishli shrift.
class AppTypography {
  const AppTypography._();

  static TextTheme textTheme(Color onSurface) {
    final TextTheme display = GoogleFonts.amiriTextTheme();
    final TextTheme body = GoogleFonts.interTextTheme();

    return TextTheme(
      displayLarge: display.displayLarge?.copyWith(
        color: onSurface,
        fontWeight: FontWeight.w700,
      ),
      headlineMedium: display.headlineMedium?.copyWith(
        color: onSurface,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: body.titleLarge?.copyWith(
        color: onSurface,
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: body.bodyLarge?.copyWith(color: onSurface),
      bodyMedium: body.bodyMedium?.copyWith(color: onSurface),
      labelLarge: body.labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    );
  }
}
