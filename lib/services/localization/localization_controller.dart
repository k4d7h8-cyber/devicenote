import 'package:devicenote/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'localization_preferences.dart';

class LocalizationController extends ChangeNotifier {
  LocalizationController._(this._preferences, this._locale);

  static const Locale fallbackLocale = Locale('en');
  static const List<Locale> supportedLocales =
      AppLocalizations.supportedLocales;

  final LocalizationPreferences _preferences;
  Locale _locale;

  Locale get locale => _locale;

  static Future<LocalizationController> create() async {
    final preferences = await LocalizationPreferences.create();
    final saved = preferences.savedLocaleCode;
    final initialLocale = _localeFromTag(saved) ?? fallbackLocale;
    return LocalizationController._(preferences, initialLocale);
  }

  bool isSupported(Locale locale) {
    for (final supported in supportedLocales) {
      if (_isSameLocale(supported, locale)) {
        return true;
      }
    }
    return false;
  }

  Future<void> setLocale(Locale locale) async {
    if (!isSupported(locale) || _isSameLocale(_locale, locale)) {
      return;
    }
    _locale = locale;
    await _preferences.setLocaleCode(locale.toLanguageTag());
    notifyListeners();
  }

  Future<void> resetToSystemLocale() async {
    if (_isSameLocale(_locale, fallbackLocale)) {
      return;
    }
    _locale = fallbackLocale;
    await _preferences.setLocaleCode(fallbackLocale.toLanguageTag());
    notifyListeners();
  }

  static bool _isSameLocale(Locale a, Locale b) {
    return a.languageCode == b.languageCode &&
        (a.countryCode ?? '') == (b.countryCode ?? '') &&
        (a.scriptCode ?? '') == (b.scriptCode ?? '');
  }

  static Locale? _localeFromTag(String? tag) {
    if (tag == null || tag.isEmpty) {
      return null;
    }
    for (final locale in supportedLocales) {
      if (locale.toLanguageTag() == tag) {
        return locale;
      }
      if (locale.languageCode == tag &&
          (locale.countryCode == null && locale.scriptCode == null)) {
        return locale;
      }
    }
    return null;
  }
}
