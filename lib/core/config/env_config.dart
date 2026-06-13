import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Muhit (environment) sozlamalari uchun markaziy nuqta.
/// Maxfiy kalitlar .env faylidan o'qiladi.
class EnvConfig {
  const EnvConfig._();

  static String get supabaseUrl => dotenv.maybeGet('SUPABASE_URL') ?? '';
  static String get supabaseAnonKey => dotenv.maybeGet('SUPABASE_ANON_KEY') ?? '';

  /// Supabase kalitlari to'liq sozlanganmi?
  static bool get hasSupabaseConfig =>
      supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;
}
