import '../../../core/utils/result.dart';
import 'salawat_stats.dart';

/// Salovat ma'lumotlari uchun manba abstraksiyasi.
///
/// Hozircha lokal implementatsiya bor; kelajakda Supabase orqali
/// serverga sinxronlash uchun shu interfeysni qayta ishlatish mumkin.
abstract interface class SalawatRepository {
  /// Saqlangan statistikani o'qiydi.
  Future<Result<SalawatStats>> load();

  /// Salovatni [by] taga oshiradi va yangilangan statistikani qaytaradi.
  Future<Result<SalawatStats>> increment({int by});

  /// Hisoblagichni nolga tushiradi.
  Future<Result<SalawatStats>> reset();
}
