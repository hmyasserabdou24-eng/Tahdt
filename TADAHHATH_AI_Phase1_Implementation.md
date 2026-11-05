# TADAHHATH AI — Phase 1 Architecture & Complete Source Code

## 1. Phase 1 File Manifest

| # | File Path | Layer / Responsibility |
| :--- | :--- | :--- |
| 1 | `pubspec.yaml` | Root Config |
| 2 | `analysis_options.yaml` | Root Config |
| 3 | `.env.example` | Root Config |
| 4 | `android/app/src/main/AndroidManifest.xml` | android |
| 5 | `lib/main.dart` | `lib/main.dart` |
| 6 | `lib/config/env_config.dart` | `lib/config` |
| 7 | `lib/config/supabase_config.dart` | `lib/config` |
| 8 | `lib/core/constants/app_colors.dart` | `lib/core` |
| 9 | `lib/core/constants/app_spacing.dart` | `lib/core` |
| 10 | `lib/core/constants/app_typography.dart` | `lib/core` |
| 11 | `lib/core/theme/app_theme.dart` | `lib/core` |
| 12 | `lib/core/theme/theme_controller.dart` | `lib/core` |
| 13 | `lib/core/errors/app_exception.dart` | `lib/core` |
| 14 | `lib/core/utils/validators.dart` | `lib/core` |
| 15 | `lib/models/cefr_level.dart` | `lib/models` |
| 16 | `lib/models/app_language.dart` | `lib/models` |
| 17 | `lib/models/onboarding_preferences.dart` | `lib/models` |
| 18 | `lib/models/auth_user_model.dart` | `lib/models` |
| 19 | `lib/localization/app_localizations.dart` | `lib/localization` |
| 20 | `lib/localization/locale_controller.dart` | `lib/localization` |
| 21 | `lib/services/secure_storage_service.dart` | `lib/services` |
| 22 | `lib/services/supabase_auth_service.dart` | `lib/services` |
| 23 | `lib/repositories/onboarding_repository.dart` | `lib/repositories` |
| 24 | `lib/repositories/auth_repository.dart` | `lib/repositories` |
| 25 | `lib/shared/widgets/tadahhath_logo.dart` | `lib/shared` |
| 26 | `lib/shared/widgets/primary_button.dart` | `lib/shared` |
| 27 | `lib/shared/widgets/app_text_field.dart` | `lib/shared` |
| 28 | `lib/shared/widgets/cefr_disclaimer_banner.dart` | `lib/shared` |
| 29 | `lib/features/splash/presentation/splash_screen.dart` | `lib/features` |
| 30 | `lib/features/onboarding/domain/onboarding_state.dart` | `lib/features` |
| 31 | `lib/features/onboarding/presentation/onboarding_controller.dart` | `lib/features` |
| 32 | `lib/features/onboarding/presentation/onboarding_screen.dart` | `lib/features` |
| 33 | `lib/features/auth/domain/auth_state.dart` | `lib/features` |
| 34 | `lib/features/auth/presentation/auth_controller.dart` | `lib/features` |
| 35 | `lib/features/auth/presentation/login_screen.dart` | `lib/features` |
| 36 | `lib/features/auth/presentation/register_screen.dart` | `lib/features` |
| 37 | `lib/features/auth/presentation/forgot_password_screen.dart` | `lib/features` |
| 38 | `lib/features/home/presentation/home_shell_scaffold.dart` | `lib/features` |
| 39 | `lib/app/router.dart` | `lib/app` |
| 40 | `lib/app/app.dart` | `lib/app` |
| 41 | `test/phase1_unit_test.dart` | test |
| 27 | `assets/images/logo_primary.png` | Cropped Primary Brand Logo (1610x380 PNG) |
| 28 | `assets/images/app_icon.png` | Cropped App Icon Crest (450x450 PNG) |
| 29 | `assets/images/logo_monochrome.png` | Cropped Monochrome Brand Logo (1610x390 PNG) |
| 30 | `TEST_REPORT.md` | Phase 1 Verification & Quality Control Report |

## 2. Installation & Local Setup Guide

1. Extract `TADAHHATH_AI_Phase1_Project.zip` or copy the files below into a Flutter project directory named `tadahhath_ai`.
2. If generating platform runners (`android/`, `ios/`) for the first time, run `flutter create --org com.tadahhath --project-name tadahhath_ai .` inside the folder (preserving the custom `lib/`, `pubspec.yaml`, and `android/app/src/main/AndroidManifest.xml`).
3. Fetch packages and run static analysis and unit tests:
   ```bash
   flutter pub get
   flutter analyze
   flutter test test/phase1_unit_test.dart
   ```
4. Run the application with your Supabase project credentials:
   ```bash
   flutter run \
     --dart-define=SUPABASE_URL=https://your-project-ref.supabase.co \
     --dart-define=SUPABASE_ANON_KEY=your-public-anon-key
   ```

## 3. Complete Phase 1 Source Code

### `pubspec.yaml`

```yaml
name: tadahhath_ai
description: TADAHHATH AI — Global AI Language Learning Platform (Android & Cross-Platform).
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: '>=3.3.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  intl: ^0.19.0
  flutter_riverpod: ^2.5.1
  go_router: ^14.2.0
  supabase_flutter: ^2.5.6
  flutter_secure_storage: ^9.2.2
  shared_preferences: ^2.2.3
  google_fonts: ^6.2.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^4.0.0

flutter:
  uses-material-design: true
  assets:
    - assets/images/logo_primary.png
    - assets/images/app_icon.png
    - assets/images/logo_monochrome.png
```

### `analysis_options.yaml`

```yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  errors:
    missing_required_param: error
    missing_return: error
    todo: ignore
  language:
    strict-casts: true
    strict-inference: true
    strict-raw-types: true

linter:
  rules:
    - always_declare_return_types
    - cancel_subscriptions
    - close_sinks
    - prefer_const_constructors
    - prefer_const_declarations
    - prefer_final_fields
    - prefer_final_locals
    - unawaited_futures
    - use_key_in_widget_constructors
```

### `.env.example`

```bash
# ============================================================================
# TADAHHATH AI — ENVIRONMENT CONFIGURATION TEMPLATE (NO SECRETS)
# ============================================================================
# Pass public client values at build/run time using --dart-define:
#
# flutter run \
#   --dart-define=SUPABASE_URL=https://your-project-ref.supabase.co \
#   --dart-define=SUPABASE_ANON_KEY=your-public-anon-key \
#   --dart-define=AUTH_REDIRECT_SCHEME=io.supabase.tadahhath
#
# SECURITY POLICY:
# NEVER place SUPABASE_SERVICE_ROLE_KEY, OPENAI_API_KEY, ANTHROPIC_API_KEY,
# GEMINI_API_KEY, or speech provider private keys in the Flutter client.
# Store all sensitive AI and billing keys strictly in Supabase Edge Function
# secrets via: `supabase secrets set OPENAI_API_KEY=...`
# ============================================================================

SUPABASE_URL=https://your-project-ref.supabase.co
SUPABASE_ANON_KEY=your-public-anon-key-here
AUTH_REDIRECT_SCHEME=io.supabase.tadahhath
```

### `android/app/src/main/AndroidManifest.xml`

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.tadahhath.ai">

    <!-- Network connectivity for Supabase Auth, Database & Edge Functions -->
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

    <!-- Explicit microphone permission for AI Speaking Tutor & Pronunciation Coach (Phase 5) -->
    <uses-permission android:name="android.permission.RECORD_AUDIO" />

    <application
        android:label="TADAHHATH AI"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
        android:enableOnBackInvokedCallback="true"
        android:supportsRtl="true">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme" />
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>

            <!-- Deep link intent filter for Supabase OAuth & Password Recovery callbacks -->
            <intent-filter>
                <action android:name="android.intent.action.VIEW" />
                <category android:name="android.intent.category.DEFAULT" />
                <category android:name="android.intent.category.BROWSABLE" />
                <data
                    android:scheme="io.supabase.tadahhath"
                    android:host="login-callback" />
            </intent-filter>
        </activity>
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
</manifest>
```

### `lib/main.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'config/supabase_config.dart';
import 'repositories/onboarding_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  await SupabaseConfig.initializeIfConfigured();

  runApp(
    ProviderScope(
      overrides: <Override>[
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const TadahhathApp(),
    ),
  );
}
```

### `lib/config/env_config.dart`

```dart
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
```

### `lib/config/supabase_config.dart`

```dart
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
```

### `lib/core/constants/app_colors.dart`

```dart
import 'package:flutter/material.dart';

/// Official brand color tokens for TADAHHATH AI.
class AppColors {
  const AppColors._();

  // Core Brand Palette (from specification & brand sheet)
  static const Color primaryNavy = Color(0xFF172B4D);
  static const Color secondaryBlue = Color(0xFF315B91);
  static const Color accentGold = Color(0xFFD7AD61);
  static const Color backgroundLight = Color(0xFFF7F8FC);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF101827);

  // Extended Dark Surfaces & Neutrals
  static const Color surfaceDark = Color(0xFF1A2438);
  static const Color cardDark = Color(0xFF212E46);
  static const Color textPrimaryLight = Color(0xFF172B4D);
  static const Color textSecondaryLight = Color(0xFF52627C);
  static const Color textPrimaryDark = Color(0xFFF3F6FC);
  static const Color textSecondaryDark = Color(0xFFA8B5C9);
  static const Color borderLight = Color(0xFFE1E6F0);
  static const Color borderDark = Color(0xFF2E3D59);

  // Semantic Status Tokens
  static const Color success = Color(0xFF1F8A5B);
  static const Color warning = Color(0xFFD9822B);
  static const Color error = Color(0xFFC9372C);
  static const Color info = Color(0xFF266DD3);
}
```

### `lib/core/constants/app_spacing.dart`

```dart
/// Consistent 4pt/8pt spatial grid tokens and border radii across the app.
class AppSpacing {
  const AppSpacing._();

  static const double xxs = 4.0;
  static const double xs = 8.0;
  static const double sm = 12.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  static const double radiusSm = 10.0;
  static const double radiusMd = 16.0;
  static const double radiusLg = 22.0;
  static const double radiusPill = 999.0;
}
```

### `lib/core/constants/app_typography.dart`

```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Builds accessible, high-readability typography supporting Latin (EN/FR)
/// and Arabic (AR) scripts cleanly.
class AppTypography {
  const AppTypography._();

  static TextTheme buildTextTheme(Color primaryTextColor, Color secondaryTextColor, {required bool isArabic}) {
    final TextTheme base = isArabic
        ? GoogleFonts.cairoTextTheme()
        : GoogleFonts.plusJakartaSansTextTheme();

    return base.copyWith(
      displaySmall: base.displaySmall?.copyWith(
        fontSize: 30,
        fontWeight: FontWeight.w800,
        color: primaryTextColor,
        height: 1.25,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: primaryTextColor,
        height: 1.3,
      ),
      titleLarge: base.titleLarge?.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: primaryTextColor,
        height: 1.35,
      ),
      titleMedium: base.titleMedium?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        height: 1.4,
      ),
      bodyLarge: base.bodyLarge?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: primaryTextColor,
        height: 1.5,
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: secondaryTextColor,
        height: 1.5,
      ),
      labelLarge: base.labelLarge?.copyWith(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
        letterSpacing: 0.2,
      ),
    );
  }
}
```

### `lib/core/theme/app_theme.dart`

```dart
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_typography.dart';

/// Material 3 Light and Dark theme definitions for TADAHHATH AI.
class AppTheme {
  const AppTheme._();

  static ThemeData light({required bool isArabic}) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primaryNavy,
      brightness: Brightness.light,
      primary: AppColors.primaryNavy,
      onPrimary: Colors.white,
      secondary: AppColors.secondaryBlue,
      onSecondary: Colors.white,
      tertiary: AppColors.accentGold,
      onTertiary: AppColors.primaryNavy,
      surface: AppColors.surfaceLight,
      onSurface: AppColors.textPrimaryLight,
      error: AppColors.error,
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      textTheme: AppTypography.buildTextTheme(
        AppColors.textPrimaryLight,
        AppColors.textSecondaryLight,
        isArabic: isArabic,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundLight,
        foregroundColor: AppColors.primaryNavy,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceLight,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          side: const BorderSide(color: AppColors.borderLight, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceLight,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: AppColors.secondaryBlue, width: 1.8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: AppColors.error),
        ),
      ),
    );
  }

  static ThemeData dark({required bool isArabic}) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.secondaryBlue,
      brightness: Brightness.dark,
      primary: AppColors.accentGold,
      onPrimary: AppColors.primaryNavy,
      secondary: AppColors.secondaryBlue,
      onSecondary: Colors.white,
      tertiary: AppColors.accentGold,
      onTertiary: AppColors.primaryNavy,
      surface: AppColors.surfaceDark,
      onSurface: AppColors.textPrimaryDark,
      error: AppColors.error,
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      textTheme: AppTypography.buildTextTheme(
        AppColors.textPrimaryDark,
        AppColors.textSecondaryDark,
        isArabic: isArabic,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.backgroundDark,
        foregroundColor: AppColors.textPrimaryDark,
        elevation: 0,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceDark,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          side: const BorderSide(color: AppColors.borderDark, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cardDark,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: AppColors.accentGold, width: 1.8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          borderSide: const BorderSide(color: AppColors.error),
        ),
      ),
    );
  }
}
```

### `lib/core/theme/theme_controller.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repositories/onboarding_repository.dart';

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
```

### `lib/core/errors/app_exception.dart`

```dart
/// Standardized application exception with user-safe messages and error codes.
class AppException implements Exception {
  const AppException({
    required this.message,
    this.code = 'unknown_error',
    this.isConfigurationMissing = false,
  });

  final String message;
  final String code;
  final bool isConfigurationMissing;

  @override
  String toString() => 'AppException($code): $message';
}
```

### `lib/core/utils/validators.dart`

```dart
/// Form and input validation utilities for authentication and profile inputs.
class Validators {
  const Validators._();

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static String? validateEmail(String? value, {required String requiredMsg, required String invalidMsg}) {
    final String trimmed = (value ?? '').trim();
    if (trimmed.isEmpty) {
      return requiredMsg;
    }
    if (!_emailRegex.hasMatch(trimmed)) {
      return invalidMsg;
    }
    return null;
  }

  static String? validatePassword(
    String? value, {
    required String requiredMsg,
    required String tooShortMsg,
    required String complexityMsg,
  }) {
    final String raw = value ?? '';
    if (raw.isEmpty) {
      return requiredMsg;
    }
    if (raw.length < 8) {
      return tooShortMsg;
    }
    final bool hasLetter = RegExp(r'[A-Za-z]').hasMatch(raw);
    final bool hasDigit = RegExp(r'[0-9]').hasMatch(raw);
    if (!hasLetter || !hasDigit) {
      return complexityMsg;
    }
    return null;
  }

  static String? validateFullName(String? value, {required String requiredMsg}) {
    final String trimmed = (value ?? '').trim();
    if (trimmed.length < 2) {
      return requiredMsg;
    }
    return null;
  }
}
```

### `lib/models/cefr_level.dart`

```dart
/// Supported Common European Framework of Reference for Languages (CEFR) levels.
///
/// NOTE: Internal estimates inside TADAHHATH AI guide personalized lesson
/// selection and do not represent official accredited language certificates.
enum CefrLevel {
  a1(
    code: 'A1',
    titleEn: 'Beginner',
    titleFr: 'Débutant',
    titleAr: 'مبتدئ',
    descriptionEn: 'Understand and use familiar everyday expressions and basic phrases.',
    descriptionFr: 'Comprendre et utiliser des expressions familières et quotidiennes.',
    descriptionAr: 'فهم واستخدام التعبيرات اليومية المألوفة والعبارات الأساسية.',
  ),
  a2(
    code: 'A2',
    titleEn: 'Elementary',
    titleFr: 'Élémentaire',
    titleAr: 'أساسي',
    descriptionEn: 'Communicate in routine tasks requiring a simple exchange of information.',
    descriptionFr: 'Communiquer lors de tâches simples et habituelles.',
    descriptionAr: 'التواصل في المهام الروتينية التي تتطلب تبادلاً بسيطاً للمعلومات.',
  ),
  b1(
    code: 'B1',
    titleEn: 'Intermediate',
    titleFr: 'Intermédiaire',
    titleAr: 'متوسط',
    descriptionEn: 'Deal with most situations likely to arise whilst travelling or working.',
    descriptionFr: 'Faire face à la majorité des situations rencontrées en voyage ou au travail.',
    descriptionAr: 'التعامل مع معظم المواقف أثناء السفر أو العمل أو الدراسة.',
  ),
  b2(
    code: 'B2',
    titleEn: 'Upper Intermediate',
    titleFr: 'Intermédiaire Avancé',
    titleAr: 'فوق المتوسط',
    descriptionEn: 'Interact with a degree of fluency and spontaneity with native speakers.',
    descriptionFr: 'Communiquer avec un degré de spontanéité et d'aisance avec un locuteur natif.',
    descriptionAr: 'التفاعل بطلاقة وتلقائية مع الناطقين الأصليين للغة.',
  ),
  c1(
    code: 'C1',
    titleEn: 'Advanced',
    titleFr: 'Avancé',
    titleAr: 'متقدم',
    descriptionEn: 'Express ideas fluently and spontaneously for social, academic, and professional purposes.',
    descriptionFr: 'S'exprimer spontanément et couramment à des fins sociales, académiques et professionnelles.',
    descriptionAr: 'التعبير عن الأفكار بطلاقة في الأوساط الاجتماعية والأكاديمية والمهنية.',
  ),
  c2(
    code: 'C2',
    titleEn: 'Mastery',
    titleFr: 'Maîtrise',
    titleAr: 'إتقان',
    descriptionEn: 'Understand with ease virtually everything heard or read and summarize complex arguments.',
    descriptionFr: 'Comprendre sans effort pratiquement tout ce qui est lu ou entendu.',
    descriptionAr: 'فهم كل ما يُسمع أو يُقرأ بسهولة وتلخيص الحجج المعقدة بدقة.',
  );

  const CefrLevel({
    required this.code,
    required this.titleEn,
    required this.titleFr,
    required this.titleAr,
    required this.descriptionEn,
    required this.descriptionFr,
    required this.descriptionAr,
  });

  final String code;
  final String titleEn;
  final String titleFr;
  final String titleAr;
  final String descriptionEn;
  final String descriptionFr;
  final String descriptionAr;

  String localizedTitle(String localeCode) {
    switch (localeCode) {
      case 'fr':
        return titleFr;
      case 'ar':
        return titleAr;
      default:
        return titleEn;
    }
  }

  String localizedDescription(String localeCode) {
    switch (localeCode) {
      case 'fr':
        return descriptionFr;
      case 'ar':
        return descriptionAr;
      default:
        return descriptionEn;
    }
  }

  static CefrLevel fromCode(String? code) {
    for (final CefrLevel level in CefrLevel.values) {
      if (level.code.toUpperCase() == (code ?? '').toUpperCase()) {
        return level;
      }
    }
    return CefrLevel.a1;
  }
}
```

### `lib/models/app_language.dart`

```dart
/// Extensible model representing an interface or target learning language.
///
/// New languages can be added dynamically via database records in
/// `supported_languages` or appended to [SupportedLanguageCatalog.initialLanguages]
/// without refactoring screens.
class AppLanguage {
  const AppLanguage({
    required this.isoCode,
    required this.nativeName,
    required this.nameEn,
    required this.nameFr,
    required this.nameAr,
    required this.isRtl,
    required this.scriptBadge,
    this.isEnabledForInterface = true,
    this.isEnabledForLearning = true,
  });

  final String isoCode;
  final String nativeName;
  final String nameEn;
  final String nameFr;
  final String nameAr;
  final bool isRtl;
  final String scriptBadge;
  final bool isEnabledForInterface;
  final bool isEnabledForLearning;

  String localizedName(String uiLocaleCode) {
    switch (uiLocaleCode) {
      case 'fr':
        return nameFr;
      case 'ar':
        return nameAr;
      default:
        return nameEn;
    }
  }
}

class SupportedLanguageCatalog {
  const SupportedLanguageCatalog._();

  static const List<AppLanguage> initialLanguages = <AppLanguage>[
    AppLanguage(
      isoCode: 'en',
      nativeName: 'English',
      nameEn: 'English',
      nameFr: 'Anglais',
      nameAr: 'الإنجليزية',
      isRtl: false,
      scriptBadge: 'EN',
    ),
    AppLanguage(
      isoCode: 'fr',
      nativeName: 'Français',
      nameEn: 'French',
      nameFr: 'Français',
      nameAr: 'الفرنسية',
      isRtl: false,
      scriptBadge: 'FR',
    ),
    AppLanguage(
      isoCode: 'ar',
      nativeName: 'العربية',
      nameEn: 'Arabic',
      nameFr: 'Arabe',
      nameAr: 'العربية',
      isRtl: true,
      scriptBadge: 'ض',
    ),
  ];

  static AppLanguage byCode(String code) {
    for (final AppLanguage lang in initialLanguages) {
      if (lang.isoCode == code) {
        return lang;
      }
    }
    return initialLanguages.first;
  }
}
```

### `lib/models/onboarding_preferences.dart`

```dart
import 'dart:convert';

import 'cefr_level.dart';

/// Learning goal categories selectable during onboarding and language management.
enum LearningGoalCategory {
  conversation('conversation', 'Everyday Conversation', 'Conversation quotidienne', 'المحادثة اليومية'),
  career('career', 'Career & Business', 'Carrière et affaires', 'العمل والمهنة'),
  travel('travel', 'Travel & Culture', 'Voyage et culture', 'السفر والثقافة'),
  academic('academic', 'Academic & Exams', 'Études et examens', 'الدراسة والامتحانات'),
  pronunciation('pronunciation', 'Pronunciation Mastery', 'Maîtrise de la prononciation', 'إتقان النطق');

  const LearningGoalCategory(this.id, this.labelEn, this.labelFr, this.labelAr);

  final String id;
  final String labelEn;
  final String labelFr;
  final String labelAr;

  String localizedLabel(String localeCode) {
    switch (localeCode) {
      case 'fr':
        return labelFr;
      case 'ar':
        return labelAr;
      default:
        return labelEn;
    }
  }

  static LearningGoalCategory fromId(String id) {
    for (final LearningGoalCategory item in LearningGoalCategory.values) {
      if (item.id == id) {
        return item;
      }
    }
    return LearningGoalCategory.conversation;
  }
}

/// Immutable user onboarding selections persisted locally and synced to Supabase upon registration.
class OnboardingPreferences {
  const OnboardingPreferences({
    required this.interfaceLanguageCode,
    required this.targetLanguageCode,
    required this.estimatedLevel,
    required this.goalIds,
    required this.dailyMinutesGoal,
    required this.wantsPlacementTest,
    required this.isCompleted,
  });

  factory OnboardingPreferences.initial() {
    return const OnboardingPreferences(
      interfaceLanguageCode: 'en',
      targetLanguageCode: 'fr',
      estimatedLevel: CefrLevel.a1,
      goalIds: <String>['conversation', 'career'],
      dailyMinutesGoal: 15,
      wantsPlacementTest: true,
      isCompleted: false,
    );
  }

  factory OnboardingPreferences.fromJson(Map<String, dynamic> json) {
    final List<dynamic> rawGoals = (json['goalIds'] as List<dynamic>?) ?? <dynamic>['conversation'];
    return OnboardingPreferences(
      interfaceLanguageCode: (json['interfaceLanguageCode'] as String?) ?? 'en',
      targetLanguageCode: (json['targetLanguageCode'] as String?) ?? 'fr',
      estimatedLevel: CefrLevel.fromCode(json['estimatedLevel'] as String?),
      goalIds: rawGoals.map((dynamic e) => e.toString()).toList(),
      dailyMinutesGoal: (json['dailyMinutesGoal'] as int?) ?? 15,
      wantsPlacementTest: (json['wantsPlacementTest'] as bool?) ?? true,
      isCompleted: (json['isCompleted'] as bool?) ?? false,
    );
  }

  final String interfaceLanguageCode;
  final String targetLanguageCode;
  final CefrLevel estimatedLevel;
  final List<String> goalIds;
  final int dailyMinutesGoal;
  final bool wantsPlacementTest;
  final bool isCompleted;

  OnboardingPreferences copyWith({
    String? interfaceLanguageCode,
    String? targetLanguageCode,
    CefrLevel? estimatedLevel,
    List<String>? goalIds,
    int? dailyMinutesGoal,
    bool? wantsPlacementTest,
    bool? isCompleted,
  }) {
    return OnboardingPreferences(
      interfaceLanguageCode: interfaceLanguageCode ?? this.interfaceLanguageCode,
      targetLanguageCode: targetLanguageCode ?? this.targetLanguageCode,
      estimatedLevel: estimatedLevel ?? this.estimatedLevel,
      goalIds: goalIds ?? this.goalIds,
      dailyMinutesGoal: dailyMinutesGoal ?? this.dailyMinutesGoal,
      wantsPlacementTest: wantsPlacementTest ?? this.wantsPlacementTest,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'interfaceLanguageCode': interfaceLanguageCode,
      'targetLanguageCode': targetLanguageCode,
      'estimatedLevel': estimatedLevel.code,
      'goalIds': goalIds,
      'dailyMinutesGoal': dailyMinutesGoal,
      'wantsPlacementTest': wantsPlacementTest,
      'isCompleted': isCompleted,
    };
  }

  String toEncodedJson() => jsonEncode(toJson());

  static OnboardingPreferences fromEncodedJson(String raw) {
    final Map<String, dynamic> decoded = jsonDecode(raw) as Map<String, dynamic>;
    return OnboardingPreferences.fromJson(decoded);
  }
}
```

### `lib/models/auth_user_model.dart`

```dart
/// Domain representation of an authenticated TADAHHATH AI learner.
class AuthUserModel {
  const AuthUserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.createdAt,
    this.avatarUrl,
  });

  final String id;
  final String email;
  final String fullName;
  final DateTime createdAt;
  final String? avatarUrl;
}
```

### `lib/localization/app_localizations.dart`

```dart
import 'package:flutter/material.dart';

/// Multi-language localization dictionary supporting English (LTR),
/// French (LTR), and Arabic (RTL).
class AppLocalizations {
  const AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        const AppLocalizations(Locale('en'));
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
    Locale('ar'),
  ];

  bool get isRtl => locale.languageCode == 'ar';

  static final Map<String, Map<String, String>> _localizedValues =
      <String, Map<String, String>>{
    'en': <String, String>{
      'app_name': 'TADAHHATH AI',
      'tagline': 'Intelligent Global Language Mastery',
      'cefr_disclaimer':
          'Note: CEFR levels (A1–C2) estimated inside TADAHHATH AI are for personalized study routing only and are not official language certificates.',
      'onboarding_step_1_title': 'Learn Naturally with AI Guidance',
      'onboarding_step_1_subtitle':
          'Practice real-world speaking, adaptive grammar, vocabulary, listening, and writing with structured feedback.',
      'select_interface_language': 'Interface Language',
      'select_learning_language': 'Which language do you want to learn first?',
      'select_learning_language_sub':
          'You can add more languages and maintain separate progress at any time.',
      'select_current_level': 'What is your current level?',
      'recommend_placement_toggle': 'Take adaptive placement test after signup',
      'select_goals_title': 'What are your primary learning goals?',
      'select_goals_subtitle': 'Select one or more focus areas to tailor your study plan.',
      'select_duration_title': 'Set your daily study commitment',
      'select_duration_subtitle': 'Consistent daily practice builds lasting fluency.',
      'minutes_per_day': 'min / day',
      'continue_btn': 'Continue',
      'back_btn': 'Back',
      'get_started_btn': 'Continue to Account Setup',
      'login_title': 'Welcome Back',
      'login_subtitle': 'Sign in to sync your learning progress across devices.',
      'register_title': 'Create Your Learner Account',
      'register_subtitle': 'Start your personalized language path with TADAHHATH AI.',
      'forgot_password_title': 'Password Recovery',
      'forgot_password_subtitle':
          'Enter your account email and we will send a secure password reset link.',
      'email_label': 'Email Address',
      'password_label': 'Password',
      'confirm_password_label': 'Confirm Password',
      'full_name_label': 'Full Name',
      'sign_in_btn': 'Sign In',
      'sign_up_btn': 'Create Account',
      'google_auth_btn': 'Continue with Google',
      'send_reset_link_btn': 'Send Recovery Link',
      'forgot_password_link': 'Forgot password?',
      'no_account_prompt': 'New to TADAHHATH AI? Create an account',
      'have_account_prompt': 'Already have an account? Sign in',
      'logout_btn': 'Sign Out',
      'supabase_not_configured_banner':
          'Backend Configuration Notice: SUPABASE_URL and SUPABASE_ANON_KEY are not yet provided via --dart-define. Live Supabase authentication requires configuring your project credentials.',
      'field_required': 'This field is required.',
      'invalid_email': 'Please enter a valid email address.',
      'password_too_short': 'Password must be at least 8 characters.',
      'password_complexity': 'Include at least one letter and one number.',
      'passwords_do_not_match': 'Passwords do not match.',
      'reset_email_sent':
          'If an account exists for that email, a password reset link has been dispatched.',
      'home_phase1_ready': 'Phase 1 Foundation Active',
      'home_phase1_desc':
          'Your onboarding profile, localization engine, and authentication shell are active. Phase 2 and Phase 3 connect full Supabase persistence and learning modules.',
      'reconfigure_onboarding': 'Review Onboarding Preferences',
    },
    'fr': <String, String>{
      'app_name': 'TADAHHATH AI',
      'tagline': 'Maîtrise linguistique intelligente par l'IA',
      'cefr_disclaimer':
          'Remarque : Les niveaux CECRL (A1–C2) estimés dans TADAHHATH AI servent uniquement à personnaliser votre parcours et ne constituent pas des certificats officiels.',
      'onboarding_step_1_title': 'Apprenez naturellement avec l'IA',
      'onboarding_step_1_subtitle':
          'Pratiquez l'expression orale, la grammaire adaptative, le vocabulaire, l'écoute et l'écriture avec des corrections précises.',
      'select_interface_language': 'Langue de l'interface',
      'select_learning_language': 'Quelle langue souhaitez-vous apprendre ?',
      'select_learning_language_sub':
          'Vous pourrez ajouter d'autres langues avec un suivi séparé à tout moment.',
      'select_current_level': 'Quel est votre niveau actuel ?',
      'recommend_placement_toggle': 'Passer le test de placement adaptatif après l'inscription',
      'select_goals_title': 'Quels sont vos objectifs d'apprentissage ?',
      'select_goals_subtitle': 'Sélectionnez un ou plusieurs domaines pour personnaliser votre plan.',
      'select_duration_title': 'Définissez votre objectif quotidien',
      'select_duration_subtitle': 'La régularité quotidienne est la clé de la fluidité.',
      'minutes_per_day': 'min / jour',
      'continue_btn': 'Continuer',
      'back_btn': 'Retour',
      'get_started_btn': 'Configurer mon compte',
      'login_title': 'Bon retour',
      'login_subtitle': 'Connectez-vous pour synchroniser votre progression.',
      'register_title': 'Créer votre compte apprenant',
      'register_subtitle': 'Commencez votre parcours personnalisé avec TADAHHATH AI.',
      'forgot_password_title': 'Récupération du mot de passe',
      'forgot_password_subtitle':
          'Saisissez votre adresse e-mail pour recevoir un lien sécurisé de réinitialisation.',
      'email_label': 'Adresse e-mail',
      'password_label': 'Mot de passe',
      'confirm_password_label': 'Confirmer le mot de passe',
      'full_name_label': 'Nom complet',
      'sign_in_btn': 'Se connecter',
      'sign_up_btn': 'Créer un compte',
      'google_auth_btn': 'Continuer avec Google',
      'send_reset_link_btn': 'Envoyer le lien',
      'forgot_password_link': 'Mot de passe oublié ?',
      'no_account_prompt': 'Nouveau sur TADAHHATH AI ? Créer un compte',
      'have_account_prompt': 'Déjà inscrit ? Se connecter',
      'logout_btn': 'Se déconnecter',
      'supabase_not_configured_banner':
          'Avis de configuration : SUPABASE_URL et SUPABASE_ANON_KEY ne sont pas encore fournis via --dart-define. L'authentification Supabase en direct nécessite vos identifiants.',
      'field_required': 'Ce champ est obligatoire.',
      'invalid_email': 'Veuillez saisir une adresse e-mail valide.',
      'password_too_short': 'Le mot de passe doit contenir au moins 8 caractères.',
      'password_complexity': 'Incluez au moins une lettre et un chiffre.',
      'passwords_do_not_match': 'Les mots de passe ne correspondent pas.',
      'reset_email_sent':
          'Si un compte correspond à cet e-mail, un lien de réinitialisation a été envoyé.',
      'home_phase1_ready': 'Fondation Phase 1 Active',
      'home_phase1_desc':
          'Votre profil d'intégration, le moteur multilingue et l'architecture d'authentification sont actifs.',
      'reconfigure_onboarding': 'Modifier les préférences d'intégration',
    },
    'ar': <String, String>{
      'app_name': 'تحدث AI',
      'tagline': 'منصة ذكية عالمية لإتقان اللغات',
      'cefr_disclaimer':
          'ملاحظة: مستويات الإطار الأوروبي المرجعي (A1–C2) المقدرة داخل التطبيق مخصصة لتوجيه خطة التعلم الشخصية فقط وليست شهادات لغة رسمية معتمدة.',
      'onboarding_step_1_title': 'تعلّم اللغات بطلاقة بدعم الذكاء الاصطناعي',
      'onboarding_step_1_subtitle':
          'تدرّب على المحادثة الصوتية، القواعد التفاعلية، المفردات، الاستماع، والكتابة مع تصحيح فوري دقيق.',
      'select_interface_language': 'لغة واجهة التطبيق',
      'select_learning_language': 'ما اللغة التي ترغب في تعلمها أولاً؟',
      'select_learning_language_sub':
          'يمكنك إضافة لغات أخرى والاحتفاظ بتقدم مستقل لكل لغة في أي وقت.',
      'select_current_level': 'ما هو مستواك الحالي في هذه اللغة؟',
      'recommend_placement_toggle': 'إجراء اختبار تحديد المستوى التكيفي بعد التسجيل',
      'select_goals_title': 'ما هي أهدافك الأساسية من التعلم؟',
      'select_goals_subtitle': 'اختر هدفاً أو أكثر لتخصيص خطتك الدراسية.',
      'select_duration_title': 'حدد مدة التعلم اليومية',
      'select_duration_subtitle': 'الممارسة اليومية المنتظمة تبني الطلاقة الحقيقية.',
      'minutes_per_day': 'دقيقة / يومياً',
      'continue_btn': 'متابعة',
      'back_btn': 'رجوع',
      'get_started_btn': 'المتابعة لإعداد الحساب',
      'login_title': 'مرحباً بعودتك',
      'login_subtitle': 'سجّل الدخول لمزامنة تقدمك الدراسي عبر أجهزتك.',
      'register_title': 'إنشاء حساب متعلم جديد',
      'register_subtitle': 'ابدأ مسارك التعليمي المخصص مع TADAHHATH AI.',
      'forgot_password_title': 'استعادة كلمة المرور',
      'forgot_password_subtitle':
          'أدخل بريدك الإلكتروني وسنرسل لك رابطاً آمناً لإعادة تعيين كلمة المرور.',
      'email_label': 'البريد الإلكتروني',
      'password_label': 'كلمة المرور',
      'confirm_password_label': 'تأكيد كلمة المرور',
      'full_name_label': 'الاسم الكامل',
      'sign_in_btn': 'تسجيل الدخول',
      'sign_up_btn': 'إنشاء الحساب',
      'google_auth_btn': 'المتابعة باستخدام Google',
      'send_reset_link_btn': 'إرسال رابط الاستعادة',
      'forgot_password_link': 'نسيت كلمة المرور؟',
      'no_account_prompt': 'جديد في TADAHHATH AI؟ أنشئ حساباً',
      'have_account_prompt': 'لديك حساب بالفعل؟ سجّل الدخول',
      'logout_btn': 'تسجيل الخروج',
      'supabase_not_configured_banner':
          'تنبيه الإعدادات: لم يتم تمرير SUPABASE_URL و SUPABASE_ANON_KEY عبر --dart-define بعد. يتطلب الاتصال الفعلي بقاعدة البيانات ضبط إعدادات مشروع Supabase.',
      'field_required': 'هذا الحقل مطلوب.',
      'invalid_email': 'يرجى إدخال بريد إلكتروني صحيح.',
      'password_too_short': 'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل.',
      'password_complexity': 'يجب أن تحتوي كلمة المرور على حرف ورقم واحد على الأقل.',
      'passwords_do_not_match': 'كلمتا المرور غير متطابقتين.',
      'reset_email_sent':
          'إذا كان البريد مسجلاً لدينا، فقد تم إرسال رابط استعادة كلمة المرور.',
      'home_phase1_ready': 'البنية الأساسية للمرحلة الأولى جاهزة',
      'home_phase1_desc':
          'تم تفعيل إعدادات التعلم واللغات (بما في ذلك دعم العربية RTL) وواجهة المصادقة الآمنة.',
      'reconfigure_onboarding': 'مراجعة تفضيلات التعلم',
    },
  };

  String tr(String key) {
    final Map<String, String>? dict = _localizedValues[locale.languageCode];
    return dict?[key] ?? _localizedValues['en']![key] ?? key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return <String>['en', 'fr', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
```

### `lib/localization/locale_controller.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repositories/onboarding_repository.dart';

final StateNotifierProvider<LocaleController, Locale> localeProvider =
    StateNotifierProvider<LocaleController, Locale>((Ref ref) {
  final SharedPreferences prefs = ref.watch(sharedPreferencesProvider);
  return LocaleController(prefs);
});

class LocaleController extends StateNotifier<Locale> {
  LocaleController(this._prefs) : super(_loadInitial(_prefs));

  final SharedPreferences _prefs;
  static const String _storageKey = 'tadahhath_interface_locale';

  static Locale _loadInitial(SharedPreferences prefs) {
    final String code = prefs.getString(_storageKey) ?? 'en';
    if (<String>['en', 'fr', 'ar'].contains(code)) {
      return Locale(code);
    }
    return const Locale('en');
  }

  Future<void> setLocale(String languageCode) async {
    if (!<String>['en', 'fr', 'ar'].contains(languageCode)) {
      return;
    }
    state = Locale(languageCode);
    await _prefs.setString(_storageKey, languageCode);
  }
}
```

### `lib/services/secure_storage_service.dart`

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final Provider<SecureStorageService> secureStorageServiceProvider =
    Provider<SecureStorageService>((Ref ref) {
  return const SecureStorageService(
    FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    ),
  );
});

/// Encrypted key-value storage wrapper for sensitive local session metadata.
class SecureStorageService {
  const SecureStorageService(this._storage);

  final FlutterSecureStorage _storage;

  static const String _keyLastActiveEmail = 'tadahhath_last_active_email';

  Future<void> saveLastActiveEmail(String email) async {
    await _storage.write(key: _keyLastActiveEmail, value: email);
  }

  Future<String?> readLastActiveEmail() async {
    return _storage.read(key: _keyLastActiveEmail);
  }

  Future<void> clearSessionMetadata() async {
    await _storage.delete(key: _keyLastActiveEmail);
  }
}
```

### `lib/services/supabase_auth_service.dart`

```dart
import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../config/env_config.dart';
import '../config/supabase_config.dart';
import '../core/errors/app_exception.dart';
import '../models/auth_user_model.dart';
import '../models/onboarding_preferences.dart';

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
```

### `lib/repositories/onboarding_repository.dart`

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/onboarding_preferences.dart';

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
```

### `lib/repositories/auth_repository.dart`

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/auth_user_model.dart';
import '../models/onboarding_preferences.dart';
import '../services/secure_storage_service.dart';
import '../services/supabase_auth_service.dart';

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
```

### `lib/shared/widgets/tadahhath_logo.dart`

```dart
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

/// Renders the official TADAHHATH AI brand mark and wordmark.
///
/// Supports both the high-resolution extracted brand sheet asset (`app_icon.png`)
/// and a precision vector CustomPainter fallback matching the speech-bubble
/// neural circuit crest and split 'T' emblem.
class TadahhathLogo extends StatelessWidget {
  const TadahhathLogo({
    super.key,
    this.size = 72,
    this.showWordmark = true,
    this.isMonochrome = false,
  });

  final double size;
  final bool showWordmark;
  final bool isMonochrome;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color wordmarkPrimary = isMonochrome
        ? (isDark ? Colors.white : AppColors.primaryNavy)
        : (isDark ? Colors.white : AppColors.primaryNavy);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: AppColors.primaryNavy,
            borderRadius: BorderRadius.circular(size * 0.24),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColors.primaryNavy.withOpacity(0.22),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            'assets/images/app_icon.png',
            fit: BoxFit.cover,
            errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
              return CustomPaint(
                size: Size.square(size),
                painter: _TadahhathEmblemPainter(isMonochrome: isMonochrome),
              );
            },
          ),
        ),
        if (showWordmark) ...<Widget>[
          const SizedBox(height: 14),
          RichText(
            textDirection: TextDirection.ltr,
            text: TextSpan(
              style: TextStyle(
                fontSize: size * 0.34,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.4,
                color: wordmarkPrimary,
              ),
              children: const <InlineSpan>[
                TextSpan(text: 'TADAHHATH '),
                TextSpan(
                  text: 'AI',
                  style: TextStyle(color: AppColors.accentGold),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

class _TadahhathEmblemPainter extends CustomPainter {
  const _TadahhathEmblemPainter({required this.isMonochrome});

  final bool isMonochrome;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width * 0.34;

    final Paint goldPaint = Paint()
      ..color = isMonochrome ? Colors.white : AppColors.accentGold
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.055
      ..strokeCap = StrokeCap.round;

    final Paint bluePaint = Paint()
      ..color = isMonochrome ? Colors.white70 : AppColors.secondaryBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.055
      ..strokeCap = StrokeCap.round;

    // Left gold arc and right blue arc forming the speech-bubble ring
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      1.8,
      2.6,
      false,
      goldPaint,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -1.2,
      2.6,
      false,
      bluePaint,
    );

    // Central T stem & crossbar
    final Paint tGoldFill = Paint()
      ..color = isMonochrome ? Colors.white : AppColors.accentGold
      ..style = PaintingStyle.fill;
    final Paint tWhiteFill = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(center.dx - size.width * 0.08, center.dy - size.height * 0.12),
          width: size.width * 0.16,
          height: size.height * 0.07,
        ),
        const Radius.circular(3),
      ),
      tGoldFill,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(center.dx + size.width * 0.05, center.dy + size.height * 0.02),
          width: size.width * 0.08,
          height: size.height * 0.28,
        ),
        const Radius.circular(4),
      ),
      tWhiteFill,
    );
  }

  @override
  bool shouldRepaint(covariant _TadahhathEmblemPainter oldDelegate) {
    return oldDelegate.isMonochrome != isMonochrome;
  }
}
```

### `lib/shared/widgets/primary_button.dart`

```dart
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';

/// Reusable primary & secondary button with loading state and icon support.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    if (isOutlined) {
      return SizedBox(
        width: double.infinity,
        height: 52,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: isDark ? AppColors.borderDark : AppColors.secondaryBlue,
              width: 1.4,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            ),
          ),
          child: _buildChild(
            textColor: isDark ? AppColors.textPrimaryDark : AppColors.primaryNavy,
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: isDark ? AppColors.accentGold : AppColors.primaryNavy,
          foregroundColor: isDark ? AppColors.primaryNavy : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
        ),
        child: _buildChild(
          textColor: isDark ? AppColors.primaryNavy : Colors.white,
        ),
      ),
    );
  }

  Widget _buildChild({required Color textColor}) {
    if (isLoading) {
      return SizedBox(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(
          strokeWidth: 2.4,
          color: textColor,
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(icon, size: 20, color: textColor),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: textColor,
            ),
          ),
        ],
      );
    }

    return Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 15,
        color: textColor,
      ),
    );
  }
}
```

### `lib/shared/widgets/app_text_field.dart`

```dart
import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';

/// Accessible form input field with label, prefix icon, and optional password toggle.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hintText,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.validator,
    this.textInputAction = TextInputAction.next,
  });

  final TextEditingController controller;
  final String label;
  final String? hintText;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextInputAction textInputAction;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          widget.label,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: AppSpacing.xs),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword && _obscure,
          validator: widget.validator,
          textInputAction: widget.textInputAction,
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon:
                widget.prefixIcon != null ? Icon(widget.prefixIcon, size: 20) : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: () => setState(() => _obscure = !_obscure),
                    icon: Icon(
                      _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      size: 20,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
```

### `lib/shared/widgets/cefr_disclaimer_banner.dart`

```dart
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../localization/app_localizations.dart';

/// Mandatory transparency notice clarifying that internal CEFR estimates (A1-C2)
/// are for personalized study routing and are not official language certificates.
class CefrDisclaimerBanner extends StatelessWidget {
  const CefrDisclaimerBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.secondaryBlue.withOpacity(0.18)
            : AppColors.accentGold.withOpacity(0.14),
        borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
        border: Border.all(
          color: AppColors.accentGold.withOpacity(0.55),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(
            Icons.verified_user_outlined,
            size: 20,
            color: AppColors.accentGold,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              l10n.tr('cefr_disclaimer'),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 13,
                    height: 1.4,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
```

### `lib/features/splash/presentation/splash_screen.dart`

```dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../localization/app_localizations.dart';
import '../../../shared/widgets/tadahhath_logo.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../onboarding/presentation/onboarding_controller.dart';

/// Animated Splash Screen displaying the TADAHHATH AI brand mark and routing
/// the learner based on onboarding and authentication session state.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _scaleAnimation;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    _scaleAnimation = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();

    _navigationTimer = Timer(const Duration(milliseconds: 1600), _routeNext);
  }

  void _routeNext() {
    if (!mounted) {
      return;
    }
    final bool onboardingDone =
        ref.read(onboardingControllerProvider).preferences.isCompleted;
    final bool isAuthenticated =
        ref.read(authControllerProvider).user != null;

    if (!onboardingDone) {
      context.go('/onboarding');
    } else if (isAuthenticated) {
      context.go('/home');
    } else {
      context.go('/auth/login');
    }
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.primaryNavy,
      body: SafeArea(
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const TadahhathLogo(size: 104, showWordmark: false),
                    const SizedBox(height: AppSpacing.lg),
                    RichText(
                      textDirection: TextDirection.ltr,
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.6,
                          color: Colors.white,
                        ),
                        children: <InlineSpan>[
                          TextSpan(text: 'TADAHHATH '),
                          TextSpan(
                            text: 'AI',
                            style: TextStyle(color: AppColors.accentGold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      l10n.tr('tagline'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.textSecondaryDark,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    const SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: AppColors.accentGold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```

### `lib/features/onboarding/domain/onboarding_state.dart`

```dart
import '../../../models/onboarding_preferences.dart';

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
```

### `lib/features/onboarding/presentation/onboarding_controller.dart`

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../localization/locale_controller.dart';
import '../../../models/cefr_level.dart';
import '../../../models/onboarding_preferences.dart';
import '../../../repositories/onboarding_repository.dart';
import '../domain/onboarding_state.dart';

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
```

### `lib/features/onboarding/presentation/onboarding_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/theme/theme_controller.dart';
import '../../../localization/app_localizations.dart';
import '../../../models/app_language.dart';
import '../../../models/cefr_level.dart';
import '../../../models/onboarding_preferences.dart';
import '../../../shared/widgets/cefr_disclaimer_banner.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/tadahhath_logo.dart';
import '../domain/onboarding_state.dart';
import 'onboarding_controller.dart';

/// Complete 5-step Onboarding flow:
/// 1. Benefits & Interface Language (EN / FR / AR with live RTL support)
/// 2. Target Learning Language (English / French / Arabic)
/// 3. Current CEFR Knowledge Level (A1-C2 + Placement Test option + Disclaimer)
/// 4. Learning Goals (Multi-select)
/// 5. Daily Learning Duration (5, 10, 15, 20, 30 min/day)
class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final OnboardingState state = ref.watch(onboardingControllerProvider);
    final OnboardingController controller =
        ref.read(onboardingControllerProvider.notifier);
    final AppLocalizations l10n = AppLocalizations.of(context);
    final String localeCode = l10n.locale.languageCode;

    return Scaffold(
      appBar: AppBar(
        leading: state.currentStep > 0
            ? IconButton(
                onPressed: controller.previousStep,
                icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                tooltip: l10n.tr('back_btn'),
              )
            : null,
        title: Text(
          '${state.currentStep + 1} / ${OnboardingState.totalSteps}',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () =>
                ref.read(themeModeProvider.notifier).toggleLightDark(),
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
                child: LinearProgressIndicator(
                  value: (state.currentStep + 1) / OnboardingState.totalSteps,
                  minHeight: 8,
                  backgroundColor: AppColors.secondaryBlue.withOpacity(0.16),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.accentGold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: _buildStepContent(
                  context: context,
                  state: state,
                  controller: controller,
                  l10n: l10n,
                  localeCode: localeCode,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: PrimaryButton(
                label: state.currentStep == OnboardingState.totalSteps - 1
                    ? l10n.tr('get_started_btn')
                    : l10n.tr('continue_btn'),
                isLoading: state.isSaving,
                onPressed: () async {
                  if (state.currentStep < OnboardingState.totalSteps - 1) {
                    controller.nextStep();
                  } else {
                    await controller.completeOnboarding();
                    if (context.mounted) {
                      context.go('/auth/register');
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepContent({
    required BuildContext context,
    required OnboardingState state,
    required OnboardingController controller,
    required AppLocalizations l10n,
    required String localeCode,
  }) {
    switch (state.currentStep) {
      case 0:
        return _buildBenefitsAndInterfaceLanguageStep(
          context,
          state,
          controller,
          l10n,
        );
      case 1:
        return _buildTargetLanguageStep(
          context,
          state,
          controller,
          l10n,
          localeCode,
        );
      case 2:
        return _buildCefrLevelStep(
          context,
          state,
          controller,
          l10n,
          localeCode,
        );
      case 3:
        return _buildGoalsStep(
          context,
          state,
          controller,
          l10n,
          localeCode,
        );
      case 4:
      default:
        return _buildDailyDurationStep(
          context,
          state,
          controller,
          l10n,
        );
    }
  }

  Widget _buildBenefitsAndInterfaceLanguageStep(
    BuildContext context,
    OnboardingState state,
    OnboardingController controller,
    AppLocalizations l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Center(child: TadahhathLogo(size: 84)),
        const SizedBox(height: AppSpacing.lg),
        Text(
          l10n.tr('onboarding_step_1_title'),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.tr('onboarding_step_1_subtitle'),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.lg),
        _BenefitTile(
          icon: Icons.record_voice_over_outlined,
          title: 'AI Speaking & Voice Tutor',
          subtitle: 'Context-aware dialogues with grammar & expression coaching.',
        ),
        const SizedBox(height: AppSpacing.sm),
        _BenefitTile(
          icon: Icons.school_outlined,
          title: 'CEFR A1–C2 Structured Curriculum',
          subtitle: 'Grammar Academy, Vocabulary Builder, Reading & Listening Labs.',
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          l10n.tr('select_interface_language'),
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: SupportedLanguageCatalog.initialLanguages.map((AppLanguage lang) {
            final bool selected =
                state.preferences.interfaceLanguageCode == lang.isoCode;
            return ChoiceChip(
              label: Text('${lang.nativeName} (${lang.isoCode.toUpperCase()})'),
              selected: selected,
              selectedColor: AppColors.accentGold.withOpacity(0.28),
              onSelected: (_) =>
                  controller.selectInterfaceLanguage(lang.isoCode),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTargetLanguageStep(
    BuildContext context,
    OnboardingState state,
    OnboardingController controller,
    AppLocalizations l10n,
    String localeCode,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          l10n.tr('select_learning_language'),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.tr('select_learning_language_sub'),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.lg),
        ...SupportedLanguageCatalog.initialLanguages.map((AppLanguage lang) {
          final bool isSelected =
              state.preferences.targetLanguageCode == lang.isoCode;
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: InkWell(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              onTap: () => controller.selectTargetLanguage(lang.isoCode),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  side: BorderSide(
                    color: isSelected
                        ? AppColors.accentGold
                        : AppColors.borderLight,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: AppColors.primaryNavy,
                        child: Text(
                          lang.scriptBadge,
                          style: const TextStyle(
                            color: AppColors.accentGold,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              lang.localizedName(localeCode),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              lang.nativeName,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        const Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.accentGold,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildCefrLevelStep(
    BuildContext context,
    OnboardingState state,
    OnboardingController controller,
    AppLocalizations l10n,
    String localeCode,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          l10n.tr('select_current_level'),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        const CefrDisclaimerBanner(),
        const SizedBox(height: AppSpacing.md),
        SwitchListTile.adaptive(
          contentPadding: EdgeInsets.zero,
          value: state.preferences.wantsPlacementTest,
          activeColor: AppColors.accentGold,
          title: Text(
            l10n.tr('recommend_placement_toggle'),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          onChanged: controller.togglePlacementTest,
        ),
        const SizedBox(height: AppSpacing.sm),
        ...CefrLevel.values.map((CefrLevel level) {
          final bool isSelected = state.preferences.estimatedLevel == level;
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: InkWell(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              onTap: () => controller.selectEstimatedLevel(level),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  side: BorderSide(
                    color: isSelected
                        ? AppColors.accentGold
                        : AppColors.borderLight,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 44,
                        height: 44,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.accentGold
                              : AppColors.primaryNavy,
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusSm),
                        ),
                        child: Text(
                          level.code,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: isSelected
                                ? AppColors.primaryNavy
                                : Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              level.localizedTitle(localeCode),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              level.localizedDescription(localeCode),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildGoalsStep(
    BuildContext context,
    OnboardingState state,
    OnboardingController controller,
    AppLocalizations l10n,
    String localeCode,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          l10n.tr('select_goals_title'),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.tr('select_goals_subtitle'),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.lg),
        ...LearningGoalCategory.values.map((LearningGoalCategory goal) {
          final bool selected = state.preferences.goalIds.contains(goal.id);
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: CheckboxListTile(
              value: selected,
              activeColor: AppColors.primaryNavy,
              checkColor: AppColors.accentGold,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              title: Text(
                goal.localizedLabel(localeCode),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              onChanged: (_) => controller.toggleGoal(goal.id),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildDailyDurationStep(
    BuildContext context,
    OnboardingState state,
    OnboardingController controller,
    AppLocalizations l10n,
  ) {
    const List<int> durations = <int>[5, 10, 15, 20, 30];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          l10n.tr('select_duration_title'),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.tr('select_duration_subtitle'),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.lg),
        ...durations.map((int mins) {
          final bool selected = state.preferences.dailyMinutesGoal == mins;
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: InkWell(
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              onTap: () => controller.selectDailyDuration(mins),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  side: BorderSide(
                    color: selected
                        ? AppColors.accentGold
                        : AppColors.borderLight,
                    width: selected ? 2 : 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.timer_outlined,
                            color: AppColors.secondaryBlue,
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Text(
                            '$mins ${l10n.tr('minutes_per_day')}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                      if (selected)
                        const Icon(
                          Icons.check_circle_rounded,
                          color: AppColors.accentGold,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _BenefitTile extends StatelessWidget {
  const _BenefitTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.primaryNavy.withOpacity(0.08),
                borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
              ),
              child: Icon(icon, color: AppColors.secondaryBlue),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

### `lib/features/auth/domain/auth_state.dart`

```dart
import '../../../models/auth_user_model.dart';

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
```

### `lib/features/auth/presentation/auth_controller.dart`

```dart
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/app_exception.dart';
import '../../../models/auth_user_model.dart';
import '../../../models/onboarding_preferences.dart';
import '../../../repositories/auth_repository.dart';
import '../domain/auth_state.dart';

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
```

### `lib/features/auth/presentation/login_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/env_config.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/validators.dart';
import '../../../localization/app_localizations.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/tadahhath_logo.dart';
import '../domain/auth_state.dart';
import 'auth_controller.dart';

/// Production Login Screen with form validation, Google OAuth, password recovery
/// routing, and explicit backend configuration state reporting.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    final String? lastEmail = ref.read(authControllerProvider).lastEmail;
    _emailController = TextEditingController(text: lastEmail ?? '');
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitLogin() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    final bool ok = await ref.read(authControllerProvider.notifier).signIn(
          email: _emailController.text,
          password: _passwordController.text,
        );
    if (ok && mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AuthUiState authState = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          TextButton.icon(
            onPressed: () => context.go('/onboarding'),
            icon: const Icon(Icons.tune_rounded, size: 18),
            label: Text(l10n.tr('reconfigure_onboarding')),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Center(child: TadahhathLogo(size: 72)),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  l10n.tr('login_title'),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  l10n.tr('login_subtitle'),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.md),
                if (!EnvConfig.isSupabaseConfigured)
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    margin: const EdgeInsets.only(bottom: AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.warning.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                      border: Border.all(color: AppColors.warning),
                    ),
                    child: Text(
                      l10n.tr('supabase_not_configured_banner'),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                if (authState.errorMessage != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.md),
                    margin: const EdgeInsets.only(bottom: AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                      border: Border.all(color: AppColors.error),
                    ),
                    child: Text(
                      authState.errorMessage!,
                      style: const TextStyle(
                        color: AppColors.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                AppTextField(
                  controller: _emailController,
                  label: l10n.tr('email_label'),
                  hintText: 'learner@example.com',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? val) => Validators.validateEmail(
                    val,
                    requiredMsg: l10n.tr('field_required'),
                    invalidMsg: l10n.tr('invalid_email'),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                AppTextField(
                  controller: _passwordController,
                  label: l10n.tr('password_label'),
                  prefixIcon: Icons.lock_outline_rounded,
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  validator: (String? val) => Validators.validatePassword(
                    val,
                    requiredMsg: l10n.tr('field_required'),
                    tooShortMsg: l10n.tr('password_too_short'),
                    complexityMsg: l10n.tr('password_complexity'),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    onPressed: () => context.push('/auth/forgot-password'),
                    child: Text(l10n.tr('forgot_password_link')),
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                PrimaryButton(
                  label: l10n.tr('sign_in_btn'),
                  isLoading: authState.isLoading,
                  onPressed: _submitLogin,
                ),
                const SizedBox(height: AppSpacing.sm),
                PrimaryButton(
                  label: l10n.tr('google_auth_btn'),
                  isOutlined: true,
                  icon: Icons.g_mobiledata_rounded,
                  isLoading: authState.isLoading,
                  onPressed: () =>
                      ref.read(authControllerProvider.notifier).signInWithGoogle(),
                ),
                const SizedBox(height: AppSpacing.lg),
                Center(
                  child: TextButton(
                    onPressed: () => context.go('/auth/register'),
                    child: Text(l10n.tr('no_account_prompt')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

### `lib/features/auth/presentation/register_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/validators.dart';
import '../../../localization/app_localizations.dart';
import '../../../models/app_language.dart';
import '../../../models/onboarding_preferences.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/cefr_disclaimer_banner.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../onboarding/presentation/onboarding_controller.dart';
import '../domain/auth_state.dart';
import 'auth_controller.dart';

/// Registration Screen capturing learner identity and attaching their selected
/// onboarding language, CEFR estimate, and study goals.
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submitRegistration() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    final OnboardingPreferences prefs =
        ref.read(onboardingControllerProvider).preferences;
    final bool ok = await ref.read(authControllerProvider.notifier).register(
          fullName: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          preferences: prefs,
        );
    if (ok && mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AuthUiState authState = ref.watch(authControllerProvider);
    final OnboardingPreferences prefs =
        ref.watch(onboardingControllerProvider).preferences;
    final AppLanguage targetLang =
        SupportedLanguageCatalog.byCode(prefs.targetLanguageCode);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.tr('register_title')),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  l10n.tr('register_subtitle'),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.md),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.flag_circle_outlined,
                          color: AppColors.secondaryBlue,
                          size: 28,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            '${targetLang.nativeName} • CEFR ${prefs.estimatedLevel.code} • ${prefs.dailyMinutesGoal} ${l10n.tr('minutes_per_day')}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.go('/onboarding'),
                          child: Text(l10n.tr('back_btn')),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                if (authState.errorMessage != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.md),
                    margin: const EdgeInsets.only(bottom: AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                      border: Border.all(color: AppColors.error),
                    ),
                    child: Text(
                      authState.errorMessage!,
                      style: const TextStyle(
                        color: AppColors.error,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                AppTextField(
                  controller: _nameController,
                  label: l10n.tr('full_name_label'),
                  prefixIcon: Icons.person_outline_rounded,
                  validator: (String? val) => Validators.validateFullName(
                    val,
                    requiredMsg: l10n.tr('field_required'),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                AppTextField(
                  controller: _emailController,
                  label: l10n.tr('email_label'),
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? val) => Validators.validateEmail(
                    val,
                    requiredMsg: l10n.tr('field_required'),
                    invalidMsg: l10n.tr('invalid_email'),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                AppTextField(
                  controller: _passwordController,
                  label: l10n.tr('password_label'),
                  prefixIcon: Icons.lock_outline_rounded,
                  isPassword: true,
                  validator: (String? val) => Validators.validatePassword(
                    val,
                    requiredMsg: l10n.tr('field_required'),
                    tooShortMsg: l10n.tr('password_too_short'),
                    complexityMsg: l10n.tr('password_complexity'),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                AppTextField(
                  controller: _confirmPasswordController,
                  label: l10n.tr('confirm_password_label'),
                  prefixIcon: Icons.verified_outlined,
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  validator: (String? val) {
                    if (val != _passwordController.text) {
                      return l10n.tr('passwords_do_not_match');
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                const CefrDisclaimerBanner(),
                const SizedBox(height: AppSpacing.lg),
                PrimaryButton(
                  label: l10n.tr('sign_up_btn'),
                  isLoading: authState.isLoading,
                  onPressed: _submitRegistration,
                ),
                const SizedBox(height: AppSpacing.sm),
                PrimaryButton(
                  label: l10n.tr('google_auth_btn'),
                  isOutlined: true,
                  icon: Icons.g_mobiledata_rounded,
                  isLoading: authState.isLoading,
                  onPressed: () =>
                      ref.read(authControllerProvider.notifier).signInWithGoogle(),
                ),
                const SizedBox(height: AppSpacing.md),
                Center(
                  child: TextButton(
                    onPressed: () => context.go('/auth/login'),
                    child: Text(l10n.tr('have_account_prompt')),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

### `lib/features/auth/presentation/forgot_password_screen.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/utils/validators.dart';
import '../../../localization/app_localizations.dart';
import '../../../shared/widgets/app_text_field.dart';
import '../../../shared/widgets/primary_button.dart';
import '../domain/auth_state.dart';
import 'auth_controller.dart';

/// Password recovery screen dispatching a Supabase reset email.
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submitReset() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    final AppLocalizations l10n = AppLocalizations.of(context);
    await ref.read(authControllerProvider.notifier).sendPasswordReset(
          _emailController.text,
          successMessage: l10n.tr('reset_email_sent'),
        );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final AuthUiState authState = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.tr('forgot_password_title')),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  l10n.tr('forgot_password_subtitle'),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.lg),
                if (authState.errorMessage != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.md),
                    margin: const EdgeInsets.only(bottom: AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                      border: Border.all(color: AppColors.error),
                    ),
                    child: Text(
                      authState.errorMessage!,
                      style: const TextStyle(color: AppColors.error),
                    ),
                  ),
                if (authState.infoMessage != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.md),
                    margin: const EdgeInsets.only(bottom: AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
                      border: Border.all(color: AppColors.success),
                    ),
                    child: Text(
                      authState.infoMessage!,
                      style: const TextStyle(color: AppColors.success),
                    ),
                  ),
                AppTextField(
                  controller: _emailController,
                  label: l10n.tr('email_label'),
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  validator: (String? val) => Validators.validateEmail(
                    val,
                    requiredMsg: l10n.tr('field_required'),
                    invalidMsg: l10n.tr('invalid_email'),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                PrimaryButton(
                  label: l10n.tr('send_reset_link_btn'),
                  isLoading: authState.isLoading,
                  onPressed: _submitReset,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

### `lib/features/home/presentation/home_shell_scaffold.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_spacing.dart';
import '../../../localization/app_localizations.dart';
import '../../../models/app_language.dart';
import '../../../models/onboarding_preferences.dart';
import '../../../shared/widgets/cefr_disclaimer_banner.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/tadahhath_logo.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../onboarding/presentation/onboarding_controller.dart';

/// Authenticated Home Entry Shell for Phase 1.
/// Displays the active user session, onboarding language & CEFR configuration,
/// and sign-out controls, ready for Phase 2/3 Dashboard expansion.
class HomeShellScaffold extends ConsumerWidget {
  const HomeShellScaffold({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppLocalizations l10n = AppLocalizations.of(context);
    final OnboardingPreferences prefs =
        ref.watch(onboardingControllerProvider).preferences;
    final AppLanguage targetLang =
        SupportedLanguageCatalog.byCode(prefs.targetLanguageCode);
    final user = ref.watch(authControllerProvider).user;

    return Scaffold(
      appBar: AppBar(
        title: const TadahhathLogo(size: 34, showWordmark: false),
        actions: <Widget>[
          IconButton(
            tooltip: l10n.tr('logout_btn'),
            onPressed: () async {
              await ref.read(authControllerProvider.notifier).signOut();
              if (context.mounted) {
                context.go('/auth/login');
              }
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                user != null ? '${ user.fullName } (${ user.email })' : l10n.tr('home_phase1_ready'),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                l10n.tr('home_phase1_desc'),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${targetLang.nativeName} • CEFR ${prefs.estimatedLevel.code}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Daily Goal: ${prefs.dailyMinutesGoal} ${l10n.tr('minutes_per_day')}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              const CefrDisclaimerBanner(),
              const Spacer(),
              PrimaryButton(
                label: l10n.tr('reconfigure_onboarding'),
                isOutlined: true,
                onPressed: () async {
                  await ref
                      .read(onboardingControllerProvider.notifier)
                      .reopenOnboarding();
                  if (context.mounted) {
                    context.go('/onboarding');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

### `lib/app/router.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/forgot_password_screen.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/register_screen.dart';
import '../features/home/presentation/home_shell_scaffold.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/splash/presentation/splash_screen.dart';

final Provider<GoRouter> appRouterProvider = Provider<GoRouter>((Ref ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: <RouteBase>[
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (BuildContext context, GoRouterState state) =>
            const OnboardingScreen(),
      ),
      GoRoute(
        path: '/auth/login',
        name: 'login',
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
      ),
      GoRoute(
        path: '/auth/register',
        name: 'register',
        builder: (BuildContext context, GoRouterState state) =>
            const RegisterScreen(),
      ),
      GoRoute(
        path: '/auth/forgot-password',
        name: 'forgotPassword',
        builder: (BuildContext context, GoRouterState state) =>
            const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (BuildContext context, GoRouterState state) =>
            const HomeShellScaffold(),
      ),
    ],
  );
});
```

### `lib/app/app.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/theme/app_theme.dart';
import '../core/theme/theme_controller.dart';
import '../localization/app_localizations.dart';
import '../localization/locale_controller.dart';
import 'router.dart';

/// Root Material 3 application widget wiring Riverpod state, GoRouter navigation,
/// Light/Dark theming, and English/French/Arabic (RTL) localization.
class TadahhathApp extends ConsumerWidget {
  const TadahhathApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Locale locale = ref.watch(localeProvider);
    final ThemeMode themeMode = ref.watch(themeModeProvider);
    final GoRouter router = ref.watch(appRouterProvider);
    final bool isArabic = locale.languageCode == 'ar';

    return MaterialApp.router(
      title: 'TADAHHATH AI',
      debugShowCheckedModeBanner: false,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      themeMode: themeMode,
      theme: AppTheme.light(isArabic: isArabic),
      darkTheme: AppTheme.dark(isArabic: isArabic),
      routerConfig: router,
    );
  }
}
```

### `test/phase1_unit_test.dart`

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tadahhath_ai/core/utils/validators.dart';
import 'package:tadahhath_ai/localization/app_localizations.dart';
import 'package:tadahhath_ai/models/app_language.dart';
import 'package:tadahhath_ai/models/cefr_level.dart';
import 'package:tadahhath_ai/models/onboarding_preferences.dart';

void main() {
  group('Phase 1 — Validators & Domain Models', () {
    test('Email validator rejects malformed emails and accepts valid addresses', () {
      expect(
        Validators.validateEmail(
          '',
          requiredMsg: 'Required',
          invalidMsg: 'Invalid',
        ),
        'Required',
      );
      expect(
        Validators.validateEmail(
          'not-an-email',
          requiredMsg: 'Required',
          invalidMsg: 'Invalid',
        ),
        'Invalid',
      );
      expect(
        Validators.validateEmail(
          'student@tadahhath.ai',
          requiredMsg: 'Required',
          invalidMsg: 'Invalid',
        ),
        isNull,
      );
    });

    test('Password validator enforces minimum length and alphanumeric complexity', () {
      expect(
        Validators.validatePassword(
          'short1',
          requiredMsg: 'Req',
          tooShortMsg: 'Short',
          complexityMsg: 'Complex',
        ),
        'Short',
      );
      expect(
        Validators.validatePassword(
          'onlyletters',
          requiredMsg: 'Req',
          tooShortMsg: 'Short',
          complexityMsg: 'Complex',
        ),
        'Complex',
      );
      expect(
        Validators.validatePassword(
          'SecurePass2026',
          requiredMsg: 'Req',
          tooShortMsg: 'Short',
          complexityMsg: 'Complex',
        ),
        isNull,
      );
    });

    test('OnboardingPreferences serializes and deserializes without data loss', () {
      final OnboardingPreferences original = OnboardingPreferences(
        interfaceLanguageCode: 'ar',
        targetLanguageCode: 'en',
        estimatedLevel: CefrLevel.b2,
        goalIds: const <String>['career', 'travel'],
        dailyMinutesGoal: 20,
        wantsPlacementTest: true,
        isCompleted: true,
      );

      final String encoded = original.toEncodedJson();
      final OnboardingPreferences restored =
          OnboardingPreferences.fromEncodedJson(encoded);

      expect(restored.interfaceLanguageCode, 'ar');
      expect(restored.targetLanguageCode, 'en');
      expect(restored.estimatedLevel, CefrLevel.b2);
      expect(restored.goalIds, <String>['career', 'travel']);
      expect(restored.dailyMinutesGoal, 20);
      expect(restored.wantsPlacementTest, isTrue);
      expect(restored.isCompleted, isTrue);
    });

    test('Localization provides EN, FR, and AR translations and detects Arabic RTL', () {
      const AppLocalizations en = AppLocalizations(Locale('en'));
      const AppLocalizations fr = AppLocalizations(Locale('fr'));
      const AppLocalizations ar = AppLocalizations(Locale('ar'));

      expect(en.isRtl, isFalse);
      expect(fr.isRtl, isFalse);
      expect(ar.isRtl, isTrue);

      expect(en.tr('cefr_disclaimer'), contains('not official language certificates'));
      expect(fr.tr('cefr_disclaimer'), contains('certificats officiels'));
      expect(ar.tr('cefr_disclaimer'), contains('شهادات لغة رسمية'));
    });

    test('SupportedLanguageCatalog includes English, French, and Arabic', () {
      expect(SupportedLanguageCatalog.initialLanguages.length, 3);
      expect(SupportedLanguageCatalog.byCode('ar').isRtl, isTrue);
      expect(SupportedLanguageCatalog.byCode('en').isRtl, isFalse);
      expect(SupportedLanguageCatalog.byCode('fr').isRtl, isFalse);
    });
  });
}
```
