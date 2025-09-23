// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hausa (`ha`).
class AppLocalizationsHa extends AppLocalizations {
  AppLocalizationsHa([String locale = 'ha']) : super(locale);

  @override
  String get appTitle => 'DeviceNote';

  @override
  String get bootPlaceholderMessage =>
      'An gama matakin saiti. Sauya wannan allon da ainihin hanyoyin.';

  @override
  String get homeSettingsTooltip => 'Saiti';

  @override
  String get homeSearchHint => 'Bincika';

  @override
  String get homeNoDevices => 'Babu na’urori da aka yi rijista';

  @override
  String get homeAddDeviceTooltip => 'Ƙara na’ura';

  @override
  String get homeDDayLabel => 'D-day';

  @override
  String homeDdayMonthsLabel(int months) {
    return 'D-$months watanni';
  }

  @override
  String get settingsTitle => 'Saiti';

  @override
  String get settingsNotificationsToggleTitle => 'Kunna sanarwa';

  @override
  String get settingsNotificationsToggleEnabled =>
      'Tunatarwa na garanti za su bi abubuwan da kuke so.';

  @override
  String get settingsNotificationsToggleDisabled =>
      'Kunna don karɓar tunatarwa kafin garanti ya ƙare.';

  @override
  String get settingsReminderTimeLabel => 'Lokacin tunatarwa';

  @override
  String get settingsLanguageTitle => 'Harshe';

  @override
  String get settingsLanguagePickerTitle => 'Zaɓi harshe';

  @override
  String get settingsBackupSectionTitle => 'Adana & Dawo';

  @override
  String settingsVersionValue(String version) {
    return '$version';
  }

  @override
  String get languageEnglish => 'Turanci';

  @override
  String get languageKorean => 'Koriya';

  @override
  String get commonBackup => 'Adana';

  @override
  String get commonRestore => 'Dawo';

  @override
  String get commonVersion => 'Sigar';

  @override
  String get commonSave => 'Ajiye';

  @override
  String get commonCancel => 'Soke';

  @override
  String get commonDelete => 'Share';

  @override
  String get commonEdit => 'Gyara';

  @override
  String get addDeviceSavedMessage => 'An adana.';

  @override
  String addDevicePickImagesError(String error) {
    return 'An kasa zaɓar hotuna: $error';
  }

  @override
  String get addDeviceEditTitle => 'Gyara na’ura';

  @override
  String get addDeviceCreateTitle => 'Ƙara na’ura';

  @override
  String get addDeviceCategoryLabel => 'Nau\'i';

  @override
  String get addDeviceCategoryRequired => 'Nau\'i yana da mahimmanci';

  @override
  String get addDeviceModelNameLabel => 'Sunan samfurin';

  @override
  String get addDeviceModelNameRequired => 'Sunan samfurin yana da mahimmanci';

  @override
  String get addDeviceBrandLabel => 'Alama';

  @override
  String get addDeviceBrandRequired => 'Alama yana da mahimmanci';

  @override
  String get addDeviceModelNumberLabel => 'Lambar samfurin';

  @override
  String get addDeviceModelNumberRequired =>
      'Lambar samfurin yana da mahimmanci';

  @override
  String get addDevicePurchaseDateLabel => 'Ranar siyayya';

  @override
  String get addDevicePurchaseDateHint => 'Zaɓi wata rana';

  @override
  String get addDevicePurchaseDateRequired => 'Zaɓi ranar siyayya';

  @override
  String get addDevicePurchaseDateFutureError =>
      'Ranar siyayya ba za ta iya kasancewa a gaba ba';

  @override
  String get addDeviceWarrantyLabel => 'Garanti (watanni)';

  @override
  String get addDeviceWarrantyHint => '0 ~ 120';

  @override
  String get addDeviceWarrantyRequired => 'Garanti yana da mahimmanci';

  @override
  String get addDeviceDigitsOnly => 'Shigar da lambobi kawai';

  @override
  String get addDeviceWarrantyRange => 'Dole ne ya kasance tsakanin 0 zuwa 120';

  @override
  String get addDeviceCustomerCenterLabel => 'Cibiyar abokin ciniki';

  @override
  String get addDeviceCustomerCenterHint => 'misali 1588-0000, 010-1234-5678';

  @override
  String get addDeviceCustomerCenterInvalid => 'Lambobi da - kawai';

  @override
  String get addDeviceOthersSectionTitle => 'Wasu';

  @override
  String get addDeviceTakePhoto => 'Ɗauki hoto';

  @override
  String get addDeviceSelectFromGallery => 'Zaɓi daga gallery';

  @override
  String get categoryTv => 'TV';

  @override
  String get categoryWasher => 'Injin wanki';

  @override
  String get categoryComputer => 'Kwamfuta';

  @override
  String get categoryRefrigerator => 'Firiji';

  @override
  String get categoryAirConditioner => 'Mai sanyaya iska';

  @override
  String get categoryCar => 'Mota';

  @override
  String get categoryOthers => 'Wasu';

  @override
  String get deviceDetailTitle => 'Cikakkun bayanai na na\'ura';

  @override
  String get deviceDetailNotFound => 'Ba a sami na’ura ba.';

  @override
  String get deviceDetailCategoryLabel => 'Nau\'i';

  @override
  String get deviceDetailBrandLabel => 'Alama';

  @override
  String get deviceDetailModelNameLabel => 'Sunan samfurin';

  @override
  String get deviceDetailModelNumberLabel => 'Lambar samfurin';

  @override
  String get deviceDetailPurchaseDateLabel => 'Ranar siyayya';

  @override
  String get deviceDetailWarrantyLabel => 'Garanti (watanni)';

  @override
  String get deviceDetailCustomerCenterLabel => 'Cibiyar abokin ciniki';

  @override
  String get deviceDetailNoContact =>
      'Babu cibiyar abokin ciniki da aka yi rijista.';

  @override
  String deviceDetailCallButton(Object number) {
    return 'Kira $number';
  }

  @override
  String get deviceDetailCallError => 'Ba a iya buɗe na\'urar kiran waya ba.';

  @override
  String get deviceDetailNotificationsTitle => 'Sanarwa na garanti';

  @override
  String deviceDetailNotificationsEnabled(String expiry) {
    return 'Za a aika tunatarwa har zuwa $expiry.';
  }

  @override
  String get deviceDetailNotificationsDisabled =>
      'Kunna sanarwa a cikin Saiti don karɓar tunatarwa.';

  @override
  String get deviceDetailPhotosSectionTitle => 'Hotuna';

  @override
  String get deviceDetailDeleteDialogTitle => 'Share wannan na’urar?';

  @override
  String get deviceDetailDeleteDialogMessage =>
      'Wannan aikin ba za a iya soke shi ba.';

  @override
  String get notificationsGlobalEnabled => 'An kunna sanarwar garanti.';

  @override
  String get notificationsGlobalDisabled => 'An kashe sanarwar garanti.';

  @override
  String get notificationsEnableInSettings =>
      'Kunna sanarwa a cikin Saiti don tsara faɗakarwa.';

  @override
  String get notificationsDeviceScheduled => 'An tsara tunatarwar garanti.';

  @override
  String get notificationsDeviceExpired => 'Lokacin garanti ya riga ya ƙare.';

  @override
  String get notificationsDeviceCancelled => 'An soke tunatarwar garanti.';

  @override
  String get notificationsPermissionTitle => 'Bada izinin sanarwa?';

  @override
  String get notificationsPermissionDescription =>
      'Kunna sanarwar turawa don karɓar tunatarwar garanti ga na\'urorinku.';

  @override
  String get notificationsPermissionNotNow => 'Ba yanzu ba';

  @override
  String get notificationsPermissionAllow => 'Bada izini';

  @override
  String get notificationsPermissionDenied => 'An ƙi izinin sanarwa.';

  @override
  String cameraCaptureFailed(String error) {
    return 'An kasa ɗaukar hoto: $error';
  }

  @override
  String get cameraTitle => 'Kyamara';

  @override
  String get cameraInitializationFailed => 'An kasa fara kyamara.';
}
