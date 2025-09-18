import 'package:shared_preferences/shared_preferences.dart';

class LocalizationPreference {
  static String languageKey = 'Language';

  static Future<void> saveLanguage(String language) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString(languageKey, language);
  }

  static Future<String> getLanguage() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(languageKey) ?? 'en';
  }
}
