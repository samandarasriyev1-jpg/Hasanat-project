import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

/// Markazlashtirilgan logger.
///
/// `avoid_print` lint qoidasiga rioya qilgan holda, `dart:developer`'ning
/// `log` funksiyasidan foydalanadi. Faqat debug rejimida yozadi.
class AppLogger {
  const AppLogger._();

  static void debug(String message, {String name = 'Hasanat'}) {
    if (kDebugMode) {
      developer.log(message, name: name, level: 500);
    }
  }

  static void info(String message, {String name = 'Hasanat'}) {
    if (kDebugMode) {
      developer.log(message, name: name, level: 800);
    }
  }

  static void warning(String message, {String name = 'Hasanat'}) {
    if (kDebugMode) {
      developer.log(message, name: name, level: 900);
    }
  }

  static void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String name = 'Hasanat',
  }) {
    developer.log(
      message,
      name: name,
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
