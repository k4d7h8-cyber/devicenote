// 최소 정의: Hive 애너테이션 전부 제거!
enum DeviceCategory {
  tv, washer, refrigerator, computer, laptop, smartphone, tablet, audio, camera, other,
}

extension DeviceCategoryX on DeviceCategory {
  String get displayName {
    switch (this) {
      case DeviceCategory.tv: return 'TV';
      case DeviceCategory.washer: return '세탁기';
      case DeviceCategory.refrigerator: return '냉장고';
      case DeviceCategory.computer: return '컴퓨터';
      case DeviceCategory.laptop: return '노트북';
      case DeviceCategory.smartphone: return '스마트폰';
      case DeviceCategory.tablet: return '태블릿';
      case DeviceCategory.audio: return '오디오';
      case DeviceCategory.camera: return '카메라';
      case DeviceCategory.other: return '기타';
    }
  }
}
