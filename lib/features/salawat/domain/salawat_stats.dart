/// Salovat statistikasi — o'zgarmas (immutable) qiymat obyekti.
class SalawatStats {
  const SalawatStats({
    this.total = 0,
    this.today = 0,
    this.lastCountedEpochDay = 0,
  });

  /// Umumiy aytilgan salovatlar soni.
  final int total;

  /// Bugun aytilgan salovatlar soni.
  final int today;

  /// `today` qaysi kunga tegishli ekanini bildiruvchi epoch kun raqami
  /// (millisekundlardan emas, kunlardan hisoblanadi). Kun almashganda
  /// `today` avtomatik nolga tushadi.
  final int lastCountedEpochDay;

  /// Har bir salovat 10 ballga teng (sozlanadigan qoida).
  static const int pointsPerSalawat = 10;

  /// Yig'ilgan umumiy ball.
  int get points => total * pointsPerSalawat;

  SalawatStats copyWith({
    int? total,
    int? today,
    int? lastCountedEpochDay,
  }) {
    return SalawatStats(
      total: total ?? this.total,
      today: today ?? this.today,
      lastCountedEpochDay: lastCountedEpochDay ?? this.lastCountedEpochDay,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'total': total,
        'today': today,
        'lastCountedEpochDay': lastCountedEpochDay,
      };

  factory SalawatStats.fromJson(Map<String, dynamic> json) {
    return SalawatStats(
      total: (json['total'] as num?)?.toInt() ?? 0,
      today: (json['today'] as num?)?.toInt() ?? 0,
      lastCountedEpochDay: (json['lastCountedEpochDay'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is SalawatStats &&
      other.total == total &&
      other.today == today &&
      other.lastCountedEpochDay == lastCountedEpochDay;

  @override
  int get hashCode => Object.hash(total, today, lastCountedEpochDay);
}
