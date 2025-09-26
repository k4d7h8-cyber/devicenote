// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appTitle => 'ডিভাইস নোট';

  @override
  String get bootPlaceholderMessage =>
      'Setup phase complete. Replace this screen with actual routes.';

  @override
  String get homeSettingsTooltip => 'সেটিংস';

  @override
  String get homeSearchHint => 'অনুসন্ধান করুন';

  @override
  String get homeNoDevices => 'কোনো ডিভাইস নিবন্ধিত নেই';

  @override
  String get homeAddDeviceTooltip => 'ডিভাইস যোগ করুন';

  @override
  String get homeDDayLabel => 'D-day';

  @override
  String homeDdayMonthsLabel(int months) {
    return 'D-$months m';
  }

  @override
  String get settingsTitle => 'সেটিংস';

  @override
  String get settingsNotificationsToggleTitle => 'নোটিফিকেশন সক্রিয় করুন';

  @override
  String get settingsNotificationsToggleEnabled =>
      'গ্যারান্টির স্মরণ করিয়ে দেওয়া আপনার পছন্দ অনুসারে পাঠানো হবে।';

  @override
  String get settingsNotificationsToggleDisabled =>
      'গ্যারান্টি শেষ হওয়ার আগে স্মরণ পেতে চালু করুন।';

  @override
  String get settingsReminderTimeLabel => 'স্মরণ করিয়ে দেওয়ার সময়';

  @override
  String get settingsLanguageTitle => 'ভাষা';

  @override
  String get settingsLanguagePickerTitle => 'ভাষা নির্বাচন করুন';

  @override
  String get settingsBackupSectionTitle => 'ব্যাকআপ ও পুনরুদ্ধার';

  @override
  String settingsVersionValue(String version) {
    return '$version';
  }

  @override
  String get languageEnglish => 'English';

  @override
  String get languageKorean => 'Korean';

  @override
  String get commonBackup => 'ব্যাকআপ';

  @override
  String get commonRestore => 'পুনরুদ্ধার';

  @override
  String get commonVersion => 'সংস্করণ';

  @override
  String get commonSave => 'সংরক্ষণ করুন';

  @override
  String get commonCancel => 'বাতিল করুন';

  @override
  String get commonDelete => 'মুছে ফেলুন';

  @override
  String get commonEdit => 'সম্পাদনা করুন';

  @override
  String get addDeviceSavedMessage => 'Saved.';

  @override
  String addDevicePickImagesError(String error) {
    return 'Failed to pick images: $error';
  }

  @override
  String get addDeviceEditTitle => 'Edit device';

  @override
  String get addDeviceCreateTitle => 'Add device';

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
  String get settingsVersionPlaceholder => '1.0.0 (প্লেসহোল্ডার)';

  @override
  String get languageBengali => 'বাংলা';

  @override
  String get languageSpanish => 'স্প্যানিশ';

  @override
  String get languageSpanishMexico => 'স্প্যানিশ (মেক্সিকো)';

  @override
  String get languageHindi => 'হিন্দি';

  @override
  String get languageIndonesian => 'ইন্দোনেশীয়';

  @override
  String get languagePortuguese => 'পর্তুগিজ';

  @override
  String get languagePortugueseBrazil => 'পর্তুগিজ (ব্রাজিল)';

  @override
  String get languageRussian => 'রুশ';

  @override
  String get languageUrdu => 'উর্দু';

  @override
  String get languageChinese => 'চীনা';

  @override
  String get languageChineseSimplified => 'চীনা (সরলীকৃত)';
}
