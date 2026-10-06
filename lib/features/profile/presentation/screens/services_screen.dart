import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../widgets/service_card.dart';

/// Home adaptations and community support.
class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  void _confirmRequest(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _callSupport(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    var launched = false;
    try {
      launched = await launchUrl(Uri.parse('tel:+96265000000'));
    } catch (_) {
      launched = false;
    }
    if (!launched && context.mounted) {
      _confirmRequest(context, l10n.callFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppScaffold(
      bottomNavIndex: 1,
      body: SingleChildScrollView(
        padding: kScreenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.navHome,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppDimens.gapLg),
            ServiceCard(
              icon: Icons.home,
              title: l10n.homeTitle,
              description: l10n.homeDesc,
              actionLabel: l10n.homeAction,
              onAction: () => _confirmRequest(context, l10n.requestSent),
            ),
            const SizedBox(height: AppDimens.gap),
            ServiceCard(
              icon: Icons.groups,
              title: l10n.communityTitle,
              description: l10n.communityDesc,
              actionLabel: l10n.communityAction,
              onAction: () => _confirmRequest(context, l10n.requestSent),
            ),
            const SizedBox(height: AppDimens.gap),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.skyBlueSoft,
                borderRadius: BorderRadius.circular(AppDimens.cardRadius),
                border: Border.all(color: AppColors.skyBlue),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.headset_mic,
                        color: AppColors.deepBlue,
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          l10n.hotlineTitle,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: AppColors.deepBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.hotlineDesc,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    label: l10n.callAction,
                    icon: Icons.call,
                    onPressed: () => _callSupport(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
