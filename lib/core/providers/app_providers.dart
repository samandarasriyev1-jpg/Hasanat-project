import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// `SharedPreferences` uchun global provider.
///
/// `main()` da haqiqiy instans bilan override qilinadi (`overrideWithValue`).
/// Shu sababli bu yerda istisno otadi — agar override qilinmasa, bu dasturchi
/// xatosi bo'ladi va darhol ko'rinadi.
final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError(
    'sharedPreferencesProvider main() da override qilinishi shart.',
  ),
);
