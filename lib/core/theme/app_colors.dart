import 'package:flutter/material.dart';

/// Hasanat brendi rang palitrasi.
/// Diniy estetika: chuqur zumrad yashil + oltin urg'u.
class AppColors {
  const AppColors._();

  // Asosiy — zumrad yashil
  static const Color emerald = Color(0xFF0E7C66);
  static const Color emeraldDark = Color(0xFF0A5A4A);
  static const Color emeraldLight = Color(0xFF3AA88E);

  // Urg'u — oltin
  static const Color gold = Color(0xFFC9A227);
  static const Color goldLight = Color(0xFFE3C765);

  // Neytral
  static const Color ink = Color(0xFF12211D);
  static const Color slate = Color(0xFF5A6B66);
  static const Color mist = Color(0xFFF3F7F5);
  static const Color surface = Color(0xFFFFFFFF);

  // Dark rejim
  static const Color darkBg = Color(0xFF0B1714);
  static const Color darkSurface = Color(0xFF13231F);

  // Holat ranglari
  static const Color success = Color(0xFF2E9E5B);
  static const Color warning = Color(0xFFE0922F);
  static const Color error = Color(0xFFC0392B);

  // Gradientlar
  static const LinearGradient emeraldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [emerald, emeraldDark],
  );

  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [goldLight, gold],
  );
}
