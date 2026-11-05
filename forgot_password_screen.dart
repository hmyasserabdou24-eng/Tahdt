import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'validators.dart';
import 'app_localizations.dart';
import 'app_text_field.dart';
import 'primary_button.dart';
import 'auth_state.dart';
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
