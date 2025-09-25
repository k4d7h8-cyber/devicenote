// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '设备记录';

  @override
  String get bootPlaceholderMessage => '设置阶段完成。用实际路由替换此屏幕。';

  @override
  String get homeSettingsTooltip => '设置';

  @override
  String get homeSearchHint => '搜索';

  @override
  String get homeNoDevices => '无注册设备';

  @override
  String get homeAddDeviceTooltip => '添加设备';

  @override
  String get homeDDayLabel => '倒计时';

  @override
  String homeDdayMonthsLabel(int months) {
    return 'D-$months 个月';
  }

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsNotificationsToggleTitle => '启用通知';

  @override
  String get settingsNotificationsToggleEnabled => '保修提醒将遵循您的偏好。';

  @override
  String get settingsNotificationsToggleDisabled => '开启以在保修期满前接收提醒。';

  @override
  String get settingsReminderTimeLabel => '提醒时间';

  @override
  String get settingsLanguageTitle => '语言';

  @override
  String get settingsLanguagePickerTitle => '选择语言';

  @override
  String get settingsBackupSectionTitle => '备份与恢复';

  @override
  String settingsVersionValue(String version) {
    return '$version';
  }

  @override
  String get languageEnglish => '英语';

  @override
  String get languageKorean => '韩语';

  @override
  String get commonBackup => '备份';

  @override
  String get commonRestore => '恢复';

  @override
  String get commonVersion => '版本';

  @override
  String get commonSave => '保存';

  @override
  String get commonCancel => '取消';

  @override
  String get commonDelete => '删除';

  @override
  String get commonEdit => '编辑';

  @override
  String get addDeviceSavedMessage => '已保存。';

  @override
  String addDevicePickImagesError(String error) {
    return '选择图片失败：$error';
  }

  @override
  String get addDeviceEditTitle => '编辑设备';

  @override
  String get addDeviceCreateTitle => '添加设备';

  @override
  String get addDeviceCategoryLabel => '类别';

  @override
  String get addDeviceCategoryRequired => '类别是必填项';

  @override
  String get addDeviceModelNameLabel => '型号名称';

  @override
  String get addDeviceModelNameRequired => '型号名称是必填项';

  @override
  String get addDeviceBrandLabel => '品牌';

  @override
  String get addDeviceBrandRequired => '品牌是必填项';

  @override
  String get addDeviceModelNumberLabel => '型号';

  @override
  String get addDeviceModelNumberRequired => '型号是必填项';

  @override
  String get addDevicePurchaseDateLabel => '购买日期';

  @override
  String get addDevicePurchaseDateHint => '选择日期';

  @override
  String get addDevicePurchaseDateRequired => '选择一个购买日期';

  @override
  String get addDevicePurchaseDateFutureError => '购买日期不能在将来';

  @override
  String get addDeviceWarrantyLabel => '保修期（月）';

  @override
  String get addDeviceWarrantyHint => '0 ~ 120';

  @override
  String get addDeviceWarrantyRequired => '保修期是必填项';

  @override
  String get addDeviceDigitsOnly => '仅输入数字';

  @override
  String get addDeviceWarrantyRange => '必须在 0 到 120 之间';

  @override
  String get addDeviceCustomerCenterLabel => '客户服务中心';

  @override
  String get addDeviceCustomerCenterHint => '例如 1588-0000, 010-1234-5678';

  @override
  String get addDeviceCustomerCenterInvalid => '仅限数字和-';

  @override
  String get addDeviceOthersSectionTitle => '其他';

  @override
  String get addDeviceTakePhoto => '拍照';

  @override
  String get addDeviceSelectFromGallery => '从相册选择';

  @override
  String get categoryTv => '电视';

  @override
  String get categoryWasher => '洗衣机';

  @override
  String get categoryComputer => '电脑';

  @override
  String get categoryRefrigerator => '冰箱';

  @override
  String get categoryAirConditioner => '空调';

  @override
  String get categoryCar => '汽车';

  @override
  String get categoryOthers => '其他';

  @override
  String get deviceDetailTitle => '设备详情';

  @override
  String get deviceDetailNotFound => '未找到设备。';

  @override
  String get deviceDetailCategoryLabel => '类别';

  @override
  String get deviceDetailBrandLabel => '品牌';

  @override
  String get deviceDetailModelNameLabel => '型号名称';

  @override
  String get deviceDetailModelNumberLabel => '型号';

  @override
  String get deviceDetailPurchaseDateLabel => '购买日期';

  @override
  String get deviceDetailWarrantyLabel => '保修期（月）';

  @override
  String get deviceDetailCustomerCenterLabel => '客户服务中心';

  @override
  String get deviceDetailNoContact => '未注册客户服务中心。';

  @override
  String deviceDetailCallButton(Object number) {
    return '致电 $number';
  }

  @override
  String get deviceDetailCallError => '无法打开电话拨号器。';

  @override
  String get deviceDetailNotificationsTitle => '保修通知';

  @override
  String deviceDetailNotificationsEnabled(String expiry) {
    return '提醒将发送至 $expiry。';
  }

  @override
  String get deviceDetailNotificationsDisabled => '在“设置”中开启通知以接收提醒。';

  @override
  String get deviceDetailPhotosSectionTitle => '照片';

  @override
  String get deviceDetailDeleteDialogTitle => '删除此设备？';

  @override
  String get deviceDetailDeleteDialogMessage => '此操作无法撤销。';

  @override
  String get notificationsGlobalEnabled => '保修通知已启用。';

  @override
  String get notificationsGlobalDisabled => '保修通知已禁用。';

  @override
  String get notificationsEnableInSettings => '在“设置”中启用通知以安排提醒。';

  @override
  String get notificationsDeviceScheduled => '保修提醒已安排。';

  @override
  String get notificationsDeviceExpired => '保修期已结束。';

  @override
  String get notificationsDeviceCancelled => '保修提醒已取消。';

  @override
  String get notificationsPermissionTitle => '允许通知？';

  @override
  String get notificationsPermissionDescription => '启用推送通知以接收您的设备保修提醒。';

  @override
  String get notificationsPermissionNotNow => '暂时不要';

  @override
  String get notificationsPermissionAllow => '允许';

  @override
  String get notificationsPermissionDenied => '通知权限被拒绝。';

  @override
  String cameraCaptureFailed(String error) {
    return '拍照失败：$error';
  }

  @override
  String get cameraTitle => '相机';

  @override
  String get cameraInitializationFailed => '相机初始化失败。';

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

/// The translations for Chinese, using the Han script (`zh_Hans`).
class AppLocalizationsZhHans extends AppLocalizationsZh {
  AppLocalizationsZhHans() : super('zh_Hans');

  @override
  String get appTitle => '设备记录';

  @override
  String get bootPlaceholderMessage => '设置阶段完成。用实际路由替换此屏幕。';

  @override
  String get homeSettingsTooltip => '设置';

  @override
  String get homeSearchHint => '搜索';

  @override
  String get homeNoDevices => '无注册设备';

  @override
  String get homeAddDeviceTooltip => '添加设备';

  @override
  String get homeDDayLabel => '倒计时';

  @override
  String homeDdayMonthsLabel(int months) {
    return 'D-$months 个月';
  }

  @override
  String get settingsTitle => '设置';

  @override
  String get settingsNotificationsToggleTitle => '启用通知';

  @override
  String get settingsNotificationsToggleEnabled => '保修提醒将遵循您的偏好。';

  @override
  String get settingsNotificationsToggleDisabled => '开启以在保修期满前接收提醒。';

  @override
  String get settingsReminderTimeLabel => '提醒时间';

  @override
  String get settingsLanguageTitle => '语言';

  @override
  String get settingsLanguagePickerTitle => '选择语言';

  @override
  String get settingsBackupSectionTitle => '备份与恢复';

  @override
  String settingsVersionValue(String version) {
    return '$version';
  }

  @override
  String get languageEnglish => '英语';

  @override
  String get languageKorean => '韩语';

  @override
  String get commonBackup => '备份';

  @override
  String get commonRestore => '恢复';

  @override
  String get commonVersion => '版本';

  @override
  String get commonSave => '保存';

  @override
  String get commonCancel => '取消';

  @override
  String get commonDelete => '删除';

  @override
  String get commonEdit => '编辑';

  @override
  String get addDeviceSavedMessage => '已保存。';

  @override
  String addDevicePickImagesError(String error) {
    return '选择图片失败：$error';
  }

  @override
  String get addDeviceEditTitle => '编辑设备';

  @override
  String get addDeviceCreateTitle => '添加设备';

  @override
  String get addDeviceCategoryLabel => '类别';

  @override
  String get addDeviceCategoryRequired => '类别是必填项';

  @override
  String get addDeviceModelNameLabel => '型号名称';

  @override
  String get addDeviceModelNameRequired => '型号名称是必填项';

  @override
  String get addDeviceBrandLabel => '品牌';

  @override
  String get addDeviceBrandRequired => '品牌是必填项';

  @override
  String get addDeviceModelNumberLabel => '型号';

  @override
  String get addDeviceModelNumberRequired => '型号是必填项';

  @override
  String get addDevicePurchaseDateLabel => '购买日期';

  @override
  String get addDevicePurchaseDateHint => '选择日期';

  @override
  String get addDevicePurchaseDateRequired => '选择一个购买日期';

  @override
  String get addDevicePurchaseDateFutureError => '购买日期不能在将来';

  @override
  String get addDeviceWarrantyLabel => '保修期（月）';

  @override
  String get addDeviceWarrantyHint => '0 ~ 120';

  @override
  String get addDeviceWarrantyRequired => '保修期是必填项';

  @override
  String get addDeviceDigitsOnly => '仅输入数字';

  @override
  String get addDeviceWarrantyRange => '必须在 0 到 120 之间';

  @override
  String get addDeviceCustomerCenterLabel => '客户服务中心';

  @override
  String get addDeviceCustomerCenterHint => '例如 1588-0000, 010-1234-5678';

  @override
  String get addDeviceCustomerCenterInvalid => '仅限数字和-';

  @override
  String get addDeviceOthersSectionTitle => '其他';

  @override
  String get addDeviceTakePhoto => '拍照';

  @override
  String get addDeviceSelectFromGallery => '从相册选择';

  @override
  String get categoryTv => '电视';

  @override
  String get categoryWasher => '洗衣机';

  @override
  String get categoryComputer => '电脑';

  @override
  String get categoryRefrigerator => '冰箱';

  @override
  String get categoryAirConditioner => '空调';

  @override
  String get categoryCar => '汽车';

  @override
  String get categoryOthers => '其他';

  @override
  String get deviceDetailTitle => '设备详情';

  @override
  String get deviceDetailNotFound => '未找到设备。';

  @override
  String get deviceDetailCategoryLabel => '类别';

  @override
  String get deviceDetailBrandLabel => '品牌';

  @override
  String get deviceDetailModelNameLabel => '型号名称';

  @override
  String get deviceDetailModelNumberLabel => '型号';

  @override
  String get deviceDetailPurchaseDateLabel => '购买日期';

  @override
  String get deviceDetailWarrantyLabel => '保修期（月）';

  @override
  String get deviceDetailCustomerCenterLabel => '客户服务中心';

  @override
  String get deviceDetailNoContact => '未注册客户服务中心。';

  @override
  String deviceDetailCallButton(Object number) {
    return '致电 $number';
  }

  @override
  String get deviceDetailCallError => '无法打开电话拨号器。';

  @override
  String get deviceDetailNotificationsTitle => '保修通知';

  @override
  String deviceDetailNotificationsEnabled(String expiry) {
    return '提醒将发送至 $expiry。';
  }

  @override
  String get deviceDetailNotificationsDisabled => '在“设置”中开启通知以接收提醒。';

  @override
  String get deviceDetailPhotosSectionTitle => '照片';

  @override
  String get deviceDetailDeleteDialogTitle => '删除此设备？';

  @override
  String get deviceDetailDeleteDialogMessage => '此操作无法撤销。';

  @override
  String get notificationsGlobalEnabled => '保修通知已启用。';

  @override
  String get notificationsGlobalDisabled => '保修通知已禁用。';

  @override
  String get notificationsEnableInSettings => '在“设置”中启用通知以安排提醒。';

  @override
  String get notificationsDeviceScheduled => '保修提醒已安排。';

  @override
  String get notificationsDeviceExpired => '保修期已结束。';

  @override
  String get notificationsDeviceCancelled => '保修提醒已取消。';

  @override
  String get notificationsPermissionTitle => '允许通知？';

  @override
  String get notificationsPermissionDescription => '启用推送通知以接收您的设备保修提醒。';

  @override
  String get notificationsPermissionNotNow => '暂时不要';

  @override
  String get notificationsPermissionAllow => '允许';

  @override
  String get notificationsPermissionDenied => '通知权限被拒绝。';

  @override
  String cameraCaptureFailed(String error) {
    return '拍照失败：$error';
  }

  @override
  String get cameraTitle => '相机';

  @override
  String get cameraInitializationFailed => '相机初始化失败。';

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
