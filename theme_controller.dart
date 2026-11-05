import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding_repository.dart';

final StateNotifierProvider<ThemeModeController, ThemeMode> themeModeProvider =
    StateNotifierProvider<ThemeModeController, ThemeMode>((Ref ref) {
  final SharedPreferences prefs = ref.watch(sharedPreferencesProvider);
  return ThemeModeController(prefs);
});

class ThemeModeController extends StateNotifier<ThemeMode> {
  ThemeModeController(this._prefs) : super(_loadInitial(_prefs));

  final SharedPreferences _prefs;
  static const String _storageKey = 'tadahhath_theme_mode';

  static ThemeMode _loadInitial(SharedPreferences prefs) {
    final String? raw = prefs.getString(_storageKey);
    switch (raw) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    await _prefs.setString(_storageKey, mode.name);
  }

  Future<void> toggleLightDark() async {
    final ThemeMode next =
        state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(next);
  }
}
