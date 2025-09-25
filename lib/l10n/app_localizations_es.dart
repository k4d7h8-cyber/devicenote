// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'DeviceNote';

  @override
  String get bootPlaceholderMessage =>
      'Fase de configuración completa. Reemplace esta pantalla con rutas reales.';

  @override
  String get homeSettingsTooltip => 'Configuración';

  @override
  String get homeSearchHint => 'Buscar';

  @override
  String get homeNoDevices => 'No hay dispositivos registrados';

  @override
  String get homeAddDeviceTooltip => 'Agregar dispositivo';

  @override
  String get homeDDayLabel => 'D-día';

  @override
  String homeDdayMonthsLabel(int months) {
    return 'D-$months m';
  }

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get settingsNotificationsToggleTitle => 'Habilitar notificaciones';

  @override
  String get settingsNotificationsToggleEnabled =>
      'Los recordatorios de garantía seguirán sus preferencias.';

  @override
  String get settingsNotificationsToggleDisabled =>
      'Active para recibir recordatorios antes de que caduquen las garantías.';

  @override
  String get settingsReminderTimeLabel => 'Hora del recordatorio';

  @override
  String get settingsLanguageTitle => 'Idioma';

  @override
  String get settingsLanguagePickerTitle => 'Elegir idioma';

  @override
  String get settingsBackupSectionTitle => 'Copia de seguridad y Restauración';

  @override
  String settingsVersionValue(String version) {
    return '$version';
  }

  @override
  String get languageEnglish => 'Inglés';

  @override
  String get languageKorean => 'Coreano';

  @override
  String get commonBackup => 'Copia de seguridad';

  @override
  String get commonRestore => 'Restaurar';

  @override
  String get commonVersion => 'Versión';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonEdit => 'Editar';

  @override
  String get addDeviceSavedMessage => 'Guardado.';

  @override
  String addDevicePickImagesError(String error) {
    return 'Error al seleccionar imágenes: $error';
  }

  @override
  String get addDeviceEditTitle => 'Editar dispositivo';

  @override
  String get addDeviceCreateTitle => 'Agregar dispositivo';

  @override
  String get addDeviceCategoryLabel => 'Categoría';

  @override
  String get addDeviceCategoryRequired => 'Categoría es requerida';

  @override
  String get addDeviceModelNameLabel => 'Nombre del modelo';

  @override
  String get addDeviceModelNameRequired => 'Nombre del modelo es requerido';

  @override
  String get addDeviceBrandLabel => 'Marca';

  @override
  String get addDeviceBrandRequired => 'Marca es requerida';

  @override
  String get addDeviceModelNumberLabel => 'Número de modelo';

  @override
  String get addDeviceModelNumberRequired => 'Número de modelo es requerido';

  @override
  String get addDevicePurchaseDateLabel => 'Fecha de compra';

  @override
  String get addDevicePurchaseDateHint => 'Seleccionar una fecha';

  @override
  String get addDevicePurchaseDateRequired => 'Seleccionar una fecha de compra';

  @override
  String get addDevicePurchaseDateFutureError =>
      'La fecha de compra no puede ser en el futuro';

  @override
  String get addDeviceWarrantyLabel => 'Garantía (meses)';

  @override
  String get addDeviceWarrantyHint => '0 ~ 120';

  @override
  String get addDeviceWarrantyRequired => 'Garantía es requerida';

  @override
  String get addDeviceDigitsOnly => 'Solo ingresar dígitos';

  @override
  String get addDeviceWarrantyRange => 'Debe estar entre 0 y 120';

  @override
  String get addDeviceCustomerCenterLabel => 'Centro de atención al cliente';

  @override
  String get addDeviceCustomerCenterHint => 'e.g. 1588-0000, 010-1234-5678';

  @override
  String get addDeviceCustomerCenterInvalid => 'Solo dígitos y -';

  @override
  String get addDeviceOthersSectionTitle => 'Otros';

  @override
  String get addDeviceTakePhoto => 'Tomar foto';

  @override
  String get addDeviceSelectFromGallery => 'Seleccionar de la galería';

  @override
  String get categoryTv => 'TV';

  @override
  String get categoryWasher => 'Lavadora';

  @override
  String get categoryComputer => 'Computadora';

  @override
  String get categoryRefrigerator => 'Refrigerador';

  @override
  String get categoryAirConditioner => 'Aire acondicionado';

  @override
  String get categoryCar => 'Coche';

  @override
  String get categoryOthers => 'Otros';

  @override
  String get deviceDetailTitle => 'Detalle del dispositivo';

  @override
  String get deviceDetailNotFound => 'Dispositivo no encontrado.';

  @override
  String get deviceDetailCategoryLabel => 'Categoría';

  @override
  String get deviceDetailBrandLabel => 'Marca';

  @override
  String get deviceDetailModelNameLabel => 'Nombre del modelo';

  @override
  String get deviceDetailModelNumberLabel => 'Número de modelo';

  @override
  String get deviceDetailPurchaseDateLabel => 'Fecha de compra';

  @override
  String get deviceDetailWarrantyLabel => 'Garantía (meses)';

  @override
  String get deviceDetailCustomerCenterLabel => 'Centro de atención al cliente';

  @override
  String get deviceDetailNoContact =>
      'No se registró ningún centro de atención al cliente.';

  @override
  String deviceDetailCallButton(Object number) {
    return 'Llamar a $number';
  }

  @override
  String get deviceDetailCallError =>
      'No se puede abrir el marcador del teléfono.';

  @override
  String get deviceDetailNotificationsTitle => 'Notificaciones de garantía';

  @override
  String deviceDetailNotificationsEnabled(String expiry) {
    return 'Los recordatorios se enviarán hasta $expiry.';
  }

  @override
  String get deviceDetailNotificationsDisabled =>
      'Active las notificaciones en Configuración para recibir recordatorios.';

  @override
  String get deviceDetailPhotosSectionTitle => 'Fotos';

  @override
  String get deviceDetailDeleteDialogTitle => '¿Eliminar este dispositivo?';

  @override
  String get deviceDetailDeleteDialogMessage =>
      'Esta acción no se puede deshacer.';

  @override
  String get notificationsGlobalEnabled =>
      'Notificaciones de garantía habilitadas.';

  @override
  String get notificationsGlobalDisabled =>
      'Notificaciones de garantía deshabilitadas.';

  @override
  String get notificationsEnableInSettings =>
      'Habilite las notificaciones en Configuración para programar alertas.';

  @override
  String get notificationsDeviceScheduled =>
      'Recordatorios de garantía programados.';

  @override
  String get notificationsDeviceExpired =>
      'El período de garantía ya ha finalizado.';

  @override
  String get notificationsDeviceCancelled =>
      'Recordatorios de garantía cancelados.';

  @override
  String get notificationsPermissionTitle => '¿Permitir notificaciones?';

  @override
  String get notificationsPermissionDescription =>
      'Habilite las notificaciones push para recibir recordatorios de garantía para sus dispositivos.';

  @override
  String get notificationsPermissionNotNow => 'Ahora no';

  @override
  String get notificationsPermissionAllow => 'Permitir';

  @override
  String get notificationsPermissionDenied =>
      'Permiso de notificación denegado.';

  @override
  String cameraCaptureFailed(String error) {
    return 'Error al capturar la foto: $error';
  }

  @override
  String get cameraTitle => 'Cámara';

  @override
  String get cameraInitializationFailed => 'Error al inicializar la cámara.';

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

/// The translations for Spanish Castilian, as used in Mexico (`es_MX`).
class AppLocalizationsEsMx extends AppLocalizationsEs {
  AppLocalizationsEsMx() : super('es_MX');

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
