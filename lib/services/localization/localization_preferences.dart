import 'package:shared_preferences/shared_preferences.dart';

class LocalizationPreferences {
  LocalizationPreferences._(this._prefs);

  static const _keyLocale = 'app_locale_code';

  final SharedPreferences _prefs;

  static Future<LocalizationPreferences> create() async {
    final prefs = await SharedPreferences.getInstance();
    return LocalizationPreferences._(prefs);
  }

  String? get savedLocaleCode => _prefs.getString(_keyLocale);

  Future<void> setLocaleCode(String? code) async {
    if (code == null || code.isEmpty) {
      await _prefs.remove(_keyLocale);
    } else {
      await _prefs.setString(_keyLocale, code);
    }
  }
}
