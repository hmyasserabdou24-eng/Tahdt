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
