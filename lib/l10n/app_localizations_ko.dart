// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => '기록 노트';

  @override
  String get bootPlaceholderMessage => '설정 단계 완료. 이 화면을 실제 경로로 교체하세요.';

  @override
  String get homeSettingsTooltip => '설정';

  @override
  String get homeSearchHint => '검색';

  @override
  String get homeNoDevices => '등록된 기기가 없습니다.';

  @override
  String get homeAddDeviceTooltip => '기기 추가';

  @override
  String get homeDDayLabel => 'D-day';

  @override
  String homeDdayMonthsLabel(int months) {
    return 'D-$months개월';
  }

  @override
  String get settingsTitle => '설정';

  @override
  String get settingsNotificationsToggleTitle => '알림 활성화';

  @override
  String get settingsNotificationsToggleEnabled => '보증 알림은 설정에 따라 발송됩니다.';

  @override
  String get settingsNotificationsToggleDisabled => '활성화하면 보증 만료 전에 알림을 받습니다.';

  @override
  String get settingsReminderTimeLabel => '알림 시간';

  @override
  String get settingsLanguageTitle => '언어';

  @override
  String get settingsLanguagePickerTitle => '언어 선택';

  @override
  String get settingsBackupSectionTitle => '백업 및 복원';

  @override
  String settingsVersionValue(String version) {
    return '$version';
  }

  @override
  String get languageEnglish => '영어';

  @override
  String get languageKorean => '한국어';

  @override
  String get commonBackup => '백업';

  @override
  String get commonRestore => '복원';

  @override
  String get commonVersion => '버전';

  @override
  String get commonSave => '저장';

  @override
  String get commonCancel => '취소';

  @override
  String get commonDelete => '삭제';

  @override
  String get commonEdit => '수정';

  @override
  String get addDeviceSavedMessage => '저장되었습니다.';

  @override
  String addDevicePickImagesError(String error) {
    return '이미지를 선택하지 못했습니다: $error';
  }

  @override
  String get addDeviceEditTitle => '기기 수정';

  @override
  String get addDeviceCreateTitle => '기기 추가';

  @override
  String get addDeviceCategoryLabel => '카테고리';

  @override
  String get addDeviceCategoryRequired => '카테고리는 필수 항목입니다';

  @override
  String get addDeviceModelNameLabel => '모델명';

  @override
  String get addDeviceModelNameRequired => '모델명은 필수 항목입니다';

  @override
  String get addDeviceBrandLabel => '브랜드';

  @override
  String get addDeviceBrandRequired => '브랜드는 필수 항목입니다';

  @override
  String get addDeviceModelNumberLabel => '모델 번호';

  @override
  String get addDeviceModelNumberRequired => '모델 번호는 필수 항목입니다';

  @override
  String get addDevicePurchaseDateLabel => '구매일';

  @override
  String get addDevicePurchaseDateHint => '날짜 선택';

  @override
  String get addDevicePurchaseDateRequired => '구매일을 선택하세요';

  @override
  String get addDevicePurchaseDateFutureError => '구매일은 미래일 수 없습니다';

  @override
  String get addDeviceWarrantyLabel => '보증 기간(개월)';

  @override
  String get addDeviceWarrantyHint => '0 ~ 120';

  @override
  String get addDeviceWarrantyRequired => '보증 기간은 필수 항목입니다';

  @override
  String get addDeviceDigitsOnly => '숫자만 입력하세요';

  @override
  String get addDeviceWarrantyRange => '0에서 120 사이여야 합니다';

  @override
  String get addDeviceCustomerCenterLabel => '고객센터';

  @override
  String get addDeviceCustomerCenterHint => '예: 1588-0000, 010-1234-5678';

  @override
  String get addDeviceCustomerCenterInvalid => '숫자와 -만 입력 가능합니다';

  @override
  String get addDeviceOthersSectionTitle => '기타';

  @override
  String get addDeviceTakePhoto => '사진 촬영';

  @override
  String get addDeviceSelectFromGallery => '갤러리에서 선택';

  @override
  String get categoryTv => 'TV';

  @override
  String get categoryWasher => '세탁기';

  @override
  String get categoryComputer => '컴퓨터';

  @override
  String get categoryRefrigerator => '냉장고';

  @override
  String get categoryAirConditioner => '에어컨';

  @override
  String get categoryCar => '자동차';

  @override
  String get categoryOthers => '기타';

  @override
  String get deviceDetailTitle => '기기 상세 정보';

  @override
  String get deviceDetailNotFound => '기기를 찾을 수 없습니다.';

  @override
  String get deviceDetailCategoryLabel => '카테고리';

  @override
  String get deviceDetailBrandLabel => '브랜드';

  @override
  String get deviceDetailModelNameLabel => '모델명';

  @override
  String get deviceDetailModelNumberLabel => '모델 번호';

  @override
  String get deviceDetailPurchaseDateLabel => '구매일';

  @override
  String get deviceDetailWarrantyLabel => '보증 기간(개월)';

  @override
  String get deviceDetailCustomerCenterLabel => '고객센터';

  @override
  String get deviceDetailNoContact => '등록된 고객센터가 없습니다.';

  @override
  String deviceDetailCallButton(Object number) {
    return '$number로 전화 걸기';
  }

  @override
  String get deviceDetailCallError => '전화 걸기를 실행할 수 없습니다.';

  @override
  String get deviceDetailNotificationsTitle => '보증 알림';

  @override
  String deviceDetailNotificationsEnabled(String expiry) {
    return '보증 만료일($expiry)까지 알림이 발송됩니다.';
  }

  @override
  String get deviceDetailNotificationsDisabled => '알림을 받으려면 설정에서 알림을 켜세요.';

  @override
  String get deviceDetailPhotosSectionTitle => '사진';

  @override
  String get deviceDetailDeleteDialogTitle => '이 기기를 삭제하시겠습니까?';

  @override
  String get deviceDetailDeleteDialogMessage => '이 작업은 되돌릴 수 없습니다.';

  @override
  String get notificationsGlobalEnabled => '보증 알림이 활성화되었습니다.';

  @override
  String get notificationsGlobalDisabled => '보증 알림이 비활성화되었습니다.';

  @override
  String get notificationsEnableInSettings => '알림을 설정에서 활성화하여 알림 일정을 만드세요.';

  @override
  String get notificationsDeviceScheduled => '보증 알림이 예약되었습니다.';

  @override
  String get notificationsDeviceExpired => '보증 기간이 이미 만료되었습니다.';

  @override
  String get notificationsDeviceCancelled => '보증 알림이 취소되었습니다.';

  @override
  String get notificationsPermissionTitle => '알림을 허용하시겠습니까?';

  @override
  String get notificationsPermissionDescription =>
      '기기 보증 알림을 받으려면 푸시 알림을 활성화하세요.';

  @override
  String get notificationsPermissionNotNow => '나중에';

  @override
  String get notificationsPermissionAllow => '허용';

  @override
  String get notificationsPermissionDenied => '알림 권한이 거부되었습니다.';

  @override
  String cameraCaptureFailed(String error) {
    return '사진 촬영 실패: $error';
  }

  @override
  String get cameraTitle => '카메라';

  @override
  String get cameraInitializationFailed => '카메라 초기화 실패.';
}
