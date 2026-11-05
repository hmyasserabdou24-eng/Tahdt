/// Standardized application exception with user-safe messages and error codes.
class AppException implements Exception {
  const AppException({
    required this.message,
    this.code = 'unknown_error',
    this.isConfigurationMissing = false,
  });

  final String message;
  final String code;
  final bool isConfigurationMissing;

  @override
  String toString() => 'AppException($code): $message';
}
