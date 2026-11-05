import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'validators.dart';
import 'app_localizations.dart';
import 'app_language.dart';
import 'onboarding_preferences.dart';
import 'app_text_field.dart';
import 'cefr_disclaimer_banner.dart';
import 'primary_button.dart';
import 'onboarding_controller.dart';
import 'auth_state.dart';
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
