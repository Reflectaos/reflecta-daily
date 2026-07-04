import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/notification_service.dart';

final notificationServiceProvider = Provider<NotificationService>(
  (ref) => NotificationService());

class NotifState {
  final bool enabled;
  final TimeOfDay time;
  final bool loading;
  const NotifState({
    this.enabled = false,
    this.time    = const TimeOfDay(hour: 20, minute: 0),
    this.loading = false,
  });
  NotifState copyWith({bool? enabled, TimeOfDay? time, bool? loading}) =>
    NotifState(
      enabled: enabled ?? this.enabled,
      time:    time    ?? this.time,
      loading: loading ?? this.loading,
    );
}

class NotifNotifier extends StateNotifier<NotifState> {
  final NotificationService _svc;
  NotifNotifier(this._svc) : super(const NotifState()) { _load(); }

  Future<void> _load() async {
    state = state.copyWith(loading: true);
    final enabled = await _svc.isEnabled();
    final time    = await _svc.getScheduledTime();
    state = state.copyWith(enabled: enabled, time: time, loading: false);
  }

  Future<void> toggle(bool val) async {
    state = state.copyWith(enabled: val);
    await _svc.saveSettings(val, state.time);
  }

  Future<void> setTime(TimeOfDay time) async {
    state = state.copyWith(time: time);
    await _svc.saveSettings(state.enabled, time);
  }
}

final notifProvider = StateNotifierProvider<NotifNotifier, NotifState>((ref) =>
  NotifNotifier(ref.read(notificationServiceProvider)));
