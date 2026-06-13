import 'package:flutter/material.dart';

import '../../core/theme/app_spacing.dart';

/// Asosiy ekran — bottom navigation bilan (tablar hozircha placeholder).
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  static const List<_TabInfo> _tabs = [
    _TabInfo('Bosh sahifa', Icons.home_rounded),
    _TabInfo('Salovat', Icons.favorite_rounded),
    _TabInfo('Reyting', Icons.leaderboard_rounded),
    _TabInfo('Masjidlar', Icons.mosque_rounded),
    _TabInfo('Profil', Icons.person_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    final _TabInfo tab = _tabs[_index];
    return Scaffold(
      appBar: AppBar(title: Text(tab.label)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(tab.icon, size: 72, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: AppSpacing.md),
              Text(
                '${tab.label} bo'limi tez orada',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: [
          for (final _TabInfo t in _tabs)
            NavigationDestination(icon: Icon(t.icon), label: t.label),
        ],
      ),
    );
  }
}

class _TabInfo {
  const _TabInfo(this.label, this.icon);
  final String label;
  final IconData icon;
}
