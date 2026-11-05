import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'locale_controller.dart';
import 'cefr_level.dart';
import 'onboarding_preferences.dart';
import 'onboarding_repository.dart';
import 'onboarding_state.dart';

final StateNotifierProvider<OnboardingController, OnboardingState>
    onboardingControllerProvider =
    StateNotifierProvider<OnboardingController, OnboardingState>((Ref ref) {
  final OnboardingRepository repository = ref.watch(onboardingRepositoryProvider);
  final LocaleController localeController = ref.read(localeProvider.notifier);
  return OnboardingController(
    repository: repository,
    localeController: localeController,
  );
});

class OnboardingController extends StateNotifier<OnboardingState> {
  OnboardingController({
    required OnboardingRepository repository,
    required LocaleController localeController,
  })  : _repository = repository,
        _localeController = localeController,
        super(OnboardingState.initial(repository.loadPreferences()));

  final OnboardingRepository _repository;
  final LocaleController _localeController;

  void setStep(int step) {
    if (step < 0 || step >= OnboardingState.totalSteps) {
      return;
    }
    state = state.copyWith(currentStep: step);
  }

  void nextStep() {
    if (state.currentStep < OnboardingState.totalSteps - 1) {
      state = state.copyWith(currentStep: state.currentStep + 1);
    }
  }

  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  Future<void> selectInterfaceLanguage(String languageCode) async {
    final OnboardingPreferences updated = state.preferences.copyWith(
      interfaceLanguageCode: languageCode,
    );
    state = state.copyWith(preferences: updated);
    await _localeController.setLocale(languageCode);
    await _repository.savePreferences(updated);
  }

  Future<void> selectTargetLanguage(String languageCode) async {
    final OnboardingPreferences updated = state.preferences.copyWith(
      targetLanguageCode: languageCode,
    );
    state = state.copyWith(preferences: updated);
    await _repository.savePreferences(updated);
  }

  Future<void> selectEstimatedLevel(CefrLevel level) async {
    final OnboardingPreferences updated = state.preferences.copyWith(
      estimatedLevel: level,
    );
    state = state.copyWith(preferences: updated);
    await _repository.savePreferences(updated);
  }

  Future<void> togglePlacementTest(bool value) async {
    final OnboardingPreferences updated = state.preferences.copyWith(
      wantsPlacementTest: value,
    );
    state = state.copyWith(preferences: updated);
    await _repository.savePreferences(updated);
  }

  Future<void> toggleGoal(String goalId) async {
    final List<String> current = List<String>.from(state.preferences.goalIds);
    if (current.contains(goalId)) {
      if (current.length > 1) {
        current.remove(goalId);
      }
    } else {
      current.add(goalId);
    }
    final OnboardingPreferences updated = state.preferences.copyWith(
      goalIds: current,
    );
    state = state.copyWith(preferences: updated);
    await _repository.savePreferences(updated);
  }

  Future<void> selectDailyDuration(int minutes) async {
    final OnboardingPreferences updated = state.preferences.copyWith(
      dailyMinutesGoal: minutes,
    );
    state = state.copyWith(preferences: updated);
    await _repository.savePreferences(updated);
  }

  Future<void> completeOnboarding() async {
    state = state.copyWith(isSaving: true);
    final OnboardingPreferences completed = state.preferences.copyWith(
      isCompleted: true,
    );
    await _repository.savePreferences(completed);
    state = state.copyWith(preferences: completed, isSaving: false);
  }

  Future<void> reopenOnboarding() async {
    final OnboardingPreferences reopened = state.preferences.copyWith(
      isCompleted: false,
    );
    await _repository.savePreferences(reopened);
    state = state.copyWith(currentStep: 0, preferences: reopened);
  }
}
