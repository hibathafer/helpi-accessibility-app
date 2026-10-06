import 'package:flutter/material.dart';

/// HelpI brand palette.
///
/// Contrast notes (WCAG 2.1): text pairs are AA or better for body copy —
/// [deepBlue] on white ≈ 9:1, [textPrimary] on white ≈ 16:1,
/// [textSecondary] on white ≈ 7:1. [skyBlue] is decorative only and is never
/// used as a text colour.
abstract final class AppColors {
  /// Primary action colour: buttons, active states.
  static const deepBlue = Color(0xFF123A8C);

  /// Headings and emphasised labels.
  static const brandBlue = Color(0xFF0E4DA4);

  /// Brand accent for logo tiles and illustration fills.
  static const skyBlue = Color(0xFF7EC9F2);

  /// Tinted background for chips, badges and tiles.
  static const skyBlueSoft = Color(0xFFDCEFFB);

  /// The "I" of the wordmark and the star in the lockup.
  static const gold = Color(0xFFF5C518);

  static const canvas = Color(0xFFF6F8FC);
  static const surface = Color(0xFFFFFFFF);
  static const border = Color(0xFFE2E8F2);

  static const textPrimary = Color(0xFF101828);
  static const textSecondary = Color(0xFF475467);
  static const danger = Color(0xFFD92D20);

  /// Ink used by the logo illustration.
  static const ink = Color(0xFF0B0F19);

  // --- Map surface -------------------------------------------------------
  static const mapLand = Color(0xFFF1F3EC);
  static const mapRoad = Color(0xFFFFFFFF);
  static const mapPark = Color(0xFFDCEBD4);
  static const mapWater = Color(0xFFCDE5F6);
  static const markerRed = Color(0xFFE53935);
}
