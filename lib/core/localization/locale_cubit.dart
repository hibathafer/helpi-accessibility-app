import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/prefs_keys.dart';

/// Holds the active locale and persists the user's choice across restarts.
///
/// The UI reacts to this through a `BlocBuilder`, so switching language
/// rebuilds the whole tree — including text direction, which Material derives
/// from the locale.
class LocaleCubit extends Cubit<Locale> {
  LocaleCubit(super.initialLocale);

  static const supportedLocales = <Locale>[Locale('en'), Locale('ar')];

  Future<void> setLanguage(String languageCode) async {
    if (state.languageCode == languageCode) return;
    emit(Locale(languageCode));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(PrefsKeys.locale, languageCode);
  }

  void toggle() {
    setLanguage(state.languageCode == 'ar' ? 'en' : 'ar');
  }
}
