import 'package:flower_app/core/contants/secure_storage.dart';

class GuestService {
  static const String guestIdKey = 'guest_id';
  static const String guestSessionKey = 'guest_session';

  static Future<void> startGuestSession() async {
    final guestId = 'guest_${DateTime.now().millisecondsSinceEpoch}';
    final sessionToken = 'session_${DateTime.now().toIso8601String()}';

    await SecureStorage.write(key: guestIdKey, value: guestId);
    await SecureStorage.write(key: guestSessionKey, value: sessionToken);
  }

  static Future<bool> isGuest() async {
    final guestId = await SecureStorage.read(guestIdKey);
    return guestId != null && guestId.isNotEmpty;
  }

  static Future<String?> getGuestId() async {
    return await SecureStorage.read(guestIdKey);
  }

  static Future<void> endGuestSession() async {
    await SecureStorage.delete(guestIdKey);
    await SecureStorage.delete(guestSessionKey);
  }
}