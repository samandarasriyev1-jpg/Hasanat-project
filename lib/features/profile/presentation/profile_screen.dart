import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/application/auth_controller.dart';
import '../../settings/application/locale_controller.dart';

/// Profil ekrani — hisob ma'lumoti va til sozlamasi.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final currentLocale = ref.watch(localeControllerProvider);
    final controller = ref.read(localeControllerProvider.notifier);
    final user = ref.watch(authControllerProvider);
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        // Hisob bo'limi
        Text(l10n.authAccount, style: theme.textTheme.titleLarge),
        const SizedBox(height: AppSpacing.sm),
        if (user != null)
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primary,
                child: Text(
                  user.displayName.substring(0, 1).toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(user.displayName),
              subtitle: user.email != null ? Text(user.email!) : null,
              trailing: IconButton(
                tooltip: l10n.authSignOut,
                icon: const Icon(Icons.logout_rounded),
                onPressed: () =>
                    ref.read(authControllerProvider.notifier).signOut(),
              ),
            ),
          ),
        const SizedBox(height: AppSpacing.lg),

        // Til bo'limi
        Text(l10n.profileLanguage, style: theme.textTheme.titleLarge),
        const SizedBox(height: AppSpacing.sm),
        _LanguageTile(
          title: l10n.languageSystem,
          selected: currentLocale == null,
          onTap: () => controller.setLocale(null),
        ),
        _LanguageTile(
          title: l10n.languageUzbek,
          selected: currentLocale?.languageCode == 'uz',
          onTap: () => controller.setLocale(const Locale('uz')),
        ),
        _LanguageTile(
          title: l10n.languageRussian,
          selected: currentLocale?.languageCode == 'ru',
          onTap: () => controller.setLocale(const Locale('ru')),
        ),
        _LanguageTile(
          title: l10n.languageEnglish,
          selected: currentLocale?.languageCode == 'en',
          onTap: () => controller.setLocale(const Locale('en')),
        ),
      ],
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: selected
          ? Icon(Icons.check_circle_rounded,
              color: Theme.of(context).colorScheme.primary)
          : const Icon(Icons.circle_outlined),
      onTap: onTap,
    );
  }
}
