import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static const _keyEnabled = 'notif_enabled';
  static const _keyHour    = 'notif_hour';
  static const _keyMinute  = 'notif_minute';

  Future<bool> isEnabled() async {
    final p = await SharedPreferences.getInstance();
    return p.getBool(_keyEnabled) ?? false;
  }

  Future<TimeOfDay> getScheduledTime() async {
    final p = await SharedPreferences.getInstance();
    return TimeOfDay(
      hour:   p.getInt(_keyHour)   ?? 20,
      minute: p.getInt(_keyMinute) ?? 0,
    );
  }

  Future<void> saveSettings(bool enabled, TimeOfDay time) async {
    final p = await SharedPreferences.getInstance();
    await p.setBool(_keyEnabled, enabled);
    await p.setInt(_keyHour,     time.hour);
    await p.setInt(_keyMinute,   time.minute);
  }
}
