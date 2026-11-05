import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app_theme.dart';
import 'theme_controller.dart';
import 'app_localizations.dart';
import 'locale_controller.dart';
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
