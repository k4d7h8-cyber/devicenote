import 'package:devicenote/core/utils/date_utils.dart';
import 'package:devicenote/data/repositories/device_repository.dart';
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
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  bool _initialized = false;

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
    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
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

    final expiry = DateUtilsX.addMonths(
      device.purchaseDate,
      device.warrantyMonths,
    );

    for (final days in daysBefore) {
      final trigger = _targetDate(expiry, days, timeOfDay);
      if (trigger.isBefore(DateTime.now())) {
        await _plugin.cancel(_notificationId(device.id, days));
        continue;
      }

      final tzDateTime = tz.TZDateTime.from(trigger, tz.local);
      final details = NotificationDetails(
        android: _androidDetails,
        iOS: _iosDetails,
      );

      await _plugin.zonedSchedule(
        _notificationId(device.id, days),
        'Warranty reminder',
        _buildMessage(device.name, expiry, days),
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

  DateTime _targetDate(DateTime expiry, int daysBefore, TimeOfDay time) {
    final date = expiry.subtract(Duration(days: daysBefore));
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
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
    final expiryLabel = _dateFormat.format(expiry);
    if (daysBefore >= 30) {
      return '등록하신 $deviceName의 보증 기간이 한 달 후인 $expiryLabel에 만료될 예정입니다. 만료 전 이상 유무를 점검하세요.';
    }
    if (daysBefore >= 7) {
      return '등록하신 $deviceName의 보증 기간이 곧 만료됩니다. 보증 기간은 $expiryLabel까지입니다.';
    }
    return '오늘부로 $deviceName의 보증 기간이 만료되었습니다. 이제 유상 수리로 전환됩니다.';
  }

  Future<String> _safeLocalTimezone() async {
    try {
      return await FlutterTimezone.getLocalTimezone();
    } catch (_) {
      return tz.local.name;
    }
  }
}
