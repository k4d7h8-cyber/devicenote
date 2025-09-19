// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => '??????';

  @override
  String get bootPlaceholderMessage => '?? ??? ???????. ? ??? ?? ???? ?????.';

  @override
  String get homeSettingsTooltip => '??';

  @override
  String get homeSearchHint => '??';

  @override
  String get homeNoDevices => '??? ??? ????';

  @override
  String get homeAddDeviceTooltip => '?? ??';

  @override
  String get homeDDayLabel => 'D-day';

  @override
  String homeDdayMonthsLabel(int months) {
    return 'D-$months??';
  }

  @override
  String get settingsTitle => '??';

  @override
  String get settingsNotificationsToggleTitle => '?? ??';

  @override
  String get settingsNotificationsToggleEnabled => '??? ??? ?? ?? ??? ?????.';

  @override
  String get settingsNotificationsToggleDisabled => '?? ?? ?? ??? ???? ? ???.';

  @override
  String get settingsReminderTimeLabel => '?? ??';

  @override
  String get settingsLanguageTitle => '??';

  @override
  String get settingsLanguagePickerTitle => '?? ??';

  @override
  String get settingsBackupSectionTitle => '?? ? ??';

  @override
  String settingsVersionValue(String version) {
    return '$version';
  }

  @override
  String get languageEnglish => '??';

  @override
  String get languageKorean => '???';

  @override
  String get commonBackup => '??';

  @override
  String get commonRestore => '??';

  @override
  String get commonVersion => '??';

  @override
  String get commonSave => '??';

  @override
  String get commonCancel => '??';

  @override
  String get commonDelete => '??';

  @override
  String get commonEdit => '??';

  @override
  String get addDeviceSavedMessage => '???????.';

  @override
  String addDevicePickImagesError(String error) {
    return '???? ???? ?????: $error';
  }

  @override
  String get addDeviceEditTitle => '?? ??';

  @override
  String get addDeviceCreateTitle => '?? ??';

  @override
  String get addDeviceCategoryLabel => '??';

  @override
  String get addDeviceCategoryRequired => '??? ?????';

  @override
  String get addDeviceModelNameLabel => '???';

  @override
  String get addDeviceModelNameRequired => '???? ?????';

  @override
  String get addDeviceBrandLabel => '???';

  @override
  String get addDeviceBrandRequired => '???? ?????';

  @override
  String get addDeviceModelNumberLabel => '?? ??';

  @override
  String get addDeviceModelNumberRequired => '?? ??? ?????';

  @override
  String get addDevicePurchaseDateLabel => '???';

  @override
  String get addDevicePurchaseDateHint => '?? ??';

  @override
  String get addDevicePurchaseDateRequired => '???? ?????';

  @override
  String get addDevicePurchaseDateFutureError => '???? ??? ? ????';

  @override
  String get addDeviceWarrantyLabel => '?? (??)';

  @override
  String get addDeviceWarrantyHint => '0 ~ 120';

  @override
  String get addDeviceWarrantyRequired => '?? ??? ?????';

  @override
  String get addDeviceDigitsOnly => '??? ?????';

  @override
  String get addDeviceWarrantyRange => '0?? 120 ???? ???';

  @override
  String get addDeviceCustomerCenterLabel => '????';

  @override
  String get addDeviceCustomerCenterHint => '?) 1588-0000, 010-1234-5678';

  @override
  String get addDeviceCustomerCenterInvalid => '??? \'-\'? ??? ? ????';

  @override
  String get addDeviceOthersSectionTitle => '??';

  @override
  String get addDeviceTakePhoto => '?? ??';

  @override
  String get addDeviceSelectFromGallery => '???? ??';

  @override
  String get categoryTv => 'TV';

  @override
  String get categoryWasher => '???';

  @override
  String get categoryComputer => '???';

  @override
  String get categoryRefrigerator => '???';

  @override
  String get categoryAirConditioner => '???';

  @override
  String get categoryCar => '???';

  @override
  String get categoryOthers => '??';

  @override
  String get deviceDetailTitle => '?? ??';

  @override
  String get deviceDetailNotFound => '??? ?? ? ????.';

  @override
  String get deviceDetailCategoryLabel => '??';

  @override
  String get deviceDetailBrandLabel => '???';

  @override
  String get deviceDetailModelNameLabel => '???';

  @override
  String get deviceDetailModelNumberLabel => '?? ??';

  @override
  String get deviceDetailPurchaseDateLabel => '???';

  @override
  String get deviceDetailWarrantyLabel => '?? (??)';

  @override
  String get deviceDetailCustomerCenterLabel => '????';

  @override
  String get deviceDetailNoContact => '-';

  @override
  String get deviceDetailNotificationsTitle => '?? ??';

  @override
  String deviceDetailNotificationsEnabled(String expiry) {
    return '$expiry?? ??? ?????.';
  }

  @override
  String get deviceDetailNotificationsDisabled => '???? ??? ?? ?? ?? ?????.';

  @override
  String get deviceDetailPhotosSectionTitle => '??';

  @override
  String get deviceDetailDeleteDialogTitle => '? ??? ??????';

  @override
  String get deviceDetailDeleteDialogMessage => '???? ??? ? ????.';

  @override
  String get notificationsGlobalEnabled => '?? ??? ?????.';

  @override
  String get notificationsGlobalDisabled => '?? ??? ?????.';

  @override
  String get notificationsEnableInSettings => '??? ????? ???? ??? ???.';

  @override
  String get notificationsDeviceScheduled => '?? ??? ??????.';

  @override
  String get notificationsDeviceExpired => '?? ?? ??? ???????.';

  @override
  String get notificationsDeviceCancelled => '?? ??? ??????.';

  @override
  String get notificationsPermissionTitle => '??? ??????';

  @override
  String get notificationsPermissionDescription =>
      '??? ?? ??? ???? ?? ??? ?????.';

  @override
  String get notificationsPermissionNotNow => '???';

  @override
  String get notificationsPermissionAllow => '??';

  @override
  String get notificationsPermissionDenied => '?? ??? ???????.';

  @override
  String cameraCaptureFailed(String error) {
    return '??? ???? ?????: $error';
  }

  @override
  String get cameraTitle => '???';

  @override
  String get cameraInitializationFailed => '???? ????? ?????.';
}
