/// Domain representation of an authenticated TADAHHATH AI learner.
class AuthUserModel {
  const AuthUserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.createdAt,
    this.avatarUrl,
  });

  final String id;
  final String email;
  final String fullName;
  final DateTime createdAt;
  final String? avatarUrl;
}
