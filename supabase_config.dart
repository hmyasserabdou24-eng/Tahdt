import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'env_config.dart';

/// Manages safe initialization and access to the Supabase client.
class SupabaseConfig {
  const SupabaseConfig._();

  static bool _isInitialized = false;

  static bool get isInitialized => _isInitialized;

  static Future<void> initializeIfConfigured() async {
    if (_isInitialized) {
      return;
    }
    if (!EnvConfig.isSupabaseConfigured) {
      debugPrint(
        '[TADAHHATH AI] Supabase credentials not supplied via --dart-define. '
        'Running with unconfigured backend state until SUPABASE_URL and '
        'SUPABASE_ANON_KEY are provided.',
      );
      return;
    }

    try {
      await Supabase.initialize(
        url: EnvConfig.supabaseUrl,
        anonKey: EnvConfig.supabaseAnonKey,
        authOptions: const FlutterAuthClientOptions(
          authFlowType: AuthFlowType.pkce,
        ),
      );
      _isInitialized = true;
    } catch (error) {
      debugPrint('[TADAHHATH AI] Supabase initialization failed: $error');
      _isInitialized = false;
    }
  }

  static SupabaseClient? get clientOrNull {
    if (!_isInitialized) {
      return null;
    }
    return Supabase.instance.client;
  }
}
