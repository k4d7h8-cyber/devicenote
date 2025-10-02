import 'package:devicenote/data/repositories/device_repository.dart';
import 'package:devicenote/l10n/app_localizations.dart';

String categoryDisplayName(AppLocalizations l10n, DeviceCategory category) {
  switch (category) {
    case DeviceCategory.tv:
      return l10n.categoryTv;
    case DeviceCategory.washer:
      return l10n.categoryWasher;
    case DeviceCategory.computer:
      return l10n.categoryComputer;
    case DeviceCategory.refrigerator:
      return l10n.categoryRefrigerator;
    case DeviceCategory.aircon:
      return l10n.categoryAirConditioner;
    case DeviceCategory.car:
      return l10n.categoryCar;
    case DeviceCategory.etc:
      return l10n.categoryOthers;
  }
}

String homeCategoryPrompt(AppLocalizations l10n) {
  switch (l10n.localeName) {
    case 'ko':
      return '등록할 기기를 선택해주세요';
    case 'bn':
      return 'নিবন্ধনের জন্য একটি ডিভাইস ক্যাটাগরি নির্বাচন করুন';
    default:
      return 'Choose a device category to register';
  }
}

List<String> categoryEmptyMessageLines(AppLocalizations l10n) {
  switch (l10n.localeName) {
    case 'ko':
      return ['등록된 기기가 아직 없습니다.', '“+”버튼을 눌러 등록해보세요'];
    case 'bn':
      return ['কোনো ডিভাইস এখনও নিবন্ধিত হয়নি।', '“+” বোতামে চাপ দিয়ে নতুন ডিভাইস যোগ করুন।'];
    default:
      return ['No devices registered yet.', 'Tap the “+” button to add one.'];
  }
}

String searchNoResultsMessage(AppLocalizations l10n) {
  switch (l10n.localeName) {
    case 'ko':
      return '검색과 일치하는 기기가 없습니다.';
    case 'bn':
      return 'আপনার অনুসন্ধানের সাথে কোনো ডিভাইস মেলেনি।';
    default:
      return 'No devices match your search.';
  }
}
