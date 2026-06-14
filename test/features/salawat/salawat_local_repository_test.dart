import 'package:flutter_test/flutter_test.dart';
import 'package:hasanat/features/salawat/data/salawat_local_repository.dart';
import 'package:hasanat/features/salawat/domain/salawat_stats.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferences prefs;
  late SalawatLocalRepository repo;

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    prefs = await SharedPreferences.getInstance();
    repo = SalawatLocalRepository(prefs);
  });

  test('boshlang\'ich holatda bo\'sh statistika qaytaradi', () async {
    final result = await repo.load();
    expect(result.isOk, isTrue);
    expect(result.valueOrNull, const SalawatStats());
  });

  test('increment total va today ni oshiradi', () async {
    final r1 = await repo.increment(by: 1);
    expect(r1.valueOrNull?.total, 1);
    expect(r1.valueOrNull?.today, 1);

    final r2 = await repo.increment(by: 2);
    expect(r2.valueOrNull?.total, 3);
    expect(r2.valueOrNull?.today, 3);
  });

  test('increment qiymatni qurilmada saqlaydi (qayta o\'qishda saqlanadi)', () async {
    await repo.increment(by: 5);

    final fresh = SalawatLocalRepository(prefs);
    final loaded = await fresh.load();
    expect(loaded.valueOrNull?.total, 5);
  });

  test('reset hisoblagichni nolga tushiradi', () async {
    await repo.increment(by: 4);
    final result = await repo.reset();
    expect(result.valueOrNull, const SalawatStats());
  });
}
