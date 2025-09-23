import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Holds the currently selected language code for the application.
/// Defaults to English (`en`).
final languageCodeProvider = StateProvider<String>((ref) => 'en');

/// Updates the global language code.
void setLanguageCode(WidgetRef ref, String languageCode) {
  ref.read(languageCodeProvider.notifier).state = languageCode;
}
