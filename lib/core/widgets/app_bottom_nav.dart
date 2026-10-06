import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../constants/app_colors.dart';
import '../routing/app_router.dart';

/// Three-item bottom navigation (profile · community · home) matching the
/// design. Tabs are pushed rather than swapped so system back still works.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({super.key, this.currentIndex});

  /// 0 = profile, 1 = community/services, 2 = home. `null` highlights nothing.
  final int? currentIndex;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final items = <_NavItem>[
      _NavItem(route: AppRoutes.profile, icon: Icons.person, label: l10n.profile),
      _NavItem(
        route: AppRoutes.services,
        icon: Icons.favorite,
        label: l10n.servicesTitle,
      ),
      _NavItem(route: AppRoutes.dashboard, icon: Icons.home, label: l10n.navHome),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (var i = 0; i < items.length; i++)
              _NavItemButton(item: items[i], active: currentIndex == i),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({required this.route, required this.icon, required this.label});

  final String route;
  final IconData icon;
  final String label;
}

class _NavItemButton extends StatelessWidget {
  const _NavItemButton({required this.item, required this.active});

  final _NavItem item;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Semantics(
      button: true,
      selected: active,
      label: item.label,
      child: Tooltip(
        message: item.label,
        child: InkWell(
          onTap: () {
            if (currentRoute == item.route) return;
            navigator.pushNamed(item.route);
          },
          customBorder: const CircleBorder(),
          child: Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active ? AppColors.skyBlueSoft : AppColors.surface,
              border: Border.all(
                color: active ? AppColors.skyBlue : AppColors.border,
              ),
            ),
            child: Icon(
              item.icon,
              size: 26,
              color: active ? AppColors.deepBlue : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
