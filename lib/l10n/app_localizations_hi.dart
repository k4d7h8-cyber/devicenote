// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'डिवाइस नोट';

  @override
  String get bootPlaceholderMessage =>
      'सेटअप चरण पूरा हो गया है। इस स्क्रीन को वास्तविक मार्गों से बदलें।';

  @override
  String get homeSettingsTooltip => 'सेटिंग्स';

  @override
  String get homeSearchHint => 'खोज';

  @override
  String get homeNoDevices => 'कोई पंजीकृत डिवाइस नहीं';

  @override
  String get homeAddDeviceTooltip => 'डिवाइस जोड़ें';

  @override
  String get homeDDayLabel => 'डी-डे';

  @override
  String homeDdayMonthsLabel(int months) {
    return 'डी-$months महीने';
  }

  @override
  String get settingsTitle => 'सेटिंग्स';

  @override
  String get settingsNotificationsToggleTitle => 'सूचनाएं सक्षम करें';

  @override
  String get settingsNotificationsToggleEnabled =>
      'वारंटी अनुस्मारक आपकी प्राथमिकताओं का पालन करेंगे।';

  @override
  String get settingsNotificationsToggleDisabled =>
      'वारंटी समाप्त होने से पहले अनुस्मारक प्राप्त करने के लिए चालू करें।';

  @override
  String get settingsReminderTimeLabel => 'अनुस्मारक समय';

  @override
  String get settingsLanguageTitle => 'भाषा';

  @override
  String get settingsLanguagePickerTitle => 'भाषा चुनें';

  @override
  String get settingsBackupSectionTitle => 'बैकअप और पुनर्स्थापना';

  @override
  String settingsVersionValue(String version) {
    return '$version';
  }

  @override
  String get languageEnglish => 'अंग्रेज़ी';

  @override
  String get languageKorean => 'कोरियाई';

  @override
  String get commonBackup => 'बैकअप';

  @override
  String get commonRestore => 'पुनर्स्थापना';

  @override
  String get commonVersion => 'संस्करण';

  @override
  String get commonSave => 'सहेजें';

  @override
  String get commonCancel => 'रद्द करें';

  @override
  String get commonDelete => 'मिटाएँ';

  @override
  String get commonEdit => 'संपादित करें';

  @override
  String get addDeviceSavedMessage => 'सहेजा गया।';

  @override
  String addDevicePickImagesError(String error) {
    return 'छवियां चुनने में विफल: $error';
  }

  @override
  String get addDeviceEditTitle => 'डिवाइस संपादित करें';

  @override
  String get addDeviceCreateTitle => 'डिवाइस जोड़ें';

  @override
  String get addDeviceCategoryLabel => 'श्रेणी';

  @override
  String get addDeviceCategoryRequired => 'श्रेणी आवश्यक है';

  @override
  String get addDeviceModelNameLabel => 'मॉडल नाम';

  @override
  String get addDeviceModelNameRequired => 'मॉडल नाम आवश्यक है';

  @override
  String get addDeviceBrandLabel => 'ब्रांड';

  @override
  String get addDeviceBrandRequired => 'ब्रांड आवश्यक है';

  @override
  String get addDeviceModelNumberLabel => 'मॉडल संख्या';

  @override
  String get addDeviceModelNumberRequired => 'मॉडल संख्या आवश्यक है';

  @override
  String get addDevicePurchaseDateLabel => 'खरीद की तारीख';

  @override
  String get addDevicePurchaseDateHint => 'एक तिथि चुनें';

  @override
  String get addDevicePurchaseDateRequired => 'खरीद की तारीख चुनें';

  @override
  String get addDevicePurchaseDateFutureError =>
      'खरीद की तारीख भविष्य में नहीं हो सकती';

  @override
  String get addDeviceWarrantyLabel => 'वारंटी (महीने)';

  @override
  String get addDeviceWarrantyHint => '0 ~ 120';

  @override
  String get addDeviceWarrantyRequired => 'वारंटी आवश्यक है';

  @override
  String get addDeviceDigitsOnly => 'केवल अंक दर्ज करें';

  @override
  String get addDeviceWarrantyRange => '0 से 120 के बीच होना चाहिए';

  @override
  String get addDeviceCustomerCenterLabel => 'ग्राहक केंद्र';

  @override
  String get addDeviceCustomerCenterHint => 'उदा. 1588-0000, 010-1234-5678';

  @override
  String get addDeviceCustomerCenterInvalid => 'केवल अंक और -';

  @override
  String get addDeviceOthersSectionTitle => 'अन्य';

  @override
  String get addDeviceTakePhoto => 'फोटो लें';

  @override
  String get addDeviceSelectFromGallery => 'गैलरी से चुनें';

  @override
  String get categoryTv => 'टीवी';

  @override
  String get categoryWasher => 'वाशर';

  @override
  String get categoryComputer => 'कंप्यूटर';

  @override
  String get categoryRefrigerator => 'रेफ्रिजरेटर';

  @override
  String get categoryAirConditioner => 'एयर कंडीशनर';

  @override
  String get categoryCar => 'कार';

  @override
  String get categoryOthers => 'अन्य';

  @override
  String get deviceDetailTitle => 'डिवाइस विवरण';

  @override
  String get deviceDetailNotFound => 'डिवाइस नहीं मिला।';

  @override
  String get deviceDetailCategoryLabel => 'श्रेणी';

  @override
  String get deviceDetailBrandLabel => 'ब्रांड';

  @override
  String get deviceDetailModelNameLabel => 'मॉडल नाम';

  @override
  String get deviceDetailModelNumberLabel => 'मॉडल संख्या';

  @override
  String get deviceDetailPurchaseDateLabel => 'खरीद की तारीख';

  @override
  String get deviceDetailWarrantyLabel => 'वारंटी (महीने)';

  @override
  String get deviceDetailCustomerCenterLabel => 'ग्राहक केंद्र';

  @override
  String get deviceDetailNoContact => 'कोई ग्राहक केंद्र पंजीकृत नहीं है।';

  @override
  String deviceDetailCallButton(Object number) {
    return 'कॉल करें $number';
  }

  @override
  String get deviceDetailCallError => 'फ़ोन डायलर खोलने में असमर्थ।';

  @override
  String get deviceDetailNotificationsTitle => 'वारंटी सूचनाएं';

  @override
  String deviceDetailNotificationsEnabled(String expiry) {
    return 'अनुस्मारक $expiry तक भेजे जाएंगे।';
  }

  @override
  String get deviceDetailNotificationsDisabled =>
      'अनुस्मारक प्राप्त करने के लिए सेटिंग्स में सूचनाएं चालू करें।';

  @override
  String get deviceDetailPhotosSectionTitle => 'तस्वीरें';

  @override
  String get deviceDetailDeleteDialogTitle => 'इस डिवाइस को हटा दें?';

  @override
  String get deviceDetailDeleteDialogMessage =>
      'यह कार्रवाई पूर्ववत नहीं की जा सकती।';

  @override
  String get notificationsGlobalEnabled => 'वारंटी सूचनाएं सक्षम हैं।';

  @override
  String get notificationsGlobalDisabled => 'वारंटी सूचनाएं अक्षम हैं।';

  @override
  String get notificationsEnableInSettings =>
      'अलर्ट शेड्यूल करने के लिए सेटिंग्स में सूचनाएं सक्षम करें।';

  @override
  String get notificationsDeviceScheduled => 'वारंटी अनुस्मारक निर्धारित हैं।';

  @override
  String get notificationsDeviceExpired =>
      'वारंटी अवधि पहले ही समाप्त हो गई है।';

  @override
  String get notificationsDeviceCancelled =>
      'वारंटी अनुस्मारक रद्द कर दिए गए हैं।';

  @override
  String get notificationsPermissionTitle => 'सूचनाओं की अनुमति दें?';

  @override
  String get notificationsPermissionDescription =>
      'अपने डिवाइस के लिए वारंटी अनुस्मारक प्राप्त करने के लिए पुश सूचनाएं सक्षम करें।';

  @override
  String get notificationsPermissionNotNow => 'अभी नहीं';

  @override
  String get notificationsPermissionAllow => 'अनुमति दें';

  @override
  String get notificationsPermissionDenied =>
      'सूचना की अनुमति अस्वीकार कर दी गई।';

  @override
  String cameraCaptureFailed(String error) {
    return 'फोटो लेने में विफल: $error';
  }

  @override
  String get cameraTitle => 'कैमरा';

  @override
  String get cameraInitializationFailed => 'कैमरा प्रारंभ करने में विफल।';

  @override
  String homeDeviceBrandModel(String brand, String model) {
    return '$brand - $model';
  }

  @override
  String deviceDetailPhotoCounter(int current, int total) {
    return '$current / $total';
  }

  @override
  String get settingsVersionPlaceholder => 'TODO: version';

  @override
  String get languageBengali => 'TODO: Bengali';

  @override
  String get languageSpanish => 'TODO: Spanish';

  @override
  String get languageSpanishMexico => 'TODO: Spanish (Mexico)';

  @override
  String get languageHindi => 'TODO: Hindi';

  @override
  String get languageIndonesian => 'TODO: Indonesian';

  @override
  String get languagePortuguese => 'TODO: Portuguese';

  @override
  String get languagePortugueseBrazil => 'TODO: Portuguese (Brazil)';

  @override
  String get languageRussian => 'TODO: Russian';

  @override
  String get languageUrdu => 'TODO: Urdu';

  @override
  String get languageChinese => 'TODO: Chinese';

  @override
  String get languageChineseSimplified => 'TODO: Chinese (Simplified)';
}
