enum DeviceCategory {
  tv,
  washer,
  refrigerator,
  computer,
  laptop,
  smartphone,
  tablet,
  audio,
  camera,
  other,
}

extension DeviceCategoryX on DeviceCategory {
  String get displayName {
    switch (this) {
      case DeviceCategory.tv:
        return 'TV';
      case DeviceCategory.washer:
        return 'Washer';
      case DeviceCategory.refrigerator:
        return 'Refrigerator';
      case DeviceCategory.computer:
        return 'Computer';
      case DeviceCategory.laptop:
        return 'Laptop';
      case DeviceCategory.smartphone:
        return 'Smartphone';
      case DeviceCategory.tablet:
        return 'Tablet';
      case DeviceCategory.audio:
        return 'Audio';
      case DeviceCategory.camera:
        return 'Camera';
      case DeviceCategory.other:
        return 'Other';
    }
  }
}
