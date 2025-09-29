// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Nota do Dispositivo';

  @override
  String get bootPlaceholderMessage =>
      'Fase de configuração concluída. Substitua esta tela por rotas reais.';

  @override
  String get homeSettingsTooltip => 'Definições';

  @override
  String get homeSearchHint => 'Procurar';

  @override
  String get homeNoDevices => 'Nenhum dispositivo registado';

  @override
  String get homeAddDeviceTooltip => 'Adicionar dispositivo';

  @override
  String get homeDDayLabel => 'Contagem regressiva';

  @override
  String homeDdayMonthsLabel(int months) {
    return 'Faltam $months meses';
  }

  @override
  String get settingsTitle => 'Definições';

  @override
  String get settingsNotificationsToggleTitle => 'Ativar notificações';

  @override
  String get settingsNotificationsToggleEnabled =>
      'Os lembretes de garantia seguirão as suas preferências.';

  @override
  String get settingsNotificationsToggleDisabled =>
      'Ative para receber lembretes antes de a garantia expirar.';

  @override
  String get settingsReminderTimeLabel => 'Hora do lembrete';

  @override
  String get settingsLanguageTitle => 'Idioma';

  @override
  String get settingsLanguagePickerTitle => 'Escolher idioma';

  @override
  String get settingsBackupSectionTitle => 'Cópia de segurança e restauro';

  @override
  String settingsVersionValue(String version) {
    return '$version';
  }

  @override
  String get languageEnglish => 'Inglês';

  @override
  String get languageKorean => 'Coreano';

  @override
  String get commonBackup => 'Cópia de segurança';

  @override
  String get commonRestore => 'Restaurar';

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
  String get commonVersion => 'Versão';

  @override
  String get commonSave => 'Guardar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonDelete => 'Eliminar';

  @override
  String get commonEdit => 'Editar';

  @override
  String get addDeviceSavedMessage => 'Salvo.';

  @override
  String addDevicePickImagesError(String error) {
    return 'Falha ao selecionar imagens: $error';
  }

  @override
  String get addDeviceEditTitle => 'Editar dispositivo';

  @override
  String get addDeviceCreateTitle => 'Adicionar dispositivo';

  @override
  String get addDeviceCategoryLabel => 'Categoria';

  @override
  String get addDeviceCategoryRequired => 'A categoria é obrigatória';

  @override
  String get addDeviceModelNameLabel => 'Nome do modelo';

  @override
  String get addDeviceModelNameRequired => 'O nome do modelo é obrigatório';

  @override
  String get addDeviceBrandLabel => 'Marca';

  @override
  String get addDeviceBrandRequired => 'A marca é obrigatória';

  @override
  String get addDeviceModelNumberLabel => 'Número do modelo';

  @override
  String get addDeviceModelNumberRequired => 'O número do modelo é obrigatório';

  @override
  String get addDevicePurchaseDateLabel => 'Data da compra';

  @override
  String get addDevicePurchaseDateHint => 'Selecione uma data';

  @override
  String get addDevicePurchaseDateRequired => 'Selecione uma data de compra';

  @override
  String get addDevicePurchaseDateFutureError =>
      'A data da compra não pode ser no futuro';

  @override
  String get addDeviceWarrantyLabel => 'Garantia (meses)';

  @override
  String get addDeviceWarrantyHint => '0 ~ 120';

  @override
  String get addDeviceWarrantyRequired => 'A garantia é obrigatória';

  @override
  String get addDeviceDigitsOnly => 'Insira apenas dígitos';

  @override
  String get addDeviceWarrantyRange => 'Deve estar entre 0 e 120';

  @override
  String get addDeviceCustomerCenterLabel => 'Central de atendimento';

  @override
  String get addDeviceCustomerCenterHint => 'ex: 1588-0000, 010-1234-5678';

  @override
  String get addDeviceCustomerCenterInvalid => 'Apenas dígitos e -';

  @override
  String get addDeviceOthersSectionTitle => 'Outros';

  @override
  String get addDeviceTakePhoto => 'Tirar foto';

  @override
  String get addDeviceSelectFromGallery => 'Selecionar da galeria';

  @override
  String get categoryTv => 'TV';

  @override
  String get categoryWasher => 'Máquina de lavar';

  @override
  String get categoryComputer => 'Computador';

  @override
  String get categoryRefrigerator => 'Geladeira';

  @override
  String get categoryAirConditioner => 'Ar condicionado';

  @override
  String get categoryCar => 'Carro';

  @override
  String get categoryOthers => 'Outros';

  @override
  String get deviceDetailTitle => 'Detalhes do dispositivo';

  @override
  String get deviceDetailNotFound => 'Dispositivo não encontrado.';

  @override
  String get deviceDetailCategoryLabel => 'Categoria';

  @override
  String get deviceDetailBrandLabel => 'Marca';

  @override
  String get deviceDetailModelNameLabel => 'Nome do modelo';

  @override
  String get deviceDetailModelNumberLabel => 'Número do modelo';

  @override
  String get deviceDetailPurchaseDateLabel => 'Data da compra';

  @override
  String get deviceDetailWarrantyLabel => 'Garantia (meses)';

  @override
  String get deviceDetailCustomerCenterLabel => 'Central de atendimento';

  @override
  String get deviceDetailNoContact =>
      'Nenhuma central de atendimento registrada.';

  @override
  String deviceDetailCallButton(Object number) {
    return 'Ligar para $number';
  }

  @override
  String get deviceDetailCallError =>
      'Não foi possível abrir o discador do telefone.';

  @override
  String get deviceDetailNotificationsTitle => 'Notificações de garantia';

  @override
  String deviceDetailNotificationsEnabled(String expiry) {
    return 'Os lembretes serão enviados até $expiry.';
  }

  @override
  String get deviceDetailNotificationsDisabled =>
      'Ative as notificações em Configurações para receber lembretes.';

  @override
  String get deviceDetailPhotosSectionTitle => 'Fotos';

  @override
  String get deviceDetailDeleteDialogTitle => 'Excluir este dispositivo?';

  @override
  String get deviceDetailDeleteDialogMessage =>
      'Esta ação não pode ser desfeita.';

  @override
  String get notificationsGlobalEnabled => 'Notificações de garantia ativadas.';

  @override
  String get notificationsGlobalDisabled =>
      'Notificações de garantia desativadas.';

  @override
  String get notificationsEnableInSettings =>
      'Ative as notificações em Configurações para agendar alertas.';

  @override
  String get notificationsDeviceScheduled => 'Lembretes de garantia agendados.';

  @override
  String get notificationsDeviceExpired => 'O período de garantia já terminou.';

  @override
  String get notificationsDeviceCancelled =>
      'Lembretes de garantia cancelados.';

  @override
  String get notificationsPermissionTitle => 'Permitir notificações?';

  @override
  String get notificationsPermissionDescription =>
      'Ative as notificações push para receber lembretes de garantia para seus dispositivos.';

  @override
  String get notificationsPermissionNotNow => 'Agora não';

  @override
  String get notificationsPermissionAllow => 'Permitir';

  @override
  String get notificationsPermissionDenied =>
      'Permissão de notificação negada.';

  @override
  String cameraCaptureFailed(String error) {
    return 'Falha ao capturar a foto: $error';
  }

  @override
  String get cameraTitle => 'Câmera';

  @override
  String get cameraInitializationFailed => 'Falha ao inicializar a câmera.';

  @override
  String homeDeviceBrandModel(String brand, String model) {
    return '$brand - $model';
  }

  @override
  String deviceDetailPhotoCounter(int current, int total) {
    return '$current / $total';
  }

  @override
  String get settingsVersionPlaceholder => '1.0.0 (marcador de posição)';

  @override
  String get languageBengali => 'Bengali';

  @override
  String get languageSpanish => 'Espanhol';

  @override
  String get languageSpanishMexico => 'Espanhol (México)';

  @override
  String get languageHindi => 'Hindi';

  @override
  String get languageIndonesian => 'Indonésio';

  @override
  String get languagePortuguese => 'Português';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageRussian => 'Russo';

  @override
  String get languageUrdu => 'Urdu';

  @override
  String get languageChinese => 'Chinês';

  @override
  String get languageChineseSimplified => 'Chinês (simplificado)';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get appTitle => 'Nota do Dispositivo';

  @override
  String get bootPlaceholderMessage =>
      'Setup phase complete. Replace this screen with actual routes.';

  @override
  String get homeSettingsTooltip => 'Configurações';

  @override
  String get homeSearchHint => 'Pesquisar';

  @override
  String get homeNoDevices => 'Nenhum dispositivo cadastrado';

  @override
  String get homeAddDeviceTooltip => 'Adicionar dispositivo';

  @override
  String get homeDDayLabel => 'D-day';

  @override
  String homeDdayMonthsLabel(int months) {
    return 'D-$months m';
  }

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get settingsNotificationsToggleTitle => 'Ativar notificações';

  @override
  String get settingsNotificationsToggleEnabled =>
      'Os lembretes de garantia seguirão suas preferências.';

  @override
  String get settingsNotificationsToggleDisabled =>
      'Ative para receber lembretes antes de a garantia expirar.';

  @override
  String get settingsReminderTimeLabel => 'Horário do lembrete';

  @override
  String get settingsLanguageTitle => 'Idioma';

  @override
  String get settingsLanguagePickerTitle => 'Escolher idioma';

  @override
  String get settingsBackupSectionTitle => 'Backup e restauração';

  @override
  String settingsVersionValue(String version) {
    return '$version';
  }

  @override
  String get languageEnglish => 'English';

  @override
  String get languageKorean => 'Korean';

  @override
  String get commonBackup => 'Fazer backup';

  @override
  String get commonRestore => 'Restaurar';

  @override
  String get commonVersion => 'Versão';

  @override
  String get commonSave => 'Salvar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonDelete => 'Excluir';

  @override
  String get commonEdit => 'Editar';

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
  String get settingsVersionPlaceholder => '1.0.0 (marcador de posição)';

  @override
  String get languageBengali => 'Bengali';

  @override
  String get languageSpanish => 'Espanhol';

  @override
  String get languageSpanishMexico => 'Espanhol (México)';

  @override
  String get languageHindi => 'Hindi';

  @override
  String get languageIndonesian => 'Indonésio';

  @override
  String get languagePortuguese => 'Português';

  @override
  String get languagePortugueseBrazil => 'Português (Brasil)';

  @override
  String get languageRussian => 'Russo';

  @override
  String get languageUrdu => 'Urdu';

  @override
  String get languageChinese => 'Chinês';

  @override
  String get languageChineseSimplified => 'Chinês (simplificado)';
}
