import 'auth_user_model.dart';

class AuthUiState {
  const AuthUiState({
    this.user,
    this.lastEmail,
    this.isLoading = false,
    this.errorMessage,
    this.infoMessage,
  });

  final AuthUserModel? user;
  final String? lastEmail;
  final bool isLoading;
  final String? errorMessage;
  final String? infoMessage;

  AuthUiState copyWith({
    AuthUserModel? user,
    bool clearUser = false,
    String? lastEmail,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
    String? infoMessage,
    bool clearInfo = false,
  }) {
    return AuthUiState(
      user: clearUser ? null : (user ?? this.user),
      lastEmail: lastEmail ?? this.lastEmail,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      infoMessage: clearInfo ? null : (infoMessage ?? this.infoMessage),
    );
  }
}
