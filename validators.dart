/// Form and input validation utilities for authentication and profile inputs.
class Validators {
  const Validators._();

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static String? validateEmail(String? value, {required String requiredMsg, required String invalidMsg}) {
    final String trimmed = (value ?? '').trim();
    if (trimmed.isEmpty) {
      return requiredMsg;
    }
    if (!_emailRegex.hasMatch(trimmed)) {
      return invalidMsg;
    }
    return null;
  }

  static String? validatePassword(
    String? value, {
    required String requiredMsg,
    required String tooShortMsg,
    required String complexityMsg,
  }) {
    final String raw = value ?? '';
    if (raw.isEmpty) {
      return requiredMsg;
    }
    if (raw.length < 8) {
      return tooShortMsg;
    }
    final bool hasLetter = RegExp(r'[A-Za-z]').hasMatch(raw);
    final bool hasDigit = RegExp(r'[0-9]').hasMatch(raw);
    if (!hasLetter || !hasDigit) {
      return complexityMsg;
    }
    return null;
  }

  static String? validateFullName(String? value, {required String requiredMsg}) {
    final String trimmed = (value ?? '').trim();
    if (trimmed.length < 2) {
      return requiredMsg;
    }
    return null;
  }
}
