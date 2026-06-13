import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/env_config.dart';

/// Supabase bilan ishlash uchun markaziy servis.
///
/// Kalitlar mavjud bo'lmasa, ilova baribir ishga tushadi (offline rejim),
/// shunda dasturchi UIni kalitlarsiz ham ko'ra oladi.
class SupabaseService {
  const SupabaseService._();

  static bool _initialized = false;
  static bool get isInitialized => _initialized;

  /// Supabase'ni ishga tushiradi. Kalitlar yo'q bo'lsa, jim o'tkazib yuboradi.
  static Future<void> init() async {
    if (!EnvConfig.hasSupabaseConfig) {
      return;
    }
    await Supabase.initialize(
      url: EnvConfig.supabaseUrl,
      anonKey: EnvConfig.supabaseAnonKey,
    );
    _initialized = true;
  }

  /// Supabase mijozi (faqat ishga tushirilgan bo'lsa).
  static SupabaseClient get client => Supabase.instance.client;
}
