import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app_spacing.dart';
import 'app_localizations.dart';
import 'app_language.dart';
import 'onboarding_preferences.dart';
import 'cefr_disclaimer_banner.dart';
import 'primary_button.dart';
import 'tadahhath_logo.dart';
import 'auth_controller.dart';
import 'onboarding_controller.dart';

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
