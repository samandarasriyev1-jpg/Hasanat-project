import 'package:flutter_test/flutter_test.dart';
import 'package:hasanat/features/salawat/domain/salawat_stats.dart';

void main() {
  group('SalawatStats', () {
    test('points = total * pointsPerSalawat', () {
      const stats = SalawatStats(total: 3);
      expect(stats.points, 3 * SalawatStats.pointsPerSalawat);
    });

    test('copyWith faqat berilgan maydonlarni o\'zgartiradi', () {
      const stats = SalawatStats(total: 1, today: 1, lastCountedEpochDay: 10);
      final updated = stats.copyWith(total: 5);
      expect(updated.total, 5);
      expect(updated.today, 1);
      expect(updated.lastCountedEpochDay, 10);
    });

    test('toJson/fromJson aylanishi qiymatni saqlaydi', () {
      const stats = SalawatStats(total: 7, today: 2, lastCountedEpochDay: 99);
      final restored = SalawatStats.fromJson(stats.toJson());
      expect(restored, stats);
    });

    test('teng obyektlar == va hashCode bo\'yicha teng', () {
      const a = SalawatStats(total: 4, today: 1, lastCountedEpochDay: 5);
      const b = SalawatStats(total: 4, today: 1, lastCountedEpochDay: 5);
      expect(a, b);
      expect(a.hashCode, b.hashCode);
    });
  });
}
