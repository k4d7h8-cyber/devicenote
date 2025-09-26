import 'dart:ui';

import 'app_localizations.dart';

extension AppLocalizationsLocaleX on AppLocalizations {
  Locale get locale {
    final normalized = localeName.replaceAll('-', '_');
    final segments = normalized.split('_');
    final languageCode = segments.isNotEmpty && segments.first.isNotEmpty
        ? segments.first
        : 'en';
    String? scriptCode;
    String? countryCode;

    if (segments.length >= 2) {
      final second = segments[1];
      if (second.isNotEmpty) {
        if (second.length == 4) {
          scriptCode = second;
          if (segments.length >= 3 && segments[2].isNotEmpty) {
            countryCode = segments[2];
          }
        } else {
          countryCode = second;
          if (segments.length >= 3 && segments[2].isNotEmpty) {
            // Some locales may include scriptCode last when country provided second.
            scriptCode = segments[2].length == 4 ? segments[2] : scriptCode;
          }
        }
      }
    }

    if (segments.length >= 4 && segments[3].isNotEmpty) {
      // Fallback for language_script_country_region style tags.
      countryCode ??= segments[3];
    }

    return Locale.fromSubtags(
      languageCode: languageCode,
      scriptCode: scriptCode,
      countryCode: countryCode,
    );
  }
}
