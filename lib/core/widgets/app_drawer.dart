import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../l10n/generated/app_localizations.dart';
import '../constants/app_colors.dart';
import '../localization/locale_cubit.dart';
import '../routing/app_router.dart';
import 'helpi_logo.dart';

/// Navigation drawer reachable from the header's menu button.
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final localeCubit = BlocProvider.of<LocaleCubit>(context);
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              child: Row(
                children: [
                  const HelpIAvatar(size: 52),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HelpIWordmark(fontSize: 22),
                        const SizedBox(height: 4),
                        Text(
                          l10n.slogan,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            _DrawerTile(
              icon: Icons.home,
              label: l10n.navHome,
              route: AppRoutes.dashboard,
            ),
            _DrawerTile(
              icon: Icons.map,
              label: l10n.mapTitle,
              route: AppRoutes.map,
            ),
            _DrawerTile(
              icon: Icons.home_repair_service,
              label: l10n.servicesTitle,
              route: AppRoutes.services,
            ),
            _DrawerTile(
              icon: Icons.person,
              label: l10n.profile,
              route: AppRoutes.profile,
            ),
            const Divider(),
            ListTile(
              minLeadingWidth: 24,
              leading: const Icon(Icons.language, color: AppColors.deepBlue),
              title: Text(l10n.language),
              subtitle: Text(isArabic ? l10n.arabic : l10n.english),
              trailing: const Icon(Icons.swap_horiz, color: AppColors.deepBlue),
              // The whole tree rebuilds in the new locale (and direction),
              // which is its own confirmation.
              onTap: () {
                localeCubit.toggle();
                Navigator.of(context).pop();
              },
            ),
            const Spacer(),
            const Divider(),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                if (!state.isAuthenticated) return const SizedBox.shrink();
                return ListTile(
                  minLeadingWidth: 24,
                  leading: const Icon(Icons.logout, color: AppColors.danger),
                  title: Text(
                    l10n.signOut,
                    style: const TextStyle(
                      color: AppColors.danger,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  onTap: () {
                    BlocProvider.of<AuthBloc>(context)
                        .add(const AuthSignOutRequested());
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({
    required this.icon,
    required this.label,
    required this.route,
  });

  final IconData icon;
  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return ListTile(
      minLeadingWidth: 24,
      leading: Icon(icon, color: AppColors.deepBlue),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      onTap: () {
        navigator.pop();
        if (currentRoute != route) navigator.pushNamed(route);
      },
    );
  }
}
