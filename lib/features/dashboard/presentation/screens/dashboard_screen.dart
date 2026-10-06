import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimens.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../widgets/daily_message_card.dart';
import '../widgets/dashboard_grid.dart';

/// Home: daily message plus the module launcher grid.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void _open(BuildContext context, String route) {
    Navigator.of(context).pushNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppScaffold(
      bottomNavIndex: 2,
      body: SingleChildScrollView(
        padding: kScreenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const DailyMessageCard(),
            const SizedBox(height: AppDimens.gapLg),
            GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                DashboardTile(
                  imagePath: 'assets/images/taxiLogo.png',
                  label: l10n.navTransport,
                  onTap: () => _open(context, AppRoutes.transport),
                ),
                DashboardTile(
                  imagePath: 'assets/images/mapLogo.png',
                  label: l10n.navPlaces,
                  onTap: () => _open(context, AppRoutes.map),
                ),
                DashboardTile(
                  imagePath: 'assets/images/smartHomeLogo.png',
                  label: l10n.navHome,
                  onTap: () => _open(context, AppRoutes.services),
                ),
                DashboardTile(
                  imagePath: 'assets/images/helperLogo.png',
                  label: l10n.navServices,
                  onTap: () => _open(context, AppRoutes.services),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
