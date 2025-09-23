// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appTitle => 'ڈيوائس نوٹ';

  @override
  String get bootPlaceholderMessage =>
      'سیٹ اپ مرحلہ مکمل ہو گیا۔ اسکرین کو اصل روٹس سے تبدیل کریں۔';

  @override
  String get homeSettingsTooltip => 'سیٹنگز';

  @override
  String get homeSearchHint => 'تلاش';

  @override
  String get homeNoDevices => 'کوئی رجسٹرڈ ڈیوائس نہیں';

  @override
  String get homeAddDeviceTooltip => 'ڈیوائس شامل کریں';

  @override
  String get homeDDayLabel => 'D-day';

  @override
  String homeDdayMonthsLabel(int months) {
    return 'D-$months ماہ';
  }

  @override
  String get settingsTitle => 'سیٹنگز';

  @override
  String get settingsNotificationsToggleTitle => 'اطلاعات فعال کریں';

  @override
  String get settingsNotificationsToggleEnabled =>
      'وارنٹی یاددہانی آپ کی ترجیحات پر عمل کریں گی۔';

  @override
  String get settingsNotificationsToggleDisabled =>
      'وارنٹی ختم ہونے سے پہلے یاددہانی حاصل کرنے کے لیے آن کریں۔';

  @override
  String get settingsReminderTimeLabel => 'یاددہانی کا وقت';

  @override
  String get settingsLanguageTitle => 'زبان';

  @override
  String get settingsLanguagePickerTitle => 'زبان منتخب کریں';

  @override
  String get settingsBackupSectionTitle => 'بیک اپ اور بحالی';

  @override
  String settingsVersionValue(String version) {
    return '$version';
  }

  @override
  String get languageEnglish => 'انگریزی';

  @override
  String get languageKorean => 'کورین';

  @override
  String get commonBackup => 'بیک اپ';

  @override
  String get commonRestore => 'بحال کریں';

  @override
  String get commonVersion => 'ورژن';

  @override
  String get commonSave => 'محفوظ کریں';

  @override
  String get commonCancel => 'منسوخ کریں';

  @override
  String get commonDelete => 'حذف کریں';

  @override
  String get commonEdit => 'ترمیم کریں';

  @override
  String get addDeviceSavedMessage => 'محفوظ ہو گیا۔';

  @override
  String addDevicePickImagesError(String error) {
    return 'تصاویر منتخب کرنے میں ناکام: $error';
  }

  @override
  String get addDeviceEditTitle => 'ڈیوائس میں ترمیم کریں';

  @override
  String get addDeviceCreateTitle => 'ڈیوائس شامل کریں';

  @override
  String get addDeviceCategoryLabel => 'زمرہ';

  @override
  String get addDeviceCategoryRequired => 'زمرہ درکار ہے';

  @override
  String get addDeviceModelNameLabel => 'ماڈل کا نام';

  @override
  String get addDeviceModelNameRequired => 'ماڈل کا نام درکار ہے';

  @override
  String get addDeviceBrandLabel => 'برانڈ';

  @override
  String get addDeviceBrandRequired => 'برانڈ درکار ہے';

  @override
  String get addDeviceModelNumberLabel => 'ماڈل نمبر';

  @override
  String get addDeviceModelNumberRequired => 'ماڈل نمبر درکار ہے';

  @override
  String get addDevicePurchaseDateLabel => 'خریداری کی تاریخ';

  @override
  String get addDevicePurchaseDateHint => 'ایک تاریخ منتخب کریں';

  @override
  String get addDevicePurchaseDateRequired => 'خریداری کی تاریخ منتخب کریں';

  @override
  String get addDevicePurchaseDateFutureError =>
      'خریداری کی تاریخ مستقبل میں نہیں ہو سکتی';

  @override
  String get addDeviceWarrantyLabel => 'وارنٹی (ماہ)';

  @override
  String get addDeviceWarrantyHint => '0 ~ 120';

  @override
  String get addDeviceWarrantyRequired => 'وارنٹی درکار ہے';

  @override
  String get addDeviceDigitsOnly => 'صرف ہندسے درج کریں';

  @override
  String get addDeviceWarrantyRange => '0 اور 120 کے درمیان ہونا چاہیے';

  @override
  String get addDeviceCustomerCenterLabel => 'کسٹمر سینٹر';

  @override
  String get addDeviceCustomerCenterHint => 'جیسے 1588-0000, 010-1234-5678';

  @override
  String get addDeviceCustomerCenterInvalid => 'صرف ہندسے اور -';

  @override
  String get addDeviceOthersSectionTitle => 'دیگر';

  @override
  String get addDeviceTakePhoto => 'تصویر کھینچیں';

  @override
  String get addDeviceSelectFromGallery => 'گیلری سے منتخب کریں';

  @override
  String get categoryTv => 'ٹی وی';

  @override
  String get categoryWasher => 'واشر';

  @override
  String get categoryComputer => 'کمپیوٹر';

  @override
  String get categoryRefrigerator => 'ریفریجریٹر';

  @override
  String get categoryAirConditioner => 'ایئر کنڈیشنر';

  @override
  String get categoryCar => 'کار';

  @override
  String get categoryOthers => 'دیگر';

  @override
  String get deviceDetailTitle => 'ڈیوائس کی تفصیل';

  @override
  String get deviceDetailNotFound => 'ڈیوائس نہیں ملا۔';

  @override
  String get deviceDetailCategoryLabel => 'زمرہ';

  @override
  String get deviceDetailBrandLabel => 'برانڈ';

  @override
  String get deviceDetailModelNameLabel => 'ماڈل کا نام';

  @override
  String get deviceDetailModelNumberLabel => 'ماڈل نمبر';

  @override
  String get deviceDetailPurchaseDateLabel => 'خریداری کی تاریخ';

  @override
  String get deviceDetailWarrantyLabel => 'وارنٹی (ماہ)';

  @override
  String get deviceDetailCustomerCenterLabel => 'کسٹمر سینٹر';

  @override
  String get deviceDetailNoContact => 'کوئی کسٹمر سینٹر رجسٹرڈ نہیں ہے۔';

  @override
  String deviceDetailCallButton(Object number) {
    return 'کال کریں $number';
  }

  @override
  String get deviceDetailCallError => 'فون ڈائلر کھولنے میں ناکام۔';

  @override
  String get deviceDetailNotificationsTitle => 'وارنٹی کی اطلاعات';

  @override
  String deviceDetailNotificationsEnabled(String expiry) {
    return 'یاددہانی $expiry تک بھیجی جائیں گی۔';
  }

  @override
  String get deviceDetailNotificationsDisabled =>
      'یاددہانی حاصل کرنے کے لیے سیٹنگز میں اطلاعات آن کریں۔';

  @override
  String get deviceDetailPhotosSectionTitle => 'تصاویر';

  @override
  String get deviceDetailDeleteDialogTitle => 'اس ڈیوائس کو حذف کریں؟';

  @override
  String get deviceDetailDeleteDialogMessage =>
      'اس کارروائی کو کالعدم نہیں کیا جا سکتا۔';

  @override
  String get notificationsGlobalEnabled => 'وارنٹی کی اطلاعات فعال ہیں۔';

  @override
  String get notificationsGlobalDisabled => 'وارنٹی کی اطلاعات غیر فعال ہیں۔';

  @override
  String get notificationsEnableInSettings =>
      'الرٹس کا شیڈول کرنے کے لیے سیٹنگز میں اطلاعات فعال کریں۔';

  @override
  String get notificationsDeviceScheduled =>
      'وارنٹی یاددہانی شیڈول کی گئی ہیں۔';

  @override
  String get notificationsDeviceExpired =>
      'وارنٹی کی مدت پہلے ہی ختم ہو چکی ہے۔';

  @override
  String get notificationsDeviceCancelled =>
      'وارنٹی یاددہانی منسوخ کر دی گئی ہیں۔';

  @override
  String get notificationsPermissionTitle => 'اطلاعات کی اجازت دیں؟';

  @override
  String get notificationsPermissionDescription =>
      'اپنے ڈیوائسز کے لیے وارنٹی یاددہانی حاصل کرنے کے لیے پش اطلاعات فعال کریں۔';

  @override
  String get notificationsPermissionNotNow => 'ابھی نہیں';

  @override
  String get notificationsPermissionAllow => 'اجازت دیں';

  @override
  String get notificationsPermissionDenied => 'اطلاع کی اجازت مسترد کر دی گئی۔';

  @override
  String cameraCaptureFailed(String error) {
    return 'تصویر لینے میں ناکام: $error';
  }

  @override
  String get cameraTitle => 'کیمرہ';

  @override
  String get cameraInitializationFailed => 'کیمرہ کو شروع کرنے میں ناکام۔';
}
