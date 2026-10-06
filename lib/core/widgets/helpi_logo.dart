import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

/// "HelpI" wordmark. The accent always stays LTR so the brand reads the same
/// way inside the Arabic layout.
class HelpIWordmark extends StatelessWidget {
  const HelpIWordmark({
    super.key,
    this.fontSize = 24,
    this.color = AppColors.brandBlue,
    this.accentColor = AppColors.gold,
    this.letterSpacing = 0.4,
  });

  final double fontSize;
  final Color color;
  final Color accentColor;
  final double letterSpacing;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
          height: 1,
          letterSpacing: letterSpacing,
        ),
        children: [
          TextSpan(text: 'Help', style: TextStyle(color: color)),
          const TextSpan(text: ' '),
          TextSpan(text: 'I', style: TextStyle(color: accentColor)),
        ],
      ),
      textDirection: TextDirection.ltr,
    );
  }
}

/// Full splash lockup: star, accessibility figure, wordmark.
class HelpILogo extends StatelessWidget {
  const HelpILogo({super.key, this.figureSize = 88});

  final double figureSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: AppColors.gold, size: figureSize * 0.55),
        SizedBox(height: figureSize * 0.1),
        Icon(Icons.accessible, color: AppColors.ink, size: figureSize),
        const SizedBox(height: 6),
        HelpIWordmark(fontSize: figureSize * 0.4, color: AppColors.ink),
      ],
    );
  }
}

/// Circular brand badge used on the authentication screens.
class HelpIAvatar extends StatelessWidget {
  const HelpIAvatar({super.key, this.size = 104});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: AppColors.skyBlue, shape: BoxShape.circle),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.accessible, color: AppColors.ink, size: size * 0.38),
          const SizedBox(height: 2),
          HelpIWordmark(
            fontSize: size * 0.15,
            color: AppColors.ink,
            letterSpacing: 0,
          ),
          Icon(Icons.star, color: AppColors.gold, size: size * 0.13),
        ],
      ),
    );
  }
}
