import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_dimens.dart';

/// Filter chip for place categories. 48px tall to satisfy the touch-target
/// minimum, with a clear selected state that does not rely on colour alone
/// (weight + fill change together).
class CategoryChip extends StatelessWidget {
  const CategoryChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
    this.imagePath,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: Material(
        color: selected ? AppColors.deepBlue : AppColors.skyBlueSoft,
        borderRadius: BorderRadius.circular(AppDimens.chipRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppDimens.chipRadius),
          child: Container(
            constraints: const BoxConstraints(minHeight: AppDimens.minTouchTarget),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimens.chipRadius),
              border: Border.all(
                color: selected ? AppColors.deepBlue : AppColors.skyBlue,
                width: selected ? 1.4 : 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (imagePath != null) ...[
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      selected ? Colors.white : AppColors.deepBlue,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      imagePath!,
                      width: 22,
                      height: 22,
                      fit: BoxFit.contain,
                      excludeFromSemantics: true,
                    ),
                  ),
                  const SizedBox(width: 6),
                ] else if (icon != null) ...[
                  Icon(
                    icon,
                    size: 18,
                    color: selected ? Colors.white : AppColors.deepBlue,
                  ),
                  const SizedBox(width: 6),
                ],
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                    color: selected ? Colors.white : AppColors.deepBlue,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
