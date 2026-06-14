import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hasanat/core/providers/app_providers.dart';
import 'package:hasanat/features/salawat/application/salawat_controller.dart';
import 'package:hasanat/features/salawat/domain/salawat_stats.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProviderContainer container;

  setUp(() async {
    SharedPreferences.setMockInitialValues(<String, Object>{});
    final prefs = await SharedPreferences.getInstance();
    container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
    );
    addTearDown(container.dispose);
  });

  test('boshlang\'ich holat bo\'sh statistika', () async {
    final stats = await container.read(salawatControllerProvider.future);
    expect(stats, const SalawatStats());
  });

  test('add() salovat sonini oshiradi', () async {
    // Controller'ni ishga tushirish uchun avval kutamiz.
    await container.read(salawatControllerProvider.future);

    final controller = container.read(salawatControllerProvider.notifier);
    await controller.add();
    await controller.add();

    final state = container.read(salawatControllerProvider).value;
    expect(state?.total, 2);
    expect(state?.today, 2);
  });

  test('reset() holatni tozalaydi', () async {
    await container.read(salawatControllerProvider.future);
    final controller = container.read(salawatControllerProvider.notifier);
    await controller.add();
    await controller.reset();

    final state = container.read(salawatControllerProvider).value;
    expect(state, const SalawatStats());
  });
}
