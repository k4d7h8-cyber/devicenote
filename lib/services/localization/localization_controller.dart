import 'package:flutter/material.dart';

import 'localization_preferences.dart';

class LocalizationController extends ChangeNotifier {
  LocalizationController._(this._preferences, this._locale);

  static const Locale fallbackLocale = Locale('en');
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ko'),
  ];

  final LocalizationPreferences _preferences;
  Locale _locale;

  Locale get locale => _locale;

  static Future<LocalizationController> create() async {
    final preferences = await LocalizationPreferences.create();
    final storedCode = preferences.savedLocaleCode;
    Locale? locale;
    if (storedCode != null) {
      locale = _parseLocale(storedCode);
    }
    locale ??= _resolveSupportedLocale(
      WidgetsBinding.instance.platformDispatcher.locale,
    );
    locale ??= fallbackLocale;
    return LocalizationController._(preferences, locale);
  }

  static Locale? _parseLocale(String code) {
    if (code.trim().isEmpty) return null;
    final segments = code.split('-');
    if (segments.isEmpty) return null;
    if (segments.length == 1) {
      return Locale(segments.first);
    }
    return Locale(segments.first, segments.sublist(1).join('-'));
  }

  static Locale? _resolveSupportedLocale(Locale? deviceLocale) {
    if (deviceLocale == null) return null;
    for (final locale in supportedLocales) {
      if (locale.languageCode == deviceLocale.languageCode &&
          locale.countryCode == deviceLocale.countryCode) {
        return locale;
      }
    }
    for (final locale in supportedLocales) {
      if (locale.languageCode == deviceLocale.languageCode) {
        return locale;
      }
    }
    return null;
  }

  bool isSupported(Locale locale) {
    return supportedLocales.any(
      (supported) => supported.languageCode == locale.languageCode,
    );
  }

  Future<void> setLocale(Locale locale) async {
    if (!isSupported(locale)) {
      locale = fallbackLocale;
    }
    if (_locale == locale) return;
    _locale = locale;
    await _preferences.setLocaleCode(locale.toLanguageTag());
    notifyListeners();
  }

  Future<void> resetToSystemLocale() async {
    final resolved = _resolveSupportedLocale(
      WidgetsBinding.instance.platformDispatcher.locale,
    );
    final locale = resolved ?? fallbackLocale;
    _locale = locale;
    await _preferences.setLocaleCode(locale.toLanguageTag());
    notifyListeners();
  }
}
