import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final Provider<SecureStorageService> secureStorageServiceProvider =
    Provider<SecureStorageService>((Ref ref) {
  return const SecureStorageService(
    FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    ),
  );
});

/// Encrypted key-value storage wrapper for sensitive local session metadata.
class SecureStorageService {
  const SecureStorageService(this._storage);

  final FlutterSecureStorage _storage;

  static const String _keyLastActiveEmail = 'tadahhath_last_active_email';

  Future<void> saveLastActiveEmail(String email) async {
    await _storage.write(key: _keyLastActiveEmail, value: email);
  }

  Future<String?> readLastActiveEmail() async {
    return _storage.read(key: _keyLastActiveEmail);
  }

  Future<void> clearSessionMetadata() async {
    await _storage.delete(key: _keyLastActiveEmail);
  }
}
