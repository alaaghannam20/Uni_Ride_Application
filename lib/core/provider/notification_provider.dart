import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/services/notification_service.dart';
import 'package:uni_ride_application/features/notifications/data/models/notification_model.dart';

enum NotificationLoadState { idle, loading, success, error }

class NotificationProvider extends ChangeNotifier {
  final NotificationService _service = NotificationService();

  NotificationLoadState _state = NotificationLoadState.idle;
  NotificationLoadState get state => _state;

  List<NotificationModel> _notifications = [];
  List<NotificationModel> get notifications => _notifications;

  int get unreadCount => _notifications.where((n) => !n.isRead).length;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<void> fetchNotifications() async {
    _state = NotificationLoadState.loading;
    notifyListeners();
    try {
      _notifications = await _service.fetchNotifications();
      _state = NotificationLoadState.success;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _state = NotificationLoadState.error;
    }
    notifyListeners();
  }

  Future<void> markAllRead() async {
    _notifications = _notifications.map((n) => n.copyWith(isRead: true)).toList();
    notifyListeners();
    try {
      await _service.markAllRead();
    } catch (e) {
      debugPrint('=== markAllRead error: $e');
    }
  }

  Future<void> markOneRead(int id) async {
    try {
      await _service.markOneRead(id);
      _notifications = _notifications.map((n) =>
        n.notificationId == id ? n.copyWith(isRead: true) : n,
      ).toList();
      notifyListeners();
    } catch (_) {}
  }
}
