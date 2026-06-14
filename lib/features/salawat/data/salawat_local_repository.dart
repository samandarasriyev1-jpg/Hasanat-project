import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/error/failure.dart';
import '../../../core/utils/app_logger.dart';
import '../../../core/utils/result.dart';
import '../domain/salawat_repository.dart';
import '../domain/salawat_stats.dart';

/// Salovat ma'lumotlarini qurilmada (SharedPreferences) saqlovchi repozitoriy.
class SalawatLocalRepository implements SalawatRepository {
  SalawatLocalRepository(this._prefs);

  final SharedPreferences _prefs;
  static const String _key = 'salawat_stats';

  /// 1970-01-01 dan beri o'tgan kunlar soni (UTC bo'yicha).
  int get _todayEpochDay =>
      DateTime.now().toUtc().millisecondsSinceEpoch ~/ Duration.millisecondsPerDay;

  @override
  Future<Result<SalawatStats>> load() async {
    try {
      final raw = _prefs.getString(_key);
      if (raw == null || raw.isEmpty) {
        return const Result.ok(SalawatStats());
      }
      final json = jsonDecode(raw) as Map<String, dynamic>;
      final stats = _normalizeForToday(SalawatStats.fromJson(json));
      return Result.ok(stats);
    } catch (e, st) {
      AppLogger.error('Salovatni o\'qishda xato', error: e, stackTrace: st);
      return const Result.err(CacheFailure());
    }
  }

  @override
  Future<Result<SalawatStats>> increment({int by = 1}) async {
    try {
      final current = _normalizeForToday(await _readRaw());
      final updated = current.copyWith(
        total: current.total + by,
        today: current.today + by,
        lastCountedEpochDay: _todayEpochDay,
      );
      await _write(updated);
      return Result.ok(updated);
    } catch (e, st) {
      AppLogger.error('Salovatni oshirishda xato', error: e, stackTrace: st);
      return const Result.err(CacheFailure());
    }
  }

  @override
  Future<Result<SalawatStats>> reset() async {
    try {
      const reset = SalawatStats();
      await _write(reset);
      return const Result.ok(reset);
    } catch (e, st) {
      AppLogger.error('Salovatni tiklashda xato', error: e, stackTrace: st);
      return const Result.err(CacheFailure());
    }
  }

  Future<SalawatStats> _readRaw() async {
    final raw = _prefs.getString(_key);
    if (raw == null || raw.isEmpty) {
      return const SalawatStats();
    }
    return SalawatStats.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  /// Agar saqlangan kun bugundan farq qilsa, `today` ni nolga tushiradi.
  SalawatStats _normalizeForToday(SalawatStats stats) {
    if (stats.lastCountedEpochDay == _todayEpochDay) {
      return stats;
    }
    return stats.copyWith(today: 0, lastCountedEpochDay: _todayEpochDay);
  }

  Future<void> _write(SalawatStats stats) async {
    await _prefs.setString(_key, jsonEncode(stats.toJson()));
  }
}
