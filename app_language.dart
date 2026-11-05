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
