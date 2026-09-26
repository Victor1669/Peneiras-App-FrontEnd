import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageHelper {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<void> setString(String key, String value) async {
    await _storage.write(
      key: key,
      value: value,
    );
  }

  static Future<String?> getString(String key) async {
    return await _storage.read(
      key: key,
    );
  }

  static Future<void> remove(String key) async {
    await _storage.delete(
      key: key,
    );
  }

  static Future<void> clear() async {
    await _storage.deleteAll();
  }
}
