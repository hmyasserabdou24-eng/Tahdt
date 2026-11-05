import 'package:flutter/material.dart';

/// Multi-language localization dictionary supporting English (LTR),
/// French (LTR), and Arabic (RTL).
class AppLocalizations {
  const AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        const AppLocalizations(Locale('en'));
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
    Locale('ar'),
  ];

  bool get isRtl => locale.languageCode == 'ar';

  static final Map<String, Map<String, String>> _localizedValues =
      <String, Map<String, String>>{
    'en': <String, String>{
      'app_name': 'TADAHHATH AI',
      'tagline': 'Intelligent Global Language Mastery',
      'cefr_disclaimer':
          'Note: CEFR levels (A1–C2) estimated inside TADAHHATH AI are for personalized study routing only and are not official language certificates.',
      'onboarding_step_1_title': 'Learn Naturally with AI Guidance',
      'onboarding_step_1_subtitle':
          'Practice real-world speaking, adaptive grammar, vocabulary, listening, and writing with structured feedback.',
      'select_interface_language': 'Interface Language',
      'select_learning_language': 'Which language do you want to learn first?',
      'select_learning_language_sub':
          'You can add more languages and maintain separate progress at any time.',
      'select_current_level': 'What is your current level?',
      'recommend_placement_toggle': 'Take adaptive placement test after signup',
      'select_goals_title': 'What are your primary learning goals?',
      'select_goals_subtitle': 'Select one or more focus areas to tailor your study plan.',
      'select_duration_title': 'Set your daily study commitment',
      'select_duration_subtitle': 'Consistent daily practice builds lasting fluency.',
      'minutes_per_day': 'min / day',
      'continue_btn': 'Continue',
      'back_btn': 'Back',
      'get_started_btn': 'Continue to Account Setup',
      'login_title': 'Welcome Back',
      'login_subtitle': 'Sign in to sync your learning progress across devices.',
      'register_title': 'Create Your Learner Account',
      'register_subtitle': 'Start your personalized language path with TADAHHATH AI.',
      'forgot_password_title': 'Password Recovery',
      'forgot_password_subtitle':
          'Enter your account email and we will send a secure password reset link.',
      'email_label': 'Email Address',
      'password_label': 'Password',
      'confirm_password_label': 'Confirm Password',
      'full_name_label': 'Full Name',
      'sign_in_btn': 'Sign In',
      'sign_up_btn': 'Create Account',
      'google_auth_btn': 'Continue with Google',
      'send_reset_link_btn': 'Send Recovery Link',
      'forgot_password_link': 'Forgot password?',
      'no_account_prompt': 'New to TADAHHATH AI? Create an account',
      'have_account_prompt': 'Already have an account? Sign in',
      'logout_btn': 'Sign Out',
      'supabase_not_configured_banner':
          'Backend Configuration Notice: SUPABASE_URL and SUPABASE_ANON_KEY are not yet provided via --dart-define. Live Supabase authentication requires configuring your project credentials.',
      'field_required': 'This field is required.',
      'invalid_email': 'Please enter a valid email address.',
      'password_too_short': 'Password must be at least 8 characters.',
      'password_complexity': 'Include at least one letter and one number.',
      'passwords_do_not_match': 'Passwords do not match.',
      'reset_email_sent':
          'If an account exists for that email, a password reset link has been dispatched.',
      'home_phase1_ready': 'Phase 1 Foundation Active',
      'home_phase1_desc':
          'Your onboarding profile, localization engine, and authentication shell are active. Phase 2 and Phase 3 connect full Supabase persistence and learning modules.',
      'reconfigure_onboarding': 'Review Onboarding Preferences',
    },
    'fr': <String, String>{
      'app_name': 'TADAHHATH AI',
      'tagline': 'Maîtrise linguistique intelligente par l'IA',
      'cefr_disclaimer':
          'Remarque : Les niveaux CECRL (A1–C2) estimés dans TADAHHATH AI servent uniquement à personnaliser votre parcours et ne constituent pas des certificats officiels.',
      'onboarding_step_1_title': 'Apprenez naturellement avec l'IA',
      'onboarding_step_1_subtitle':
          'Pratiquez l'expression orale, la grammaire adaptative, le vocabulaire, l'écoute et l'écriture avec des corrections précises.',
      'select_interface_language': 'Langue de l'interface',
      'select_learning_language': 'Quelle langue souhaitez-vous apprendre ?',
      'select_learning_language_sub':
          'Vous pourrez ajouter d'autres langues avec un suivi séparé à tout moment.',
      'select_current_level': 'Quel est votre niveau actuel ?',
      'recommend_placement_toggle': 'Passer le test de placement adaptatif après l'inscription',
      'select_goals_title': 'Quels sont vos objectifs d'apprentissage ?',
      'select_goals_subtitle': 'Sélectionnez un ou plusieurs domaines pour personnaliser votre plan.',
      'select_duration_title': 'Définissez votre objectif quotidien',
      'select_duration_subtitle': 'La régularité quotidienne est la clé de la fluidité.',
      'minutes_per_day': 'min / jour',
      'continue_btn': 'Continuer',
      'back_btn': 'Retour',
      'get_started_btn': 'Configurer mon compte',
      'login_title': 'Bon retour',
      'login_subtitle': 'Connectez-vous pour synchroniser votre progression.',
      'register_title': 'Créer votre compte apprenant',
      'register_subtitle': 'Commencez votre parcours personnalisé avec TADAHHATH AI.',
      'forgot_password_title': 'Récupération du mot de passe',
      'forgot_password_subtitle':
          'Saisissez votre adresse e-mail pour recevoir un lien sécurisé de réinitialisation.',
      'email_label': 'Adresse e-mail',
      'password_label': 'Mot de passe',
      'confirm_password_label': 'Confirmer le mot de passe',
      'full_name_label': 'Nom complet',
      'sign_in_btn': 'Se connecter',
      'sign_up_btn': 'Créer un compte',
      'google_auth_btn': 'Continuer avec Google',
      'send_reset_link_btn': 'Envoyer le lien',
      'forgot_password_link': 'Mot de passe oublié ?',
      'no_account_prompt': 'Nouveau sur TADAHHATH AI ? Créer un compte',
      'have_account_prompt': 'Déjà inscrit ? Se connecter',
      'logout_btn': 'Se déconnecter',
      'supabase_not_configured_banner':
          'Avis de configuration : SUPABASE_URL et SUPABASE_ANON_KEY ne sont pas encore fournis via --dart-define. L'authentification Supabase en direct nécessite vos identifiants.',
      'field_required': 'Ce champ est obligatoire.',
      'invalid_email': 'Veuillez saisir une adresse e-mail valide.',
      'password_too_short': 'Le mot de passe doit contenir au moins 8 caractères.',
      'password_complexity': 'Incluez au moins une lettre et un chiffre.',
      'passwords_do_not_match': 'Les mots de passe ne correspondent pas.',
      'reset_email_sent':
          'Si un compte correspond à cet e-mail, un lien de réinitialisation a été envoyé.',
      'home_phase1_ready': 'Fondation Phase 1 Active',
      'home_phase1_desc':
          'Votre profil d'intégration, le moteur multilingue et l'architecture d'authentification sont actifs.',
      'reconfigure_onboarding': 'Modifier les préférences d'intégration',
    },
    'ar': <String, String>{
      'app_name': 'تحدث AI',
      'tagline': 'منصة ذكية عالمية لإتقان اللغات',
      'cefr_disclaimer':
          'ملاحظة: مستويات الإطار الأوروبي المرجعي (A1–C2) المقدرة داخل التطبيق مخصصة لتوجيه خطة التعلم الشخصية فقط وليست شهادات لغة رسمية معتمدة.',
      'onboarding_step_1_title': 'تعلّم اللغات بطلاقة بدعم الذكاء الاصطناعي',
      'onboarding_step_1_subtitle':
          'تدرّب على المحادثة الصوتية، القواعد التفاعلية، المفردات، الاستماع، والكتابة مع تصحيح فوري دقيق.',
      'select_interface_language': 'لغة واجهة التطبيق',
      'select_learning_language': 'ما اللغة التي ترغب في تعلمها أولاً؟',
      'select_learning_language_sub':
          'يمكنك إضافة لغات أخرى والاحتفاظ بتقدم مستقل لكل لغة في أي وقت.',
      'select_current_level': 'ما هو مستواك الحالي في هذه اللغة؟',
      'recommend_placement_toggle': 'إجراء اختبار تحديد المستوى التكيفي بعد التسجيل',
      'select_goals_title': 'ما هي أهدافك الأساسية من التعلم؟',
      'select_goals_subtitle': 'اختر هدفاً أو أكثر لتخصيص خطتك الدراسية.',
      'select_duration_title': 'حدد مدة التعلم اليومية',
      'select_duration_subtitle': 'الممارسة اليومية المنتظمة تبني الطلاقة الحقيقية.',
      'minutes_per_day': 'دقيقة / يومياً',
      'continue_btn': 'متابعة',
      'back_btn': 'رجوع',
      'get_started_btn': 'المتابعة لإعداد الحساب',
      'login_title': 'مرحباً بعودتك',
      'login_subtitle': 'سجّل الدخول لمزامنة تقدمك الدراسي عبر أجهزتك.',
      'register_title': 'إنشاء حساب متعلم جديد',
      'register_subtitle': 'ابدأ مسارك التعليمي المخصص مع TADAHHATH AI.',
      'forgot_password_title': 'استعادة كلمة المرور',
      'forgot_password_subtitle':
          'أدخل بريدك الإلكتروني وسنرسل لك رابطاً آمناً لإعادة تعيين كلمة المرور.',
      'email_label': 'البريد الإلكتروني',
      'password_label': 'كلمة المرور',
      'confirm_password_label': 'تأكيد كلمة المرور',
      'full_name_label': 'الاسم الكامل',
      'sign_in_btn': 'تسجيل الدخول',
      'sign_up_btn': 'إنشاء الحساب',
      'google_auth_btn': 'المتابعة باستخدام Google',
      'send_reset_link_btn': 'إرسال رابط الاستعادة',
      'forgot_password_link': 'نسيت كلمة المرور؟',
      'no_account_prompt': 'جديد في TADAHHATH AI؟ أنشئ حساباً',
      'have_account_prompt': 'لديك حساب بالفعل؟ سجّل الدخول',
      'logout_btn': 'تسجيل الخروج',
      'supabase_not_configured_banner':
          'تنبيه الإعدادات: لم يتم تمرير SUPABASE_URL و SUPABASE_ANON_KEY عبر --dart-define بعد. يتطلب الاتصال الفعلي بقاعدة البيانات ضبط إعدادات مشروع Supabase.',
      'field_required': 'هذا الحقل مطلوب.',
      'invalid_email': 'يرجى إدخال بريد إلكتروني صحيح.',
      'password_too_short': 'يجب أن تتكون كلمة المرور من 8 أحرف على الأقل.',
      'password_complexity': 'يجب أن تحتوي كلمة المرور على حرف ورقم واحد على الأقل.',
      'passwords_do_not_match': 'كلمتا المرور غير متطابقتين.',
      'reset_email_sent':
          'إذا كان البريد مسجلاً لدينا، فقد تم إرسال رابط استعادة كلمة المرور.',
      'home_phase1_ready': 'البنية الأساسية للمرحلة الأولى جاهزة',
      'home_phase1_desc':
          'تم تفعيل إعدادات التعلم واللغات (بما في ذلك دعم العربية RTL) وواجهة المصادقة الآمنة.',
      'reconfigure_onboarding': 'مراجعة تفضيلات التعلم',
    },
  };

  String tr(String key) {
    final Map<String, String>? dict = _localizedValues[locale.languageCode];
    return dict?[key] ?? _localizedValues['en']![key] ?? key;
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return <String>['en', 'fr', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
