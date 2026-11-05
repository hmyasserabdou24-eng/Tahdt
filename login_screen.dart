import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'env_config.dart';
import 'app_colors.dart';
import 'app_spacing.dart';
import 'validators.dart';
import 'app_localizations.dart';
import 'app_text_field.dart';
import 'primary_button.dart';
import 'tadahhath_logo.dart';
import 'auth_state.dart';
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
