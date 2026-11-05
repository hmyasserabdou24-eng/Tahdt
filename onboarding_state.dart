import 'onboarding_preferences.dart';

class OnboardingState {
  const OnboardingState({
    required this.currentStep,
    required this.preferences,
    this.isSaving = false,
  });

  factory OnboardingState.initial(OnboardingPreferences prefs) {
    return OnboardingState(
      currentStep: 0,
      preferences: prefs,
    );
  }

  static const int totalSteps = 5;

  final int currentStep;
  final OnboardingPreferences preferences;
  final bool isSaving;

  OnboardingState copyWith({
    int? currentStep,
    OnboardingPreferences? preferences,
    bool? isSaving,
  }) {
    return OnboardingState(
      currentStep: currentStep ?? this.currentStep,
      preferences: preferences ?? this.preferences,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}
