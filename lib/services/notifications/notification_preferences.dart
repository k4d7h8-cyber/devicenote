import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPreferences {
  NotificationPreferences._(this._prefs);

  static const _keyEnabled = 'notifications_enabled';
  static const _keyHour = 'notifications_hour';
  static const _keyMinute = 'notifications_minute';
  static const _keyDeviceIds = 'notifications_device_ids';

  final SharedPreferences _prefs;

  static Future<NotificationPreferences> create() async {
    final prefs = await SharedPreferences.getInstance();
    return NotificationPreferences._(prefs);
  }

  bool get notificationsEnabled => _prefs.getBool(_keyEnabled) ?? false;

  Future<void> setNotificationsEnabled(bool value) async {
    await _prefs.setBool(_keyEnabled, value);
  }

  TimeOfDay get notificationTime {
    final hour = _prefs.getInt(_keyHour);
    final minute = _prefs.getInt(_keyMinute);
    if (hour == null || minute == null) {
      return const TimeOfDay(hour: 9, minute: 0);
    }
    return TimeOfDay(hour: hour, minute: minute);
  }

  Future<void> setNotificationTime(TimeOfDay time) async {
    await _prefs.setInt(_keyHour, time.hour);
    await _prefs.setInt(_keyMinute, time.minute);
  }

  Set<String> get enabledDeviceIds {
    final raw = _prefs.getString(_keyDeviceIds);
    if (raw == null || raw.isEmpty) {
      return <String>{};
    }
    final decoded = jsonDecode(raw);
    if (decoded is List) {
      return decoded.whereType<String>().toSet();
    }
    return <String>{};
  }

  Future<void> setEnabledDeviceIds(Set<String> ids) async {
    await _prefs.setString(_keyDeviceIds, jsonEncode(ids.toList()));
  }
}
