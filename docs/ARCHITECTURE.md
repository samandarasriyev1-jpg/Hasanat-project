# Hasanat — Arxitektura qo'llanmasi

Bu hujjat loyihaning texnik tuzilishi va kod yozish qoidalarini tavsiflaydi.
Yangi funksiya qo'shayotganda shu naqshga (pattern) amal qiling.

## Umumiy yondashuv

- **Feature-first** tuzilma: har bir funksiya `lib/features/<name>/` ichida o'z
  qatlamlari bilan joylashadi.
- **Qatlamlar (layers)** har bir funksiya ichida:
  - `domain/` — modellar (immutable) va repozitoriy interfeyslari. Flutter'ga
    bog'liq emas.
  - `data/` — repozitoriy implementatsiyalari (lokal saqlash, Supabase, ...).
  - `application/` — Riverpod controllerlari (holat boshqaruvi).
  - `presentation/` — ekranlar va widgetlar (UI).
- **State management:** Riverpod (`Notifier` / `AsyncNotifier`).
- **Navigatsiya:** `go_router` (`lib/core/router/`).
- **Xato boshqaruvi:** istisno otish o'rniga `Result<T>` (`Ok`/`Err`) qaytariladi.

## Papka tuzilmasi

```
lib/
  core/
    config/        # EnvConfig (.env)
    error/         # Failure (sealed)
    providers/     # Global providerlar (sharedPreferencesProvider)
    router/        # AppRouter (go_router)
    services/      # SupabaseService
    theme/         # AppColors, AppSpacing, AppTypography, AppTheme
    utils/         # AppLogger, Result
  features/
    onboarding/
      application/ # OnboardingController
      *_screen.dart
    salawat/       # ETALON FUNKSIYA — namuna sifatida foydalaning
      domain/      # SalawatStats, SalawatRepository
      data/        # SalawatLocalRepository
      application/ # SalawatController (AsyncNotifier)
      presentation/# SalawatScreen
    profile/
    settings/
      application/ # LocaleController
    home/
  l10n/            # ARB fayllar (uz/ru/en) — app_localizations.dart generatsiya qilinadi
  shared/widgets/  # Umumiy widgetlar (GradientButton)
  main.dart
```

## Xato boshqaruvi (`Result`)

Repozitoriylar hech qachon istisno otmaydi — ular `Result<T>` qaytaradi:

```dart
final Result<SalawatStats> r = await repo.increment();
r.when(
  ok: (stats) => /* yangilash */,
  err: (failure) => /* failure.message ni ko'rsatish */,
);
```

`Failure` — `sealed` klass: `NetworkFailure`, `CacheFailure`, `ServerFailure`,
`UnknownFailure`.

## Lokalizatsiya

- Barcha foydalanuvchiga ko'rinadigan matnlar `lib/l10n/*.arb` da bo'lishi shart.
- Kodda `AppLocalizations.of(context)!` orqali ishlatiladi.
- `app_localizations.dart` build paytida generatsiya qilinadi (`generate: true`).
  Shu sabab u `.gitignore` da.
- Til `LocaleController` orqali almashtiriladi va `SharedPreferences` da saqlanadi.

## Yangi funksiya qo'shish (qadamlar)

1. `lib/features/<name>/domain/` da model va repozitoriy interfeysini yarating.
2. `data/` da implementatsiya yozing, `Result<T>` qaytaring.
3. `application/` da Riverpod controller yarating.
4. `presentation/` da `ConsumerWidget` ekran quring.
5. `l10n` ga matnlarni qo'shing.
6. `test/` ga unit/widget testlar yozing.

## Sifat tekshiruvi (lokal)

```bash
dart format .
flutter analyze
flutter test
```

CI (`.github/workflows/ci.yml`) har push va PR'da shu uchtasini ishlatadi.
