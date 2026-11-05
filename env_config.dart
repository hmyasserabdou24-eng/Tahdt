/// Compile-time environment configuration using `--dart-define`.
///
/// SECURITY RULE:
/// Only public client identifiers (Supabase URL and public anon key) are read here.
/// Private AI keys, speech keys, and service-role credentials must never be
/// compiled into the Flutter client; they are invoked exclusively via
/// authenticated Supabase Edge Functions.
class EnvConfig {
  const EnvConfig._();

  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: '',
  );

  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: '',
  );

  static const String authRedirectScheme = String.fromEnvironment(
    'AUTH_REDIRECT_SCHEME',
    defaultValue: 'io.supabase.tadahhath',
  );

  static String get oauthRedirectUri => '$authRedirectScheme://login-callback/';

  /// Returns true only when both a valid https Supabase URL and non-empty anon key are supplied.
  static bool get isSupabaseConfigured =>
      supabaseUrl.isNotEmpty &&
      supabaseAnonKey.isNotEmpty &&
      supabaseUrl.startsWith('https://') &&
      !supabaseUrl.contains('your-project-ref');
}
