import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    as riverpod
    show WidgetRef;
import 'package:flutter_riverpod/legacy.dart' as riverpod show StateProvider;

import 'localization_controller.dart';

/// Holds the currently selected [Locale] for the application.
/// Defaults to [LocalizationController.fallbackLocale].
final appLocaleProvider = riverpod.StateProvider<Locale>(
  (ref) => LocalizationController.fallbackLocale,
);

/// Updates the global app locale.
void setAppLocale(riverpod.WidgetRef ref, Locale locale) {
  ref.read(appLocaleProvider.notifier).state = locale;
}
