import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/prefs_keys.dart';
import '../models/user_model.dart';

/// Local account store.
///
/// MVP stand-in for a backend: accounts live in [SharedPreferences] so the
/// demo survives an app restart, and a seeded demo account guarantees the
/// judges can sign in without registering.
class AuthLocalDataSource {
  AuthLocalDataSource(this._prefs);

  final SharedPreferences _prefs;

  static const demoEmail = 'demo@helpi.app';
  static const demoPassword = 'Helpi1234';
  static const demoName = 'Demo Explorer';

  /// Must run before the first sign-in attempt.
  Future<void> ensureSeeded() async {
    if (_prefs.containsKey(PrefsKeys.accounts)) return;
    await _saveAccounts([
      <String, dynamic>{
        'id': 'demo-user',
        'name': demoName,
        'email': demoEmail,
        'password': demoPassword,
      },
    ]);
  }

  Future<String?> passwordFor(String email) async {
    final normalized = _normalize(email);
    for (final account in _readAccounts()) {
      if (_normalize(account['email'] as String? ?? '') == normalized) {
        return account['password'] as String?;
      }
    }
    return null;
  }

  Future<UserModel?> accountFor(String email) async {
    final normalized = _normalize(email);
    for (final account in _readAccounts()) {
      if (_normalize(account['email'] as String? ?? '') == normalized) {
        return UserModel.fromJson(account);
      }
    }
    return null;
  }

  /// Creates or replaces the account for [email].
  Future<void> upsertAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    final normalized = _normalize(email);
    final accounts = _readAccounts()
      ..removeWhere((a) => _normalize(a['email'] as String? ?? '') == normalized)
      ..add(<String, dynamic>{
        'id': 'u-${DateTime.now().microsecondsSinceEpoch}',
        'name': name.trim(),
        'email': normalized,
        'password': password,
      });
    await _saveAccounts(accounts);
  }

  Future<void> saveSession(String email) =>
      _prefs.setString(PrefsKeys.sessionEmail, _normalize(email));

  String? readSession() => _prefs.getString(PrefsKeys.sessionEmail);

  Future<void> clearSession() => _prefs.remove(PrefsKeys.sessionEmail);

  // ---------------------------------------------------------------------

  static String _normalize(String email) => email.trim().toLowerCase();

  List<Map<String, dynamic>> _readAccounts() {
    final raw = _prefs.getString(PrefsKeys.accounts);
    if (raw == null || raw.isEmpty) return <Map<String, dynamic>>[];
    try {
      final decoded = jsonDecode(raw) as List<dynamic>;
      return decoded
          .whereType<Map<dynamic, dynamic>>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    } on FormatException {
      return <Map<String, dynamic>>[];
    }
  }

  Future<void> _saveAccounts(List<Map<String, dynamic>> accounts) =>
      _prefs.setString(PrefsKeys.accounts, jsonEncode(accounts));
}
