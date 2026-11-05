import 'dart:convert';

import 'cefr_level.dart';

/// Learning goal categories selectable during onboarding and language management.
enum LearningGoalCategory {
  conversation('conversation', 'Everyday Conversation', 'Conversation quotidienne', 'المحادثة اليومية'),
  career('career', 'Career & Business', 'Carrière et affaires', 'العمل والمهنة'),
  travel('travel', 'Travel & Culture', 'Voyage et culture', 'السفر والثقافة'),
  academic('academic', 'Academic & Exams', 'Études et examens', 'الدراسة والامتحانات'),
  pronunciation('pronunciation', 'Pronunciation Mastery', 'Maîtrise de la prononciation', 'إتقان النطق');

  const LearningGoalCategory(this.id, this.labelEn, this.labelFr, this.labelAr);

  final String id;
  final String labelEn;
  final String labelFr;
  final String labelAr;

  String localizedLabel(String localeCode) {
    switch (localeCode) {
      case 'fr':
        return labelFr;
      case 'ar':
        return labelAr;
      default:
        return labelEn;
    }
  }

  static LearningGoalCategory fromId(String id) {
    for (final LearningGoalCategory item in LearningGoalCategory.values) {
      if (item.id == id) {
        return item;
      }
    }
    return LearningGoalCategory.conversation;
  }
}

/// Immutable user onboarding selections persisted locally and synced to Supabase upon registration.
class OnboardingPreferences {
  const OnboardingPreferences({
    required this.interfaceLanguageCode,
    required this.targetLanguageCode,
    required this.estimatedLevel,
    required this.goalIds,
    required this.dailyMinutesGoal,
    required this.wantsPlacementTest,
    required this.isCompleted,
  });

  factory OnboardingPreferences.initial() {
    return const OnboardingPreferences(
      interfaceLanguageCode: 'en',
      targetLanguageCode: 'fr',
      estimatedLevel: CefrLevel.a1,
      goalIds: <String>['conversation', 'career'],
      dailyMinutesGoal: 15,
      wantsPlacementTest: true,
      isCompleted: false,
    );
  }

  factory OnboardingPreferences.fromJson(Map<String, dynamic> json) {
    final List<dynamic> rawGoals = (json['goalIds'] as List<dynamic>?) ?? <dynamic>['conversation'];
    return OnboardingPreferences(
      interfaceLanguageCode: (json['interfaceLanguageCode'] as String?) ?? 'en',
      targetLanguageCode: (json['targetLanguageCode'] as String?) ?? 'fr',
      estimatedLevel: CefrLevel.fromCode(json['estimatedLevel'] as String?),
      goalIds: rawGoals.map((dynamic e) => e.toString()).toList(),
      dailyMinutesGoal: (json['dailyMinutesGoal'] as int?) ?? 15,
      wantsPlacementTest: (json['wantsPlacementTest'] as bool?) ?? true,
      isCompleted: (json['isCompleted'] as bool?) ?? false,
    );
  }

  final String interfaceLanguageCode;
  final String targetLanguageCode;
  final CefrLevel estimatedLevel;
  final List<String> goalIds;
  final int dailyMinutesGoal;
  final bool wantsPlacementTest;
  final bool isCompleted;

  OnboardingPreferences copyWith({
    String? interfaceLanguageCode,
    String? targetLanguageCode,
    CefrLevel? estimatedLevel,
    List<String>? goalIds,
    int? dailyMinutesGoal,
    bool? wantsPlacementTest,
    bool? isCompleted,
  }) {
    return OnboardingPreferences(
      interfaceLanguageCode: interfaceLanguageCode ?? this.interfaceLanguageCode,
      targetLanguageCode: targetLanguageCode ?? this.targetLanguageCode,
      estimatedLevel: estimatedLevel ?? this.estimatedLevel,
      goalIds: goalIds ?? this.goalIds,
      dailyMinutesGoal: dailyMinutesGoal ?? this.dailyMinutesGoal,
      wantsPlacementTest: wantsPlacementTest ?? this.wantsPlacementTest,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'interfaceLanguageCode': interfaceLanguageCode,
      'targetLanguageCode': targetLanguageCode,
      'estimatedLevel': estimatedLevel.code,
      'goalIds': goalIds,
      'dailyMinutesGoal': dailyMinutesGoal,
      'wantsPlacementTest': wantsPlacementTest,
      'isCompleted': isCompleted,
    };
  }

  String toEncodedJson() => jsonEncode(toJson());

  static OnboardingPreferences fromEncodedJson(String raw) {
    final Map<String, dynamic> decoded = jsonDecode(raw) as Map<String, dynamic>;
    return OnboardingPreferences.fromJson(decoded);
  }
}
