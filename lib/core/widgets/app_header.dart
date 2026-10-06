import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';
import '../routing/app_router.dart';
import 'helpi_logo.dart';

/// Which control leads the header: navigation drawer, back button, or nothing.
enum HeaderLeading { menu, back, none }

/// Fixed app header: leading control, centred wordmark, profile shortcut.
class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({
    super.key,
    this.leading = HeaderLeading.menu,
    this.onMenu,
    this.onBack,
    this.onProfile,
  });

  final HeaderLeading leading;
  final VoidCallback? onMenu;
  final VoidCallback? onBack;
  final VoidCallback? onProfile;

  @override
  Size get preferredSize => const Size.fromHeight(AppDimens.headerHeight);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final IconData? leadingIcon;
    final String leadingLabel;
    final VoidCallback? leadingAction;

    switch (leading) {
      case HeaderLeading.menu:
        leadingIcon = Icons.menu;
        leadingLabel = l10n.menu;
        leadingAction = onMenu;
      case HeaderLeading.back:
        leadingIcon = Icons.arrow_back;
        leadingLabel = l10n.back;
        leadingAction = onBack ?? () => Navigator.of(context).maybePop();
      case HeaderLeading.none:
        leadingIcon = null;
        leadingLabel = '';
        leadingAction = null;
    }

    return Material(
      color: AppColors.surface,
      child: SafeArea(
        bottom: false,
        child: Container(
          height: AppDimens.headerHeight,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.border)),
          ),
          child: Row(
            children: [
              _HeaderButton(
                icon: leadingIcon,
                label: leadingLabel,
                onTap: leadingAction,
              ),
              const Spacer(),
              const HelpIWordmark(fontSize: 26),
              const Spacer(),
              _HeaderButton(
                icon: Icons.person,
                label: l10n.profile,
                onTap: onProfile ??
                    () => Navigator.of(context).pushNamed(AppRoutes.profile),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  const _HeaderButton({this.icon, required this.label, this.onTap});

  final IconData? icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    // Keeps the wordmark optically centred when a side is empty.
    if (icon == null) {
      return const SizedBox(
        width: AppDimens.minTouchTarget,
        height: AppDimens.minTouchTarget,
      );
    }

    return Semantics(
      button: true,
      label: label,
      child: Tooltip(
        message: label,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: AppDimens.minTouchTarget,
            height: AppDimens.minTouchTarget,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: Icon(icon, size: 24, color: AppColors.deepBlue),
          ),
        ),
      ),
    );
  }
}
