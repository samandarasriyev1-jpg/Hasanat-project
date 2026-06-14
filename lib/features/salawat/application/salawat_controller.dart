import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/app_providers.dart';
import '../../../core/utils/result.dart';
import '../data/salawat_local_repository.dart';
import '../domain/salawat_repository.dart';
import '../domain/salawat_stats.dart';

/// Salovat repozitoriysi provideri.
final salawatRepositoryProvider = Provider<SalawatRepository>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SalawatLocalRepository(prefs);
});

/// Salovat ekrani holatini boshqaruvchi controller.
///
/// `AsyncNotifier` yuklash/xato holatlarini avtomatik boshqaradi.
class SalawatController extends AsyncNotifier<SalawatStats> {
  SalawatRepository get _repo => ref.read(salawatRepositoryProvider);

  @override
  Future<SalawatStats> build() async {
    final result = await _repo.load();
    return result.when(
      ok: (stats) => stats,
      err: (failure) => throw Exception(failure.message),
    );
  }

  /// Bitta salovat qo'shadi. UI darhol yangilanishi uchun optimistik emas,
  /// lekin tezkor — lokal yozuv millisekundlarda bajariladi.
  Future<void> add({int by = 1}) async {
    final result = await _repo.increment(by: by);
    switch (result) {
      case Ok<SalawatStats>(:final value):
        state = AsyncData<SalawatStats>(value);
      case Err<SalawatStats>(:final failure):
        state = AsyncError<SalawatStats>(failure, StackTrace.current);
    }
  }

  /// Hisoblagichni nolga tushiradi.
  Future<void> reset() async {
    final result = await _repo.reset();
    if (result case Ok<SalawatStats>(:final value)) {
      state = AsyncData<SalawatStats>(value);
    }
  }
}

final salawatControllerProvider =
    AsyncNotifierProvider<SalawatController, SalawatStats>(
  SalawatController.new,
);
