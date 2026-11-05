import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding_preferences.dart';

final Provider<SharedPreferences> sharedPreferencesProvider =
    Provider<SharedPreferences>((Ref ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden in ProviderScope at startup.',
  );
});

final Provider<OnboardingRepository> onboardingRepositoryProvider =
    Provider<OnboardingRepository>((Ref ref) {
  final SharedPreferences prefs = ref.watch(sharedPreferencesProvider);
  return OnboardingRepository(prefs);
});

/// Persists onboarding preferences locally so the learner's selections
/// survive restarts and are attached to their profile when registering.
class OnboardingRepository {
  const OnboardingRepository(this._prefs);

  final SharedPreferences _prefs;
  static const String _storageKey = 'tadahhath_onboarding_preferences_v1';

  OnboardingPreferences loadPreferences() {
    final String? raw = _prefs.getString(_storageKey);
    if (raw == null || raw.isEmpty) {
      return OnboardingPreferences.initial();
    }
    try {
      return OnboardingPreferences.fromEncodedJson(raw);
    } catch (_) {
      return OnboardingPreferences.initial();
    }
  }

  Future<void> savePreferences(OnboardingPreferences preferences) async {
    await _prefs.setString(_storageKey, preferences.toEncodedJson());
  }

  Future<void> resetOnboarding() async {
    await _prefs.remove(_storageKey);
  }
}
