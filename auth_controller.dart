import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_exception.dart';
import 'auth_user_model.dart';
import 'onboarding_preferences.dart';
import 'auth_repository.dart';
import 'auth_state.dart';

final StateNotifierProvider<AuthController, AuthUiState> authControllerProvider =
    StateNotifierProvider<AuthController, AuthUiState>((Ref ref) {
  final AuthRepository repository = ref.watch(authRepositoryProvider);
  return AuthController(repository);
});

class AuthController extends StateNotifier<AuthUiState> {
  AuthController(this._repository)
      : super(AuthUiState(user: _repository.currentUser)) {
    _init();
  }

  final AuthRepository _repository;
  StreamSubscription<AuthUserModel?>? _authSub;

  Future<void> _init() async {
    final String? savedEmail = await _repository.getLastSavedEmail();
    if (savedEmail != null && mounted) {
      state = state.copyWith(lastEmail: savedEmail);
    }
    _authSub = _repository.watchAuthState().listen((AuthUserModel? user) {
      if (!mounted) {
        return;
      }
      if (user == null) {
        state = state.copyWith(clearUser: true);
      } else {
        state = state.copyWith(user: user, clearError: true);
      }
    });
  }

  void clearMessages() {
    state = state.copyWith(clearError: true, clearInfo: true);
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true, clearInfo: true);
    try {
      final AuthUserModel user = await _repository.signIn(
        email: email,
        password: password,
      );
      state = state.copyWith(user: user, isLoading: false);
      return true;
    } on AppException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
      return false;
    }
  }

  Future<bool> register({
    required String fullName,
    required String email,
    required String password,
    required OnboardingPreferences preferences,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true, clearInfo: true);
    try {
      final AuthUserModel user = await _repository.register(
        fullName: fullName,
        email: email,
        password: password,
        preferences: preferences,
      );
      state = state.copyWith(user: user, isLoading: false);
      return true;
    } on AppException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
      return false;
    }
  }

  Future<void> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, clearError: true, clearInfo: true);
    try {
      await _repository.signInWithGoogle();
      state = state.copyWith(isLoading: false);
    } on AppException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
    }
  }

  Future<bool> sendPasswordReset(String email, {required String successMessage}) async {
    state = state.copyWith(isLoading: true, clearError: true, clearInfo: true);
    try {
      await _repository.requestPasswordReset(email);
      state = state.copyWith(
        isLoading: false,
        infoMessage: successMessage,
      );
      return true;
    } on AppException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
      return false;
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);
    await _repository.signOut();
    state = state.copyWith(isLoading: false, clearUser: true);
  }

  @override
  void dispose() {
    _authSub?.cancel();
    super.dispose();
  }
}
