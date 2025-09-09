import 'package:devicenote/data/models/device.dart';

/// 실제 알림은 4~5단계에서 flutter_local_notifications와 연결.
/// 지금은 개발 단계용 스텁이라 콘솔 로그만 찍습니다.
abstract class NotificationService {
  Future<void> scheduleWarrantyAlerts(Device device, List<int> daysBefore);
  Future<void> cancelWarrantyAlerts(String deviceId);
  Future<void> resyncAll(List<Device> devices, List<int> daysBefore);
}

class DebugNotificationService implements NotificationService {
  @override
  Future<void> scheduleWarrantyAlerts(Device device, List<int> daysBefore) async {
    // ignore: avoid_print
    print('[NOTI] schedule ${device.name} (${device.id}) expires ${device.warrantyExpiresAt} daysBefore=$daysBefore');
  }

  @override
  Future<void> cancelWarrantyAlerts(String deviceId) async {
    // ignore: avoid_print
    print('[NOTI] cancel $deviceId');
  }

  @override
  Future<void> resyncAll(List<Device> devices, List<int> daysBefore) async {
    // ignore: avoid_print
    print('[NOTI] resync ${devices.length} items with $daysBefore');
  }
}
