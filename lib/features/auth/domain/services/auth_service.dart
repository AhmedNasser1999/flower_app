import '../../../../core/contants/secure_storage.dart';

class AuthService {
  static const String tokenKey = 'auth_token';
  static const String userIdKey = 'user_id';

  static Future<void> saveAuthToken(String token) async {
    await SecureStorage.write(key: tokenKey, value: token);
  }

  static Future<void> saveUserId(String userId) async {
    await SecureStorage.write(key: userIdKey, value: userId);
  }

  static Future<bool> isLoggedIn() async {
    final token = await SecureStorage.read(tokenKey);
    return token != null && token.isNotEmpty;
  }

  static Future<String?> getUserId() async {
    return await SecureStorage.read(userIdKey);
  }

  static Future<String?> getToken() async {
    return await SecureStorage.read(tokenKey);
  }

  static Future<void> logout() async {
    await SecureStorage.delete(tokenKey);
    await SecureStorage.delete(userIdKey);
  }
}