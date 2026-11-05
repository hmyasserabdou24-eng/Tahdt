import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

import 'env_config.dart';
import 'supabase_config.dart';
import 'app_exception.dart';
import 'auth_user_model.dart';
import 'onboarding_preferences.dart';

/// Concrete service interacting with Supabase Auth.
///
/// Follows strict honesty rules: never simulates a successful cloud login if
/// Supabase credentials are missing or invalid.
class SupabaseAuthService {
  const SupabaseAuthService();

  SupabaseClient _requireClient() {
    final SupabaseClient? client = SupabaseConfig.clientOrNull;
    if (client == null) {
      throw const AppException(
        code: 'supabase_not_configured',
        isConfigurationMissing: true,
        message:
            'Supabase backend is not configured. Provide SUPABASE_URL and SUPABASE_ANON_KEY via --dart-define.',
      );
    }
    return client;
  }

  AuthUserModel? get currentUser {
    final SupabaseClient? client = SupabaseConfig.clientOrNull;
    final User? user = client?.auth.currentUser;
    if (user == null) {
      return null;
    }
    return _mapUser(user);
  }

  Stream<AuthUserModel?> authStateChanges() {
    final SupabaseClient? client = SupabaseConfig.clientOrNull;
    if (client == null) {
      return const Stream<AuthUserModel?>.empty();
    }
    return client.auth.onAuthStateChange.map((AuthState event) {
      final User? user = event.session?.user;
      return user != null ? _mapUser(user) : null;
    });
  }

  Future<AuthUserModel> signInWithPassword({
    required String email,
    required String password,
  }) async {
    final SupabaseClient client = _requireClient();
    try {
      final AuthResponse response = await client.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );
      final User? user = response.user;
      if (user == null) {
        throw const AppException(
          code: 'auth_empty_user',
          message: 'Authentication failed: no user session returned.',
        );
      }
      return _mapUser(user);
    } on AuthException catch (e) {
      throw AppException(code: e.statusCode ?? 'auth_error', message: e.message);
    } catch (e) {
      if (e is AppException) {
        rethrow;
      }
      throw AppException(
        code: 'network_or_unknown',
        message: 'Unable to sign in right now. Please verify your internet connection. ($e)',
      );
    }
  }

  Future<AuthUserModel> registerWithPassword({
    required String fullName,
    required String email,
    required String password,
    required OnboardingPreferences preferences,
  }) async {
    final SupabaseClient client = _requireClient();
    try {
      final AuthResponse response = await client.auth.signUp(
        email: email.trim(),
        password: password,
        data: <String, dynamic>{
          'full_name': fullName.trim(),
          'interface_language': preferences.interfaceLanguageCode,
          'initial_target_language': preferences.targetLanguageCode,
          'initial_estimated_cefr': preferences.estimatedLevel.code,
          'daily_minutes_goal': preferences.dailyMinutesGoal,
          'learning_goals': preferences.goalIds,
        },
      );
      final User? user = response.user;
      if (user == null) {
        throw const AppException(
          code: 'signup_pending_confirmation',
          message:
              'Registration submitted. Please check your email inbox to confirm your account.',
        );
      }
      return _mapUser(user);
    } on AuthException catch (e) {
      throw AppException(code: e.statusCode ?? 'signup_error', message: e.message);
    }
  }

  Future<void> signInWithGoogleOAuth() async {
    final SupabaseClient client = _requireClient();
    try {
      await client.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: EnvConfig.oauthRedirectUri,
      );
    } on AuthException catch (e) {
      throw AppException(code: e.statusCode ?? 'oauth_error', message: e.message);
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    final SupabaseClient client = _requireClient();
    try {
      await client.auth.resetPasswordForEmail(
        email.trim(),
        redirectTo: EnvConfig.oauthRedirectUri,
      );
    } on AuthException catch (e) {
      throw AppException(code: e.statusCode ?? 'reset_error', message: e.message);
    }
  }

  Future<void> signOut() async {
    final SupabaseClient? client = SupabaseConfig.clientOrNull;
    if (client == null) {
      return;
    }
    await client.auth.signOut();
  }

  AuthUserModel _mapUser(User user) {
    final Map<String, dynamic> meta = user.userMetadata ?? <String, dynamic>{};
    final String name = (meta['full_name'] as String?) ??
        (meta['name'] as String?) ??
        (user.email?.split('@').first ?? 'Learner');
    return AuthUserModel(
      id: user.id,
      email: user.email ?? '',
      fullName: name,
      createdAt: DateTime.tryParse(user.createdAt) ?? DateTime.now(),
      avatarUrl: meta['avatar_url'] as String?,
    );
  }
}
