import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'localization_controller.dart';

/// Holds the currently selected [Locale] for the application.
/// Defaults to [LocalizationController.fallbackLocale].
final appLocaleProvider = StateProvider<Locale>(
  (ref) => LocalizationController.fallbackLocale,
);

/// Updates the global app locale.
void setAppLocale(WidgetRef ref, Locale locale) {
  ref.read(appLocaleProvider.notifier).state = locale;
}
