import 'package:devicenote/core/utils/date_utils.dart';
import 'package:devicenote/data/repositories/device_repository.dart';
import 'package:devicenote/services/notifications/notification_preferences.dart';
import 'package:devicenote/services/notifications/notification_service.dart';
import 'package:flutter/material.dart';

class NotificationController extends ChangeNotifier {
  NotificationController({
    required NotificationService service,
    required NotificationPreferences preferences,
    required DeviceRepository repository,
  }) : _service = service,
       _preferences = preferences,
       _repository = repository,
       _notificationTime = preferences.notificationTime,
       _notificationsEnabled = preferences.notificationsEnabled,
       _enabledDeviceIds = preferences.enabledDeviceIds {
    if (_notificationsEnabled) {
      Future.microtask(() => _rescheduleAll());
    }
  }

  static const List<int> _alertOffsets = [30, 7, 0];

  final NotificationService _service;
  final NotificationPreferences _preferences;
  final DeviceRepository _repository;
  final Set<String> _enabledDeviceIds;

  bool _notificationsEnabled;
  bool _permissionGranted = false;
  TimeOfDay _notificationTime;

  bool get notificationsEnabled => _notificationsEnabled;
  TimeOfDay get notificationTime => _notificationTime;

  bool devicePreference(String deviceId) =>
      _enabledDeviceIds.contains(deviceId);

  Future<void> setGlobalEnabled({
    required BuildContext context,
    required bool enabled,
  }) async {
    if (enabled == _notificationsEnabled) {
      return;
    }

    final messenger = ScaffoldMessenger.of(context);

    if (enabled) {
      final granted = await _ensurePermission(context, messenger);
      if (!granted) {
        return;
      }
      _notificationsEnabled = true;
      await _preferences.setNotificationsEnabled(true);
      await _rescheduleAll();
      messenger.showSnackBar(
        const SnackBar(content: Text('Warranty notifications enabled.')),
      );
    } else {
      _notificationsEnabled = false;
      await _preferences.setNotificationsEnabled(false);
      for (final id in _enabledDeviceIds) {
        await _service.cancelWarrantyAlerts(id, _alertOffsets);
      }
      messenger.showSnackBar(
        const SnackBar(content: Text('Warranty notifications disabled.')),
      );
    }

    notifyListeners();
  }

  Future<void> setDevicePreference({
    required BuildContext context,
    required Device device,
    required bool enabled,
  }) async {
    final messenger = ScaffoldMessenger.of(context);

    if (enabled) {
      _enabledDeviceIds.add(device.id);
    } else {
      _enabledDeviceIds.remove(device.id);
    }
    await _preferences.setEnabledDeviceIds(_enabledDeviceIds);

    if (!_notificationsEnabled) {
      if (enabled) {
        messenger.showSnackBar(
          const SnackBar(
            content: Text(
              'Enable notifications in Settings to schedule alerts.',
            ),
          ),
        );
      }
      notifyListeners();
      return;
    }

    if (enabled) {
      final scheduled = await _scheduleDevice(device);
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            scheduled
                ? 'Warranty reminders scheduled.'
                : 'Warranty period already ended.',
          ),
        ),
      );
    } else {
      await _service.cancelWarrantyAlerts(device.id, _alertOffsets);
      messenger.showSnackBar(
        const SnackBar(content: Text('Warranty reminders cancelled.')),
      );
    }

    notifyListeners();
  }

  Future<void> setNotificationTime(TimeOfDay time) async {
    _notificationTime = time;
    await _preferences.setNotificationTime(time);
    if (_notificationsEnabled) {
      await _rescheduleAll();
    }
    notifyListeners();
  }

  Future<void> onDeviceRemoved(String deviceId) async {
    final removed = _enabledDeviceIds.remove(deviceId);
    if (removed) {
      await _preferences.setEnabledDeviceIds(_enabledDeviceIds);
    }
    await _service.cancelWarrantyAlerts(deviceId, _alertOffsets);
  }

  Future<void> onDeviceSaved(Device device) async {
    if (!_notificationsEnabled) return;
    if (!_enabledDeviceIds.contains(device.id)) return;
    await _scheduleDevice(device);
  }

  Future<bool> _scheduleDevice(Device device) async {
    final expiry = DateUtilsX.addMonths(
      device.purchaseDate,
      device.warrantyMonths,
    );
    final now = DateTime.now();
    final hasUpcoming = _alertOffsets.any((offset) {
      final target = DateTime(
        expiry.year,
        expiry.month,
        expiry.day,
        _notificationTime.hour,
        _notificationTime.minute,
      ).subtract(Duration(days: offset));
      return !target.isBefore(now);
    });

    await _service.cancelWarrantyAlerts(device.id, _alertOffsets);
    if (!hasUpcoming) {
      return false;
    }

    await _service.scheduleWarrantyAlerts(
      device,
      _alertOffsets,
      _notificationTime,
    );
    return true;
  }

  Future<void> _rescheduleAll() async {
    final devices = _enabledDeviceIds
        .map(_repository.findById)
        .whereType<Device>()
        .toList();
    if (devices.isEmpty) return;
    await _service.resyncAll(devices, _alertOffsets, _notificationTime);
  }

  Future<bool> _ensurePermission(
    BuildContext context,
    ScaffoldMessengerState messenger,
  ) async {
    if (_permissionGranted) return true;

    final consent = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Allow notifications?'),
        content: const Text(
          'Enable push notifications to receive warranty reminders for your devices.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Not now'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Allow'),
          ),
        ],
      ),
    );

    if (consent != true) {
      return false;
    }

    final granted = await _service.requestPermission();
    _permissionGranted = granted;

    if (!granted) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Notification permission denied.')),
      );
    }

    return granted;
  }
}
