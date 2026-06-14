import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';

/// Ilova tilini boshqaradi va tanlovni lokal saqlaydi.
///
/// `null` qiymat — tizim tilidan foydalanish ma'nosini bildiradi.
class LocaleController extends Notifier<Locale?> {
  static const String _key = 'app_locale';

  @override
  Locale? build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final code = prefs.getString(_key);
    if (code == null || code.isEmpty) {
      return null;
    }
    return Locale(code);
  }

  /// Tilni o'rnatadi. `null` — tizim tiliga qaytaradi.
  Future<void> setLocale(Locale? locale) async {
    final prefs = ref.read(sharedPreferencesProvider);
    if (locale == null) {
      await prefs.remove(_key);
    } else {
      await prefs.setString(_key, locale.languageCode);
    }
    state = locale;
  }
}

final localeControllerProvider =
    NotifierProvider<LocaleController, Locale?>(LocaleController.new);
