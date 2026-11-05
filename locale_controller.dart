import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding_repository.dart';

final StateNotifierProvider<LocaleController, Locale> localeProvider =
    StateNotifierProvider<LocaleController, Locale>((Ref ref) {
  final SharedPreferences prefs = ref.watch(sharedPreferencesProvider);
  return LocaleController(prefs);
});

class LocaleController extends StateNotifier<Locale> {
  LocaleController(this._prefs) : super(_loadInitial(_prefs));

  final SharedPreferences _prefs;
  static const String _storageKey = 'tadahhath_interface_locale';

  static Locale _loadInitial(SharedPreferences prefs) {
    final String code = prefs.getString(_storageKey) ?? 'en';
    if (<String>['en', 'fr', 'ar'].contains(code)) {
      return Locale(code);
    }
    return const Locale('en');
  }

  Future<void> setLocale(String languageCode) async {
    if (!<String>['en', 'fr', 'ar'].contains(languageCode)) {
      return;
    }
    state = Locale(languageCode);
    await _prefs.setString(_storageKey, languageCode);
  }
}
