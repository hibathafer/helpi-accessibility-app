import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';

/// App-wide Material theme. Colours, radii and text styles all come from
/// [AppColors] / [AppDimens] so screens never hard-code design tokens.
ThemeData buildAppTheme() {
  final base = ThemeData(useMaterial3: true, brightness: Brightness.light);

  return base.copyWith(
    scaffoldBackgroundColor: AppColors.canvas,
    colorScheme: base.colorScheme.copyWith(
      primary: AppColors.deepBlue,
      onPrimary: Colors.white,
      secondary: AppColors.skyBlue,
      onSecondary: AppColors.ink,
      surface: AppColors.surface,
      error: AppColors.danger,
      outline: AppColors.border,
    ),
    textTheme: base.textTheme.copyWith(
      headlineSmall: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        color: AppColors.brandBlue,
        height: 1.25,
      ),
      titleLarge: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: AppColors.brandBlue,
        height: 1.3,
      ),
      titleMedium: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.brandBlue,
        height: 1.35,
      ),
      titleSmall: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.4,
      ),
      bodyLarge: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        height: 1.55,
      ),
      bodyMedium: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.55,
      ),
      bodySmall: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.45,
      ),
      labelLarge: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: AppColors.deepBlue,
        height: 1.3,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      hintStyle: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 15,
        height: 1.4,
      ),
      errorStyle: const TextStyle(
        color: AppColors.danger,
        fontSize: 13,
        height: 1.35,
      ),
      border: _inputBorder(AppColors.border),
      enabledBorder: _inputBorder(AppColors.border),
      focusedBorder: _inputBorder(AppColors.deepBlue, width: 1.6),
      errorBorder: _inputBorder(AppColors.danger),
      focusedErrorBorder: _inputBorder(AppColors.danger, width: 1.6),
      disabledBorder: _inputBorder(AppColors.border),
    ),
    filledButtonTheme: FilledButtonThemeData(style: _primaryButtonStyle()),
    textButtonTheme: TextButtonThemeData(style: _textButtonStyle()),
    dividerTheme: const DividerThemeData(
      color: AppColors.border,
      thickness: 1,
      space: 1,
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.deepBlue,
      contentTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        height: 1.4,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );
}

InputBorder _inputBorder(Color color, {double width = 1.4}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppDimens.fieldRadius),
    borderSide: BorderSide(color: color, width: width),
  );
}

ButtonStyle _primaryButtonStyle() {
  return FilledButton.styleFrom(
    backgroundColor: AppColors.deepBlue,
    foregroundColor: Colors.white,
    disabledBackgroundColor: const Color(0xFF9FB4DC),
    disabledForegroundColor: Colors.white,
    minimumSize: const Size(AppDimens.minTouchTarget, AppDimens.buttonHeight),
    padding: const EdgeInsets.symmetric(horizontal: 20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppDimens.buttonRadius),
    ),
    textStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
  );
}

ButtonStyle _textButtonStyle() {
  return TextButton.styleFrom(
    foregroundColor: AppColors.deepBlue,
    minimumSize: const Size(AppDimens.minTouchTarget, AppDimens.minTouchTarget),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
  );
}
