# Hasanat

**Hasanat** — musulmonlarni yaxshilikka undovchi diniy gamifikatsiya va xayriya ilovasi.
Insonlar salovat aytadi, ehson qiladi, hasharga qatnashadi va mahalla → tuman →
viloyat → respublika kesimida yaxshilikda bellashadi.

> Niyat: sadaqai jariya — ummatga foyda keltirish.

## Asosiy funksiyalar

- ✅ **Autentifikatsiya** (Supabase: email + parol) va sessiya boshqaruvi
- ✅ **Salovat counter** va ball tizimi (lokal saqlash bilan)
- ✅ Ko'p tillilik (uz / ru / en) va til almashtirish
- 🔜 **Leaderboard** — TOP 20 (qishloq / tuman / viloyat / respublika)
- 🔜 **Masjid xaritasi** (O'zbekiston masjidlari) va hashar e'lonlari
- 🔜 **Ehson** tizimi (Payme / Click / Uzum)
- 🔜 **Ijtimoiy feed** (yaxshilik postlari)
- 🔜 **Namoz vaqtlari** va qibla kompasi
- 🔜 **Ta'lim** — Arab tili va Quron o'qish kurslari

## Texnologiyalar

| Qatlam | Texnologiya |
|--------|-------------|
| Frontend | Flutter (iOS + Android) |
| State | Riverpod (Notifier / AsyncNotifier) |
| Routing | go_router |
| Backend | Supabase (PostgreSQL + Auth + Storage + Realtime) |
| Lokal saqlash | shared_preferences |
| Tipografika | Google Fonts (Amiri + Inter) |

## Papka tuzilmasi

```
lib/
  core/          # Asosiy: theme, config, services, router, utils, error
    config/      # EnvConfig (.env)
    error/       # Failure (sealed)
    providers/   # Global providerlar
    services/    # SupabaseService
    theme/       # AppColors, AppSpacing, AppTypography, AppTheme
    utils/       # AppLogger, Result
    router/      # AppRouter (go_router)
  features/      # Har bir funksiya alohida modul (domain/data/application/presentation)
    onboarding/  # Splash, Welcome
    auth/        # Kirish / ro'yxatdan o'tish (Supabase)
    salawat/     # Salovat counter (etalon namuna)
    profile/     # Profil
    settings/    # Til sozlamasi
    home/        # Bosh ekran (bottom navigation)
  shared/        # Umumiy widgetlar (GradientButton, ...)
    widgets/
  l10n/          # Tarjimalar (uz, ru, en)
```

## Dizayn tizimi

Diniy estetika: chuqur **zumrad yashil** + **oltin** urg'u. Material 3, light/dark rejim.
Barcha ranglar, masofalar va tipografika `lib/core/theme/` da markazlashtirilgan.

## Ishga tushirish

1. Flutter SDK (3.22+) o'rnatilgan bo'lsin.
2. Platforma papkalarini tiklang (agar `android/`, `ios/` mavjud bo'lmasa):
   ```bash
   flutter create .
   ```
3. Bog'liqliklarni yuklang:
   ```bash
   flutter pub get
   ```
4. Supabase sozlash:
   - [supabase.com](https://supabase.com) da loyiha oching.
   - `.env.example` faylidan nusxa oling:
     ```bash
     cp .env.example .env
     ```
   - `.env` ichiga `SUPABASE_URL` va `SUPABASE_ANON_KEY` qiymatlarini yozing.
   - > Kalitlarsiz ham ilova ishga tushadi (offline rejimda UIni ko'rish uchun).
5. Ishga tushiring:
   ```bash
   flutter run
   ```

## Sifat tekshiruvi

```bash
dart format .
flutter analyze
flutter test
```

## CI

Har push va PR'da `.github/workflows/ci.yml` (GitHub Actions) orqali
`dart format`, `flutter analyze` va `flutter test` ishlaydi.

## Arxitektura

Texnik tuzilish va kod yozish qoidalari uchun [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md)
ga qarang. Qisqacha: feature-first tuzilma, qatlamlar (`domain` / `data` /
`application` / `presentation`), Riverpod, `Result` orqali xato boshqaruvi.
`features/salawat/` — yangi funksiyalar uchun **etalon namuna**.

## Yo'l xaritasi

Joriy bosqich: **MVP**. Tayyor: dizayn tizimi, onboarding, lokalizatsiya
(uz/ru/en), autentifikatsiya (Supabase), Salovat counter (lokal). Keyingi:
Leaderboard, Masjid xaritasi, Ehson, Namoz vaqtlari, Feed, Ta'lim.
