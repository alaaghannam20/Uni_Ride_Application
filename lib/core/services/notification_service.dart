import 'package:flutter/foundation.dart';
import 'package:uni_ride_application/core/network/app_endpoints.dart';
import 'package:uni_ride_application/core/services/dio_factory/dio_factory.dart';
import 'package:uni_ride_application/features/notifications/data/models/notification_model.dart';

class NotificationService {
  Future<List<NotificationModel>> fetchNotifications() async {
    final response = await DioFactory.get(AppEndpoints.notifications);
    debugPrint('=== NOTIFICATIONS raw: ${response.data}');

    List<dynamic> data;
    if (response.data is List) {
      data = response.data as List;
    } else if (response.data is Map && response.data['data'] is List) {
      data = response.data['data'] as List;
    } else {
      data = [];
    }

    return data.map((e) => NotificationModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> markAllRead() async {
    await DioFactory.put(AppEndpoints.notificationsRead);
  }

  Future<void> markOneRead(int id) async {
    await DioFactory.put(AppEndpoints.notificationRead(id));
  }
}
