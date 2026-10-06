import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/entities/accessibility_feature.dart';
import 'place_ui.dart';

/// Single accessibility affordance badge with its illustration and label.
class AccessibilityBadge extends StatelessWidget {
  const AccessibilityBadge({
    super.key,
    required this.feature,
    this.compact = false,
  });

  final AccessibilityFeature feature;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Semantics(
      label: feature.label(l10n),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 8 : 12,
          vertical: compact ? 6 : 8,
        ),
        decoration: BoxDecoration(
          color: AppColors.skyBlueSoft,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.skyBlue),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: compact ? 30 : 42,
              height: compact ? 30 : 42,
              padding: EdgeInsets.all(compact ? 5 : 7),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(compact ? 9 : 12),
              ),
              child: Image.asset(
                feature.imagePath,
                fit: BoxFit.contain,
                excludeFromSemantics: true,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              feature.label(l10n),
              style: TextStyle(
                fontSize: compact ? 11 : 13,
                fontWeight: FontWeight.w700,
                color: AppColors.deepBlue,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
