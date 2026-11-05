import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'validators.dart';
import 'app_localizations.dart';
import 'app_language.dart';
import 'cefr_level.dart';
import 'onboarding_preferences.dart';

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
