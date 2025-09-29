// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Заметки об устройстве';

  @override
  String get bootPlaceholderMessage =>
      'Первоначальная настройка завершена. Замените этот экран реальными маршрутами.';

  @override
  String get homeSettingsTooltip => 'Настройки';

  @override
  String get homeSearchHint => 'Поиск';

  @override
  String get homeNoDevices => 'Зарегистрированных устройств нет';

  @override
  String get homeAddDeviceTooltip => 'Добавить устройство';

  @override
  String get homeDDayLabel => 'День D';

  @override
  String homeDdayMonthsLabel(int months) {
    return 'D-$months мес.';
  }

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsNotificationsToggleTitle => 'Включить уведомления';

  @override
  String get settingsNotificationsToggleEnabled =>
      'Напоминания о гарантии будут отправляться согласно вашим настройкам.';

  @override
  String get settingsNotificationsToggleDisabled =>
      'Включите, чтобы получать напоминания до окончания срока гарантии.';

  @override
  String get settingsReminderTimeLabel => 'Время напоминания';

  @override
  String get settingsLanguageTitle => 'Язык';

  @override
  String get settingsLanguagePickerTitle => 'Выберите язык';

  @override
  String get settingsBackupSectionTitle =>
      'Резервное копирование и восстановление';

  @override
  String settingsVersionValue(String version) {
    return '$version';
  }

  @override
  String get languageEnglish => 'Английский';

  @override
  String get languageKorean => 'Корейский';

  @override
  String get commonBackup => 'Резервная копия';

  @override
  String get commonRestore => 'Восстановить';

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
  String get commonVersion => 'Версия';

  @override
  String get commonSave => 'Сохранить';

  @override
  String get commonCancel => 'Отмена';

  @override
  String get commonDelete => 'Удалить';

  @override
  String get commonEdit => 'Изменить';

  @override
  String get addDeviceSavedMessage => 'Сохранено.';

  @override
  String addDevicePickImagesError(String error) {
    return 'Не удалось выбрать изображения: $error';
  }

  @override
  String get addDeviceEditTitle => 'Изменить устройство';

  @override
  String get addDeviceCreateTitle => 'Добавить устройство';

  @override
  String get addDeviceCategoryLabel => 'Категория';

  @override
  String get addDeviceCategoryRequired => 'Категория обязательна';

  @override
  String get addDeviceModelNameLabel => 'Модель';

  @override
  String get addDeviceModelNameRequired => 'Модель обязательна';

  @override
  String get addDeviceBrandLabel => 'Бренд';

  @override
  String get addDeviceBrandRequired => 'Бренд обязателен';

  @override
  String get addDeviceModelNumberLabel => 'Номер модели';

  @override
  String get addDeviceModelNumberRequired => 'Номер модели обязателен';

  @override
  String get addDevicePurchaseDateLabel => 'Дата покупки';

  @override
  String get addDevicePurchaseDateHint => 'Выберите дату';

  @override
  String get addDevicePurchaseDateRequired => 'Укажите дату покупки';

  @override
  String get addDevicePurchaseDateFutureError =>
      'Дата покупки не может быть в будущем';

  @override
  String get addDeviceWarrantyLabel => 'Гарантия (в месяцах)';

  @override
  String get addDeviceWarrantyHint => '0 ~ 120';

  @override
  String get addDeviceWarrantyRequired => 'Укажите срок гарантии';

  @override
  String get addDeviceDigitsOnly => 'Введите только цифры';

  @override
  String get addDeviceWarrantyRange => 'Значение должно быть от 0 до 120';

  @override
  String get addDeviceCustomerCenterLabel => 'Служба поддержки';

  @override
  String get addDeviceCustomerCenterHint => 'напр. 1588-0000, 010-1234-5678';

  @override
  String get addDeviceCustomerCenterInvalid => 'Допускаются только цифры и -';

  @override
  String get addDeviceOthersSectionTitle => 'Прочее';

  @override
  String get addDeviceTakePhoto => 'Сделать фото';

  @override
  String get addDeviceSelectFromGallery => 'Выбрать из галереи';

  @override
  String get categoryTv => 'Телевизор';

  @override
  String get categoryWasher => 'Стиральная машина';

  @override
  String get categoryComputer => 'Компьютер';

  @override
  String get categoryRefrigerator => 'Холодильник';

  @override
  String get categoryAirConditioner => 'Кондиционер';

  @override
  String get categoryCar => 'Автомобиль';

  @override
  String get categoryOthers => 'Другое';

  @override
  String get deviceDetailTitle => 'Сведения об устройстве';

  @override
  String get deviceDetailNotFound => 'Устройство не найдено.';

  @override
  String get deviceDetailCategoryLabel => 'Категория';

  @override
  String get deviceDetailBrandLabel => 'Бренд';

  @override
  String get deviceDetailModelNameLabel => 'Модель';

  @override
  String get deviceDetailModelNumberLabel => 'Номер модели';

  @override
  String get deviceDetailPurchaseDateLabel => 'Дата покупки';

  @override
  String get deviceDetailWarrantyLabel => 'Гарантия (в месяцах)';

  @override
  String get deviceDetailCustomerCenterLabel => 'Служба поддержки';

  @override
  String get deviceDetailNoContact => 'Служба поддержки не указана.';

  @override
  String deviceDetailCallButton(Object number) {
    return 'Позвонить по номеру $number';
  }

  @override
  String get deviceDetailCallError =>
      'Не удалось открыть приложение для звонков.';

  @override
  String get deviceDetailNotificationsTitle => 'Уведомления о гарантии';

  @override
  String deviceDetailNotificationsEnabled(String expiry) {
    return 'Напоминания будут отправляться до $expiry.';
  }

  @override
  String get deviceDetailNotificationsDisabled =>
      'Включите уведомления в настройках, чтобы получать напоминания.';

  @override
  String get deviceDetailPhotosSectionTitle => 'Фотографии';

  @override
  String get deviceDetailDeleteDialogTitle => 'Удалить это устройство?';

  @override
  String get deviceDetailDeleteDialogMessage => 'Это действие нельзя отменить.';

  @override
  String get notificationsGlobalEnabled => 'Уведомления о гарантии включены.';

  @override
  String get notificationsGlobalDisabled => 'Уведомления о гарантии отключены.';

  @override
  String get notificationsEnableInSettings =>
      'Включите уведомления в настройках, чтобы запланировать напоминания.';

  @override
  String get notificationsDeviceScheduled =>
      'Напоминания по гарантии запланированы.';

  @override
  String get notificationsDeviceExpired => 'Срок гарантии уже истёк.';

  @override
  String get notificationsDeviceCancelled =>
      'Напоминания по гарантии отменены.';

  @override
  String get notificationsPermissionTitle => 'Разрешить уведомления?';

  @override
  String get notificationsPermissionDescription =>
      'Включите push-уведомления, чтобы получать напоминания о гарантии ваших устройств.';

  @override
  String get notificationsPermissionNotNow => 'Не сейчас';

  @override
  String get notificationsPermissionAllow => 'Разрешить';

  @override
  String get notificationsPermissionDenied => 'Доступ к уведомлениям отклонён.';

  @override
  String cameraCaptureFailed(String error) {
    return 'Не удалось сделать фото: $error';
  }

  @override
  String get cameraTitle => 'Камера';

  @override
  String get cameraInitializationFailed =>
      'Не удалось инициализировать камеру.';

  @override
  String homeDeviceBrandModel(String brand, String model) {
    return '$brand — $model';
  }

  @override
  String deviceDetailPhotoCounter(int current, int total) {
    return '$current / $total';
  }

  @override
  String get settingsVersionPlaceholder => '1.0.0 (заглушка)';

  @override
  String get languageBengali => 'Бенгальский';

  @override
  String get languageSpanish => 'Испанский';

  @override
  String get languageSpanishMexico => 'Испанский (Мексика)';

  @override
  String get languageHindi => 'Хинди';

  @override
  String get languageIndonesian => 'Индонезийский';

  @override
  String get languagePortuguese => 'Португальский';

  @override
  String get languagePortugueseBrazil => 'Португальский (Бразилия)';

  @override
  String get languageRussian => 'Русский';

  @override
  String get languageUrdu => 'Урду';

  @override
  String get languageChinese => 'Китайский';

  @override
  String get languageChineseSimplified => 'Китайский (упрощённый)';
}
