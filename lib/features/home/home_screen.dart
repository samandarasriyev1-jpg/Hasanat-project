import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';
import '../../l10n/app_localizations.dart';
import '../profile/presentation/profile_screen.dart';
import '../salawat/presentation/salawat_screen.dart';

/// Asosiy ekran — NavigationBar bilan 5 ta bo'lim.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final labels = <String>[
      l10n.tabHome,
      l10n.tabSalawat,
      l10n.tabLeaderboard,
      l10n.tabMosques,
      l10n.tabProfile,
    ];
    const icons = <IconData>[
      Icons.home_rounded,
      Icons.favorite_rounded,
      Icons.leaderboard_rounded,
      Icons.mosque_rounded,
      Icons.person_rounded,
    ];

    final pages = <Widget>[
      _ComingSoon(section: l10n.tabHome, icon: icons[0]),
      const SalawatScreen(),
      _ComingSoon(section: l10n.tabLeaderboard, icon: icons[2]),
      _ComingSoon(section: l10n.tabMosques, icon: icons[3]),
      const ProfileScreen(),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(labels[_index])),
      body: SafeArea(child: pages[_index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: [
          for (int i = 0; i < labels.length; i++)
            NavigationDestination(icon: Icon(icons[i]), label: labels[i]),
        ],
      ),
    );
  }
}

/// Hali tayyor bo'lmagan bo'limlar uchun placeholder.
class _ComingSoon extends StatelessWidget {
  const _ComingSoon({required this.section, required this.icon});

  final String section;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 72, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.comingSoon(section),
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
