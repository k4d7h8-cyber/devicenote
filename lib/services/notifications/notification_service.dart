import 'package:devicenote/core/utils/date_utils.dart';
import 'package:devicenote/data/repositories/device_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

abstract class NotificationService {
  Future<void> initialize();
  Future<bool> requestPermission();
  Future<void> scheduleWarrantyAlerts(
    Device device,
    List<int> daysBefore,
    TimeOfDay timeOfDay,
  );
  Future<void> cancelWarrantyAlerts(String deviceId, List<int> daysBefore);
  Future<void> resyncAll(
    List<Device> devices,
    List<int> daysBefore,
    TimeOfDay timeOfDay,
  );
}

class LocalNotificationService implements NotificationService {
  LocalNotificationService();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  static const WindowsInitializationSettings _windowsInitSettings =
      WindowsInitializationSettings(
        appName: 'DeviceNote',
        appUserModelId: 'DeviceNote.DeviceNote.Desktop',
        guid: 'b36d9e42-894e-4d4a-9a79-3fd0f7639aaa',
      );

  static const WindowsNotificationDetails _windowsNotificationDetails =
      WindowsNotificationDetails();

  static const _channelId = 'warranty_alerts';
  static const _channelName = 'Warranty Alerts';
  static const _channelDescription =
      'Reminders ahead of device warranty expiration dates';

  AndroidNotificationDetails get _androidDetails =>
      const AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
      );

  DarwinNotificationDetails get _iosDetails =>
      const DarwinNotificationDetails();

  @override
  Future<void> initialize() async {
    if (_initialized) return;

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    final initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
      windows: _resolveWindowsInitializationSettings(),
    );

    await _plugin.initialize(initSettings);

    tzdata.initializeTimeZones();
    final String timeZoneName = await _safeLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    _initialized = true;
  }

  @override
  Future<bool> requestPermission() async {
    await initialize();

    final androidImpl = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    final iosImpl = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();

    final androidGranted =
        await androidImpl?.requestNotificationsPermission() ?? true;
    final iosGranted =
        await iosImpl?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        ) ??
        true;

    return androidGranted && iosGranted;
  }

  @override
  Future<void> scheduleWarrantyAlerts(
    Device device,
    List<int> daysBefore,
    TimeOfDay timeOfDay,
  ) async {
    await initialize();

    final expiryUtc = DateUtilsX.addMonths(
      device.purchaseDate,
      device.warrantyMonths,
    ).toUtc();

    for (final days in daysBefore) {
      final triggerUtc = _targetDate(expiryUtc, days, timeOfDay);
      if (triggerUtc.isBefore(DateTime.now().toUtc())) {
        await _plugin.cancel(_notificationId(device.id, days));
        continue;
      }

      final tzDateTime = tz.TZDateTime.from(triggerUtc, tz.local);
      final details = NotificationDetails(
        android: _androidDetails,
        iOS: _iosDetails,
        windows: _resolveWindowsNotificationDetails(),
      );

      await _plugin.zonedSchedule(
        _notificationId(device.id, days),
        'Warranty reminder',
        _buildMessage(device.name, expiryUtc, days),
        tzDateTime,
        details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        payload: device.id,
      );
    }
  }

  @override
  Future<void> cancelWarrantyAlerts(
    String deviceId,
    List<int> daysBefore,
  ) async {
    await initialize();
    for (final days in daysBefore) {
      await _plugin.cancel(_notificationId(deviceId, days));
    }
  }

  @override
  Future<void> resyncAll(
    List<Device> devices,
    List<int> daysBefore,
    TimeOfDay timeOfDay,
  ) async {
    await initialize();
    for (final device in devices) {
      await cancelWarrantyAlerts(device.id, daysBefore);
      await scheduleWarrantyAlerts(device, daysBefore, timeOfDay);
    }
  }

  WindowsInitializationSettings? _resolveWindowsInitializationSettings() {
    if (kIsWeb) return null;
    if (defaultTargetPlatform != TargetPlatform.windows) return null;
    return _windowsInitSettings;
  }

  WindowsNotificationDetails? _resolveWindowsNotificationDetails() {
    if (kIsWeb) return null;
    if (defaultTargetPlatform != TargetPlatform.windows) return null;
    return _windowsNotificationDetails;
  }

  DateTime _targetDate(DateTime expiryUtc, int daysBefore, TimeOfDay time) {
    final date = expiryUtc.subtract(Duration(days: daysBefore));
    return DateTime.utc(date.year, date.month, date.day, time.hour, time.minute);
  }

  int _notificationId(String deviceId, int daysBefore) {
    // Deterministic hash based on device id and offset.
    var hash = daysBefore & 0x7fffffff;
    for (final code in deviceId.codeUnits) {
      hash = (hash * 31 + code) & 0x7fffffff;
    }
    return hash;
  }

  String _buildMessage(String deviceName, DateTime expiry, int daysBefore) {
    final expiryLabel = DateFormat.yMd(Intl.getCurrentLocale()).format(expiry.toLocal());
    if (daysBefore >= 30) {
      return 'The warranty for $deviceName expires in one month on $expiryLabel. Please check for any issues before it ends.';
    }
    if (daysBefore >= 7) {
      return 'The warranty for $deviceName is ending soon. Coverage lasts until $expiryLabel.';
    }
    return 'The warranty for $deviceName ends today. Future repairs will be charged.';
  }

  Future<String> _safeLocalTimezone() async {
    try {
      final timezoneInfo = await FlutterTimezone.getLocalTimezone();
      return timezoneInfo.identifier;
    } catch (_) {
      return tz.local.name;
    }
  }
}
