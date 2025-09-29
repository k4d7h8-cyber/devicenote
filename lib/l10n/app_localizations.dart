import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_ur.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en'),
    Locale('es'),
    Locale('es', 'MX'),
    Locale('hi'),
    Locale('id'),
    Locale('ko'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('ru'),
    Locale('ur'),
    Locale('zh'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'DeviceNote'**
  String get appTitle;

  /// No description provided for @bootPlaceholderMessage.
  ///
  /// In en, this message translates to:
  /// **'Setup phase complete. Replace this screen with actual routes.'**
  String get bootPlaceholderMessage;

  /// No description provided for @homeSettingsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get homeSettingsTooltip;

  /// No description provided for @homeSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get homeSearchHint;

  /// No description provided for @homeNoDevices.
  ///
  /// In en, this message translates to:
  /// **'No registered devices'**
  String get homeNoDevices;

  /// No description provided for @homeAddDeviceTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add device'**
  String get homeAddDeviceTooltip;

  /// No description provided for @homeDDayLabel.
  ///
  /// In en, this message translates to:
  /// **'D-day'**
  String get homeDDayLabel;

  /// Remaining months label (e.g., D-3 m).
  ///
  /// In en, this message translates to:
  /// **'D-{months} m'**
  String homeDdayMonthsLabel(int months);

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsNotificationsToggleTitle.
  ///
  /// In en, this message translates to:
  /// **'Enable notifications'**
  String get settingsNotificationsToggleTitle;

  /// No description provided for @settingsNotificationsToggleEnabled.
  ///
  /// In en, this message translates to:
  /// **'Warranty reminders will follow your preferences.'**
  String get settingsNotificationsToggleEnabled;

  /// No description provided for @settingsNotificationsToggleDisabled.
  ///
  /// In en, this message translates to:
  /// **'Turn on to receive reminders before warranties expire.'**
  String get settingsNotificationsToggleDisabled;

  /// No description provided for @settingsReminderTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Reminder time'**
  String get settingsReminderTimeLabel;

  /// No description provided for @settingsLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguageTitle;

  /// No description provided for @settingsLanguagePickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose language'**
  String get settingsLanguagePickerTitle;

  /// No description provided for @settingsBackupSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Backup & Restore'**
  String get settingsBackupSectionTitle;

  /// No description provided for @settingsVersionValue.
  ///
  /// In en, this message translates to:
  /// **'{version}'**
  String settingsVersionValue(String version);

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageKorean.
  ///
  /// In en, this message translates to:
  /// **'Korean'**
  String get languageKorean;

  /// No description provided for @commonBackup.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get commonBackup;

  /// No description provided for @commonRestore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get commonRestore;

  /// Shown after a backup file has been created successfully.
  ///
  /// In en, this message translates to:
  /// **'Backup file {fileName} is ready to share.'**
  String settingsBackupSuccess(String fileName);

  /// No description provided for @settingsBackupFailure.
  ///
  /// In en, this message translates to:
  /// **'Could not create a backup. Please try again.'**
  String get settingsBackupFailure;

  /// No description provided for @settingsRestorePickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose a backup file'**
  String get settingsRestorePickerTitle;

  /// No description provided for @settingsRestoreInvalid.
  ///
  /// In en, this message translates to:
  /// **'The selected file is not a valid DeviceNote backup.'**
  String get settingsRestoreInvalid;

  /// No description provided for @settingsRestoreResult.
  ///
  /// In en, this message translates to:
  /// **'Restore complete. Added {added}, updated {updated}.'**
  String settingsRestoreResult(int added, int updated);

  /// No description provided for @settingsRestorePartial.
  ///
  /// In en, this message translates to:
  /// **'Restore partially completed. Added {added}, updated {updated}, failed {failed}.'**
  String settingsRestorePartial(int added, int updated, int failed);

  /// No description provided for @settingsRestoreFailure.
  ///
  /// In en, this message translates to:
  /// **'Restore failed. Please try again.'**
  String get settingsRestoreFailure;

  /// No description provided for @settingsRestoreRestartPrompt.
  ///
  /// In en, this message translates to:
  /// **'Restart the app to apply the restored data.'**
  String get settingsRestoreRestartPrompt;

  /// No description provided for @settingsRestoreRestartNow.
  ///
  /// In en, this message translates to:
  /// **'Restart now'**
  String get settingsRestoreRestartNow;

  /// No description provided for @settingsRestoreLater.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get settingsRestoreLater;

  /// No description provided for @commonVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get commonVersion;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @commonEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get commonEdit;

  /// No description provided for @addDeviceSavedMessage.
  ///
  /// In en, this message translates to:
  /// **'Saved.'**
  String get addDeviceSavedMessage;

  /// No description provided for @addDevicePickImagesError.
  ///
  /// In en, this message translates to:
  /// **'Failed to pick images: {error}'**
  String addDevicePickImagesError(String error);

  /// No description provided for @addDeviceEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit device'**
  String get addDeviceEditTitle;

  /// No description provided for @addDeviceCreateTitle.
  ///
  /// In en, this message translates to:
  /// **'Add device'**
  String get addDeviceCreateTitle;

  /// No description provided for @addDeviceCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get addDeviceCategoryLabel;

  /// No description provided for @addDeviceCategoryRequired.
  ///
  /// In en, this message translates to:
  /// **'Category is required'**
  String get addDeviceCategoryRequired;

  /// No description provided for @addDeviceModelNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Model name'**
  String get addDeviceModelNameLabel;

  /// No description provided for @addDeviceModelNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Model name is required'**
  String get addDeviceModelNameRequired;

  /// No description provided for @addDeviceBrandLabel.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get addDeviceBrandLabel;

  /// No description provided for @addDeviceBrandRequired.
  ///
  /// In en, this message translates to:
  /// **'Brand is required'**
  String get addDeviceBrandRequired;

  /// No description provided for @addDeviceModelNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Model number'**
  String get addDeviceModelNumberLabel;

  /// No description provided for @addDeviceModelNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Model number is required'**
  String get addDeviceModelNumberRequired;

  /// No description provided for @addDevicePurchaseDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Purchase date'**
  String get addDevicePurchaseDateLabel;

  /// No description provided for @addDevicePurchaseDateHint.
  ///
  /// In en, this message translates to:
  /// **'Pick a date'**
  String get addDevicePurchaseDateHint;

  /// No description provided for @addDevicePurchaseDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Pick a purchase date'**
  String get addDevicePurchaseDateRequired;

  /// No description provided for @addDevicePurchaseDateFutureError.
  ///
  /// In en, this message translates to:
  /// **'Purchase date cannot be in the future'**
  String get addDevicePurchaseDateFutureError;

  /// No description provided for @addDeviceWarrantyLabel.
  ///
  /// In en, this message translates to:
  /// **'Warranty (months)'**
  String get addDeviceWarrantyLabel;

  /// No description provided for @addDeviceWarrantyHint.
  ///
  /// In en, this message translates to:
  /// **'0 ~ 120'**
  String get addDeviceWarrantyHint;

  /// No description provided for @addDeviceWarrantyRequired.
  ///
  /// In en, this message translates to:
  /// **'Warranty is required'**
  String get addDeviceWarrantyRequired;

  /// No description provided for @addDeviceDigitsOnly.
  ///
  /// In en, this message translates to:
  /// **'Enter digits only'**
  String get addDeviceDigitsOnly;

  /// No description provided for @addDeviceWarrantyRange.
  ///
  /// In en, this message translates to:
  /// **'Must be between 0 and 120'**
  String get addDeviceWarrantyRange;

  /// No description provided for @addDeviceCustomerCenterLabel.
  ///
  /// In en, this message translates to:
  /// **'Customer center'**
  String get addDeviceCustomerCenterLabel;

  /// No description provided for @addDeviceCustomerCenterHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 1588-0000, 010-1234-5678'**
  String get addDeviceCustomerCenterHint;

  /// No description provided for @addDeviceCustomerCenterInvalid.
  ///
  /// In en, this message translates to:
  /// **'Digits and - only'**
  String get addDeviceCustomerCenterInvalid;

  /// No description provided for @addDeviceOthersSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get addDeviceOthersSectionTitle;

  /// No description provided for @addDeviceTakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get addDeviceTakePhoto;

  /// No description provided for @addDeviceSelectFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Select from gallery'**
  String get addDeviceSelectFromGallery;

  /// No description provided for @categoryTv.
  ///
  /// In en, this message translates to:
  /// **'TV'**
  String get categoryTv;

  /// No description provided for @categoryWasher.
  ///
  /// In en, this message translates to:
  /// **'Washer'**
  String get categoryWasher;

  /// No description provided for @categoryComputer.
  ///
  /// In en, this message translates to:
  /// **'Computer'**
  String get categoryComputer;

  /// No description provided for @categoryRefrigerator.
  ///
  /// In en, this message translates to:
  /// **'Refrigerator'**
  String get categoryRefrigerator;

  /// No description provided for @categoryAirConditioner.
  ///
  /// In en, this message translates to:
  /// **'Air conditioner'**
  String get categoryAirConditioner;

  /// No description provided for @categoryCar.
  ///
  /// In en, this message translates to:
  /// **'Car'**
  String get categoryCar;

  /// No description provided for @categoryOthers.
  ///
  /// In en, this message translates to:
  /// **'Others'**
  String get categoryOthers;

  /// No description provided for @deviceDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Device detail'**
  String get deviceDetailTitle;

  /// No description provided for @deviceDetailNotFound.
  ///
  /// In en, this message translates to:
  /// **'Device not found.'**
  String get deviceDetailNotFound;

  /// No description provided for @deviceDetailCategoryLabel.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get deviceDetailCategoryLabel;

  /// No description provided for @deviceDetailBrandLabel.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get deviceDetailBrandLabel;

  /// No description provided for @deviceDetailModelNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Model name'**
  String get deviceDetailModelNameLabel;

  /// No description provided for @deviceDetailModelNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Model number'**
  String get deviceDetailModelNumberLabel;

  /// No description provided for @deviceDetailPurchaseDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Purchase date'**
  String get deviceDetailPurchaseDateLabel;

  /// No description provided for @deviceDetailWarrantyLabel.
  ///
  /// In en, this message translates to:
  /// **'Warranty (months)'**
  String get deviceDetailWarrantyLabel;

  /// No description provided for @deviceDetailCustomerCenterLabel.
  ///
  /// In en, this message translates to:
  /// **'Customer center'**
  String get deviceDetailCustomerCenterLabel;

  /// No description provided for @deviceDetailNoContact.
  ///
  /// In en, this message translates to:
  /// **'No customer center registered.'**
  String get deviceDetailNoContact;

  /// Label for the button that starts a phone call to the customer center.
  ///
  /// In en, this message translates to:
  /// **'Call {number}'**
  String deviceDetailCallButton(Object number);

  /// No description provided for @deviceDetailCallError.
  ///
  /// In en, this message translates to:
  /// **'Unable to open the phone dialer.'**
  String get deviceDetailCallError;

  /// No description provided for @deviceDetailNotificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Warranty notifications'**
  String get deviceDetailNotificationsTitle;

  /// No description provided for @deviceDetailNotificationsEnabled.
  ///
  /// In en, this message translates to:
  /// **'Reminders will be sent until {expiry}.'**
  String deviceDetailNotificationsEnabled(String expiry);

  /// No description provided for @deviceDetailNotificationsDisabled.
  ///
  /// In en, this message translates to:
  /// **'Turn on notifications in Settings to receive reminders.'**
  String get deviceDetailNotificationsDisabled;

  /// No description provided for @deviceDetailPhotosSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get deviceDetailPhotosSectionTitle;

  /// No description provided for @deviceDetailDeleteDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this device?'**
  String get deviceDetailDeleteDialogTitle;

  /// No description provided for @deviceDetailDeleteDialogMessage.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get deviceDetailDeleteDialogMessage;

  /// No description provided for @notificationsGlobalEnabled.
  ///
  /// In en, this message translates to:
  /// **'Warranty notifications enabled.'**
  String get notificationsGlobalEnabled;

  /// No description provided for @notificationsGlobalDisabled.
  ///
  /// In en, this message translates to:
  /// **'Warranty notifications disabled.'**
  String get notificationsGlobalDisabled;

  /// No description provided for @notificationsEnableInSettings.
  ///
  /// In en, this message translates to:
  /// **'Enable notifications in Settings to schedule alerts.'**
  String get notificationsEnableInSettings;

  /// No description provided for @notificationsDeviceScheduled.
  ///
  /// In en, this message translates to:
  /// **'Warranty reminders scheduled.'**
  String get notificationsDeviceScheduled;

  /// No description provided for @notificationsDeviceExpired.
  ///
  /// In en, this message translates to:
  /// **'Warranty period already ended.'**
  String get notificationsDeviceExpired;

  /// No description provided for @notificationsDeviceCancelled.
  ///
  /// In en, this message translates to:
  /// **'Warranty reminders cancelled.'**
  String get notificationsDeviceCancelled;

  /// No description provided for @notificationsPermissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Allow notifications?'**
  String get notificationsPermissionTitle;

  /// No description provided for @notificationsPermissionDescription.
  ///
  /// In en, this message translates to:
  /// **'Enable push notifications to receive warranty reminders for your devices.'**
  String get notificationsPermissionDescription;

  /// No description provided for @notificationsPermissionNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get notificationsPermissionNotNow;

  /// No description provided for @notificationsPermissionAllow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get notificationsPermissionAllow;

  /// No description provided for @notificationsPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Notification permission denied.'**
  String get notificationsPermissionDenied;

  /// No description provided for @cameraCaptureFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to capture photo: {error}'**
  String cameraCaptureFailed(String error);

  /// No description provided for @cameraTitle.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get cameraTitle;

  /// No description provided for @cameraInitializationFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to initialize the camera.'**
  String get cameraInitializationFailed;

  /// No description provided for @homeDeviceBrandModel.
  ///
  /// In en, this message translates to:
  /// **'{brand} - {model}'**
  String homeDeviceBrandModel(String brand, String model);

  /// No description provided for @deviceDetailPhotoCounter.
  ///
  /// In en, this message translates to:
  /// **'{current} / {total}'**
  String deviceDetailPhotoCounter(int current, int total);

  /// No description provided for @settingsVersionPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'1.0.0 (placeholder)'**
  String get settingsVersionPlaceholder;

  /// No description provided for @languageBengali.
  ///
  /// In en, this message translates to:
  /// **'Bengali'**
  String get languageBengali;

  /// No description provided for @languageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get languageSpanish;

  /// No description provided for @languageSpanishMexico.
  ///
  /// In en, this message translates to:
  /// **'Spanish (Mexico)'**
  String get languageSpanishMexico;

  /// No description provided for @languageHindi.
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get languageHindi;

  /// No description provided for @languageIndonesian.
  ///
  /// In en, this message translates to:
  /// **'Indonesian'**
  String get languageIndonesian;

  /// No description provided for @languagePortuguese.
  ///
  /// In en, this message translates to:
  /// **'Portuguese'**
  String get languagePortuguese;

  /// No description provided for @languagePortugueseBrazil.
  ///
  /// In en, this message translates to:
  /// **'Portuguese (Brazil)'**
  String get languagePortugueseBrazil;

  /// No description provided for @languageRussian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get languageRussian;

  /// No description provided for @languageUrdu.
  ///
  /// In en, this message translates to:
  /// **'Urdu'**
  String get languageUrdu;

  /// No description provided for @languageChinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get languageChinese;

  /// No description provided for @languageChineseSimplified.
  ///
  /// In en, this message translates to:
  /// **'Chinese (Simplified)'**
  String get languageChineseSimplified;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'bn',
    'en',
    'es',
    'hi',
    'id',
    'ko',
    'pt',
    'ru',
    'ur',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.scriptCode) {
          case 'Hans':
            return AppLocalizationsZhHans();
        }
        break;
      }
  }

  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'es':
      {
        switch (locale.countryCode) {
          case 'MX':
            return AppLocalizationsEsMx();
        }
        break;
      }
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'hi':
      return AppLocalizationsHi();
    case 'id':
      return AppLocalizationsId();
    case 'ko':
      return AppLocalizationsKo();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'ur':
      return AppLocalizationsUr();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
