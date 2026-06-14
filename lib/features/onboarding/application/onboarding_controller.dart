import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';

/// Foydalanuvchi onboarding (welcome) ekranini ko'rib bo'lganini saqlaydi.
///
/// Shu holatga qarab router foydalanuvchini to'g'ridan-to'g'ri `/home` ga
/// yoki `/welcome` ga yo'naltiradi.
class OnboardingController extends Notifier<bool> {
  static const String _key = 'onboarding_seen';

  @override
  bool build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getBool(_key) ?? false;
  }

  /// Onboarding tugaganini belgilaydi va saqlaydi.
  Future<void> complete() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_key, true);
    state = true;
  }

  /// (Asosan test/debug uchun) holatni tiklaydi.
  Future<void> reset() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.remove(_key);
    state = false;
  }
}

final onboardingControllerProvider =
    NotifierProvider<OnboardingController, bool>(OnboardingController.new);
