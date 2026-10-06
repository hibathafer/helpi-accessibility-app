/// Pure, context-free form validation.
///
/// Screens pass in localized messages, which keeps this file free of any
/// framework or localization dependency and easy to unit test.
abstract final class Validators {
  static final RegExp _email = RegExp(
    r'^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$',
  );

  static String? required(String? value, String message) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  static String? email(
    String? value, {
    required String requiredMessage,
    required String invalidMessage,
  }) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return requiredMessage;
    if (!_email.hasMatch(v)) return invalidMessage;
    return null;
  }

  static String? password(
    String? value, {
    required String requiredMessage,
    required String tooShortMessage,
    required String weakMessage,
  }) {
    final v = value ?? '';
    if (v.isEmpty) return requiredMessage;
    if (v.length < 8) return tooShortMessage;
    final hasLetter = RegExp(r'[A-Za-z]').hasMatch(v);
    final hasDigit = RegExp(r'[0-9]').hasMatch(v);
    if (!hasLetter || !hasDigit) return weakMessage;
    return null;
  }

  static String? matches(String? value, String other, String message) {
    if (value != other) return message;
    return null;
  }
}
