import 'package:flutter/material.dart';

import '../../../../core/constants/app_dimens.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../widgets/service_card.dart';

class TransportScreen extends StatelessWidget {
  const TransportScreen({super.key});

  void _showDemoNotice(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l10n.requestSent)));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppScaffold(
      body: SingleChildScrollView(
        padding: kScreenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.transportTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppDimens.gapLg),
            ServiceCard(
              icon: Icons.airport_shuttle,
              title: l10n.transportTitle,
              description: l10n.transportDesc,
              actionLabel: l10n.transportAction,
              onAction: () => _showDemoNotice(context),
            ),
          ],
        ),
      ),
    );
  }
}
