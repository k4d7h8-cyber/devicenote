import 'package:flutter/material.dart';

import 'localization_preferences.dart';

class LocalizationController extends ChangeNotifier {
  LocalizationController._(this._preferences);

  static const Locale fallbackLocale = Locale('en');
  static const List<Locale> supportedLocales = <Locale>[fallbackLocale];

  final LocalizationPreferences _preferences;
  Locale _locale = fallbackLocale;

  Locale get locale => _locale;

  static Future<LocalizationController> create() async {
    final preferences = await LocalizationPreferences.create();
    await preferences.setLocaleCode(fallbackLocale.toLanguageTag());
    return LocalizationController._(preferences);
  }

  bool isSupported(Locale locale) =>
      locale.languageCode == fallbackLocale.languageCode;

  Future<void> setLocale(Locale locale) async {
    if (_locale == fallbackLocale) return;
    _locale = fallbackLocale;
    await _preferences.setLocaleCode(fallbackLocale.toLanguageTag());
    notifyListeners();
  }

  Future<void> resetToSystemLocale() async {
    if (_locale == fallbackLocale) return;
    _locale = fallbackLocale;
    await _preferences.setLocaleCode(fallbackLocale.toLanguageTag());
    notifyListeners();
  }
}
