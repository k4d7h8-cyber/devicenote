// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'DeviceNote';

  @override
  String get bootPlaceholderMessage =>
      'Setup phase complete. Replace this screen with actual routes.';

  @override
  String get homeSettingsTooltip => 'Settings';

  @override
  String get homeSearchHint => 'Search';

  @override
  String get homeNoDevices => 'No registered devices';

  @override
  String get homeAddDeviceTooltip => 'Add device';

  @override
  String get homeDDayLabel => 'D-day';

  @override
  String homeDdayMonthsLabel(int months) {
    return 'D-$months m';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsNotificationsToggleTitle => 'Enable notifications';

  @override
  String get settingsNotificationsToggleEnabled =>
      'Warranty reminders will follow your preferences.';

  @override
  String get settingsNotificationsToggleDisabled =>
      'Turn on to receive reminders before warranties expire.';

  @override
  String get settingsReminderTimeLabel => 'Reminder time';

  @override
  String get settingsLanguageTitle => 'Language';

  @override
  String get settingsLanguagePickerTitle => 'Choose language';

  @override
  String get settingsBackupSectionTitle => 'Backup & Restore';

  @override
  String settingsVersionValue(String version) {
    return '$version';
  }

  @override
  String get languageEnglish => 'English';

  @override
  String get languageKorean => 'Korean';

  @override
  String get commonBackup => 'Backup';

  @override
  String get commonRestore => 'Restore';

  @override
  String settingsBackupSuccess(String fileName) {
    return 'Backup file $fileName is ready to share.';
  }

  @override
  String get settingsBackupFailure =>
      'Could not create a backup. Please try again.';

  @override
  String get settingsRestorePickerTitle => 'Choose a backup file';

  @override
  String get settingsRestoreInvalid =>
      'The selected file is not a valid DeviceNote backup.';

  @override
  String settingsRestoreResult(int added, int updated) {
    return 'Restore complete. Added $added, updated $updated.';
  }

  @override
  String settingsRestorePartial(int added, int updated, int failed) {
    return 'Restore partially completed. Added $added, updated $updated, failed $failed.';
  }

  @override
  String get settingsRestoreFailure => 'Restore failed. Please try again.';

  @override
  String get settingsRestoreRestartPrompt =>
      'Restart the app to apply the restored data.';

  @override
  String get settingsRestoreRestartNow => 'Restart now';

  @override
  String get settingsRestoreLater => 'Later';

  @override
  String get commonVersion => 'Version';

  @override
  String get commonSave => 'Save';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonEdit => 'Edit';

  @override
  String get addDeviceSavedMessage => 'Saved.';

  @override
  String addDevicePickImagesError(String error) {
    return 'Failed to pick images: $error';
  }

  @override
  String get addDeviceEditTitle => 'Edit device';

  @override
  String get addDeviceCreateTitle => 'Register device';

  @override
  String get addDeviceCategoryLabel => 'Category';

  @override
  String get addDeviceCategoryRequired => 'Category is required';

  @override
  String get addDeviceModelNameLabel => 'Model name';

  @override
  String get addDeviceModelNameRequired => 'Model name is required';

  @override
  String get addDeviceBrandLabel => 'Brand';

  @override
  String get addDeviceBrandRequired => 'Brand is required';

  @override
  String get addDeviceModelNumberLabel => 'Model number';

  @override
  String get addDeviceModelNumberRequired => 'Model number is required';

  @override
  String get addDevicePurchaseDateLabel => 'Purchase date';

  @override
  String get addDevicePurchaseDateHint => 'Pick a date';

  @override
  String get addDevicePurchaseDateRequired => 'Pick a purchase date';

  @override
  String get addDevicePurchaseDateFutureError =>
      'Purchase date cannot be in the future';

  @override
  String get addDeviceWarrantyLabel => 'Warranty (months)';

  @override
  String get addDeviceWarrantyHint => '0 ~ 120';

  @override
  String get addDeviceWarrantyRequired => 'Warranty is required';

  @override
  String get addDeviceDigitsOnly => 'Enter digits only';

  @override
  String get addDeviceWarrantyRange => 'Must be between 0 and 120';

  @override
  String get addDeviceCustomerCenterLabel => 'Customer center';

  @override
  String get addDeviceCustomerCenterHint => 'e.g. 1588-0000, 010-1234-5678';

  @override
  String get addDeviceCustomerCenterInvalid => 'Digits and - only';

  @override
  String get addDeviceOthersSectionTitle => 'Others';

  @override
  String get addDeviceTakePhoto => 'Take photo';

  @override
  String get addDeviceSelectFromGallery => 'Select from gallery';

  @override
  String get categoryTv => 'TV';

  @override
  String get categoryWasher => 'Washer';

  @override
  String get categoryComputer => 'Computer';

  @override
  String get categoryRefrigerator => 'Refrigerator';

  @override
  String get categoryAirConditioner => 'Air conditioner';

  @override
  String get categoryCar => 'Car';

  @override
  String get categoryOthers => 'Others';

  @override
  String get deviceDetailTitle => 'Device detail';

  @override
  String get deviceDetailNotFound => 'Device not found.';

  @override
  String get deviceDetailCategoryLabel => 'Category';

  @override
  String get deviceDetailBrandLabel => 'Brand';

  @override
  String get deviceDetailModelNameLabel => 'Model name';

  @override
  String get deviceDetailModelNumberLabel => 'Model number';

  @override
  String get deviceDetailPurchaseDateLabel => 'Purchase date';

  @override
  String get deviceDetailWarrantyLabel => 'Warranty (months)';

  @override
  String get deviceDetailCustomerCenterLabel => 'Customer center';

  @override
  String get deviceDetailNoContact => 'No customer center registered.';

  @override
  String deviceDetailCallButton(Object number) {
    return 'Call $number';
  }

  @override
  String get deviceDetailCallError => 'Unable to open the phone dialer.';

  @override
  String get deviceDetailNotificationsTitle => 'Warranty notifications';

  @override
  String deviceDetailNotificationsEnabled(String expiry) {
    return 'Reminders will be sent until $expiry.';
  }

  @override
  String get deviceDetailNotificationsDisabled =>
      'Turn on notifications in Settings to receive reminders.';

  @override
  String get deviceDetailPhotosSectionTitle => 'Photos';

  @override
  String get deviceDetailDeleteDialogTitle => 'Delete this device?';

  @override
  String get deviceDetailDeleteDialogMessage => 'This action cannot be undone.';

  @override
  String get notificationsGlobalEnabled => 'Warranty notifications enabled.';

  @override
  String get notificationsGlobalDisabled => 'Warranty notifications disabled.';

  @override
  String get notificationsEnableInSettings =>
      'Enable notifications in Settings to schedule alerts.';

  @override
  String get notificationsDeviceScheduled => 'Warranty reminders scheduled.';

  @override
  String get notificationsDeviceExpired => 'Warranty period already ended.';

  @override
  String get notificationsDeviceCancelled => 'Warranty reminders cancelled.';

  @override
  String get notificationsPermissionTitle => 'Allow notifications?';

  @override
  String get notificationsPermissionDescription =>
      'Enable push notifications to receive warranty reminders for your devices.';

  @override
  String get notificationsPermissionNotNow => 'Not now';

  @override
  String get notificationsPermissionAllow => 'Allow';

  @override
  String get notificationsPermissionDenied => 'Notification permission denied.';

  @override
  String cameraCaptureFailed(String error) {
    return 'Failed to capture photo: $error';
  }

  @override
  String get cameraTitle => 'Camera';

  @override
  String get cameraInitializationFailed => 'Failed to initialize the camera.';

  @override
  String homeDeviceBrandModel(String brand, String model) {
    return '$brand - $model';
  }

  @override
  String deviceDetailPhotoCounter(int current, int total) {
    return '$current / $total';
  }

  @override
  String get settingsVersionPlaceholder => '1.0.0 (placeholder)';

  @override
  String get languageBengali => 'Bengali';

  @override
  String get languageSpanish => 'Spanish';

  @override
  String get languageSpanishMexico => 'Spanish (Mexico)';

  @override
  String get languageHindi => 'Hindi';

  @override
  String get languageIndonesian => 'Indonesian';

  @override
  String get languagePortuguese => 'Portuguese';

  @override
  String get languagePortugueseBrazil => 'Portuguese (Brazil)';

  @override
  String get languageRussian => 'Russian';

  @override
  String get languageUrdu => 'Urdu';

  @override
  String get languageChinese => 'Chinese';

  @override
  String get languageChineseSimplified => 'Chinese (Simplified)';

  @override
  String get homeSearchNoResults => 'No devices match your search.';
}
