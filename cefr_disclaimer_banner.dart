import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_localizations.dart';

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
