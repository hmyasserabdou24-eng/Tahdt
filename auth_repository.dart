import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_user_model.dart';
import 'onboarding_preferences.dart';
import 'secure_storage_service.dart';
import 'supabase_auth_service.dart';

final Provider<SupabaseAuthService> supabaseAuthServiceProvider =
    Provider<SupabaseAuthService>((Ref ref) {
  return const SupabaseAuthService();
});

final Provider<AuthRepository> authRepositoryProvider =
    Provider<AuthRepository>((Ref ref) {
  return AuthRepository(
    authService: ref.watch(supabaseAuthServiceProvider),
    secureStorage: ref.watch(secureStorageServiceProvider),
  );
});

/// Repository coordinating authentication operations and secure session metadata.
class AuthRepository {
  const AuthRepository({
    required SupabaseAuthService authService,
    required SecureStorageService secureStorage,
  })  : _authService = authService,
        _secureStorage = secureStorage;

  final SupabaseAuthService _authService;
  final SecureStorageService _secureStorage;

  AuthUserModel? get currentUser => _authService.currentUser;

  Stream<AuthUserModel?> watchAuthState() => _authService.authStateChanges();

  Future<String?> getLastSavedEmail() => _secureStorage.readLastActiveEmail();

  Future<AuthUserModel> signIn({
    required String email,
    required String password,
  }) async {
    final AuthUserModel user = await _authService.signInWithPassword(
      email: email,
      password: password,
    );
    await _secureStorage.saveLastActiveEmail(user.email);
    return user;
  }

  Future<AuthUserModel> register({
    required String fullName,
    required String email,
    required String password,
    required OnboardingPreferences preferences,
  }) async {
    final AuthUserModel user = await _authService.registerWithPassword(
      fullName: fullName,
      email: email,
      password: password,
      preferences: preferences,
    );
    await _secureStorage.saveLastActiveEmail(user.email);
    return user;
  }

  Future<void> signInWithGoogle() => _authService.signInWithGoogleOAuth();

  Future<void> requestPasswordReset(String email) =>
      _authService.sendPasswordResetEmail(email);

  Future<void> signOut() async {
    await _authService.signOut();
    await _secureStorage.clearSessionMetadata();
  }
}
