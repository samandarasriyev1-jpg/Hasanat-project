# Hasanat

**Hasanat** — musulmonlarni yaxshilikka undovchi diniy gamifikatsiya va xayriya ilovasi.
Insonlar salovat aytadi, ehson qiladi, hasharga qatnashadi va mahalla → tuman →
viloyat → respublika kesimida yaxshilikda bellashadi.

> Niyat: sadaqai jariya — ummatga foyda keltirish.

## Asosiy funksiyalar (rejada)

- **Salovat counter** va ball tizimi
- **Leaderboard** — TOP 20 (qishloq / tuman / viloyat / respublika)
- **Masjid xaritasi** (O'zbekiston masjidlari) va hashar e'lonlari
- **Ehson** tizimi (Payme / Click / Uzum)
- **Ijtimoiy feed** (yaxshilik postlari)
- **Namoz vaqtlari** va qibla kompasi
- **Ta'lim** — Arab tili va Quron o'qish kurslari

## Texnologiyalar

| Qatlam | Texnologiya |
|--------|-------------|
| Frontend | Flutter (iOS + Android) |
| State | Riverpod |
| Routing | go_router |
| Backend | Supabase (PostgreSQL + Auth + Storage + Realtime) |
| Tipografika | Google Fonts (Amiri + Inter) |

## Papka tuzilmasi

```
lib/
  core/          # Asosiy: theme, config, services, router
    config/      # EnvConfig (.env)
    services/    # SupabaseService
    theme/       # AppColors, AppSpacing, AppTypography, AppTheme
    router/      # AppRouter (go_router)
  features/      # Har bir funksiya alohida modul
    onboarding/  # Splash, Welcome
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
2. Bog'liqliklarni yuklang:
   ```bash
   flutter pub get
   ```
3. Supabase sozlash:
   - [supabase.com](https://supabase.com) da loyiha oching.
   - `.env.example` faylidan nusxa oling:
     ```bash
     cp .env.example .env
     ```
   - `.env` ichiga `SUPABASE_URL` va `SUPABASE_ANON_KEY` qiymatlarini yozing.
   - > Kalitlarsiz ham ilova ishga tushadi (offline rejimda UIni ko'rish uchun).
4. Ishga tushiring:
   ```bash
   flutter run
   ```

## CI

Har push'da `.gitlab-ci.yml` orqali `flutter analyze` va `flutter test` ishlaydi.

## Yo'l xaritasi

Loyiha epic va issue'lari GitLab'da boshqariladi. Joriy bosqich: **MVP**.
