import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';

/// Reusable container decorations so every card in the app shares the same
/// 16px radius, border and elevation.
abstract final class AppDecorations {
  static BoxDecoration card({
    Color color = AppColors.surface,
    Color borderColor = AppColors.border,
    double radius = AppDimens.cardRadius,
    bool elevated = true,
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: borderColor),
      boxShadow: elevated
          ? const [
              BoxShadow(
                color: Color(0x0A101828),
                blurRadius: 18,
                offset: Offset(0, 8),
              ),
            ]
          : null,
    );
  }
}
