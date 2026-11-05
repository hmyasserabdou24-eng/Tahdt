import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'theme_controller.dart';
import 'app_localizations.dart';
import 'app_language.dart';
import 'cefr_level.dart';
import 'onboarding_preferences.dart';
import 'cefr_disclaimer_banner.dart';
import 'primary_button.dart';
import 'tadahhath_logo.dart';
import 'onboarding_state.dart';
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
