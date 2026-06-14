import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

// ── Checkpoint Model ─────────────────────────────────────────────────────────

class CheckpointData {
  final String id;
  final String checkpoint;
  final String city;
  final String enteringStatus;
  final String leavingStatus;
  final String lastUpdated;

  CheckpointData({
    required this.id,
    required this.checkpoint,
    required this.city,
    required this.enteringStatus,
    required this.leavingStatus,
    required this.lastUpdated,
  });

  factory CheckpointData.fromJson(Map<String, dynamic> json) => CheckpointData(
        id: json['id'] ?? '',
        checkpoint: json['checkpoint'] ?? '',
        city: json['city'] ?? '',
        enteringStatus: json['entering_status'] ?? '',
        leavingStatus: json['leaving_status'] ?? '',
        lastUpdated: json['last_updated'] ?? '',
      );
}

// ── Checkpoint Service ────────────────────────────────────────────────────────

class CheckpointService {
  static const String _apiKey =
      'arw_25d6362cde01937614b022a8f92e5298fae369989b2da4d8fef2aa4384656947';
  static const String _baseUrl = 'https://aweenrayeh.com';

  static const Map<String, String> _cityMap = {
    'رام الله': 'ramallah', 'البيرة': 'ramallah', 'بيتونيا': 'ramallah',
    'نابلس': 'nablus', 'بلاطة': 'nablus',
    'الخليل': 'hebron', 'حلحول': 'hebron', 'دورا': 'hebron',
    'بيت لحم': 'bethlehem', 'بيت جالا': 'bethlehem', 'بيت ساحور': 'bethlehem',
    'أريحا': 'jericho',
    'جنين': 'jenin',
    'طولكرم': 'tulkarm',
    'قلقيلية': 'qalqilya',
    'سلفيت': 'salfit',
    'طوباس': 'tubas',
    'القدس': 'jerusalem', 'أبو ديس': 'jerusalem', 'العيزرية': 'jerusalem',
    'ramallah': 'ramallah', 'nablus': 'nablus', 'hebron': 'hebron',
    'bethlehem': 'bethlehem', 'jericho': 'jericho', 'jenin': 'jenin',
    'tulkarm': 'tulkarm', 'qalqilya': 'qalqilya', 'salfit': 'salfit',
    'tubas': 'tubas', 'jerusalem': 'jerusalem',
  };

  static String? _extractSlug(String location) {
    final city = location.split(RegExp(r'\s*[-–]\s*')).first.trim();
    return _cityMap[city] ?? _cityMap[city.toLowerCase()];
  }

  Future<List<CheckpointData>> _fetchForSlug(String slug) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/api/v1/checkpoints/city/$slug'),
        headers: {'X-API-Key': _apiKey, 'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body)['data'] ?? [];
        return data.map((e) => CheckpointData.fromJson(e)).toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  Future<List<CheckpointData>> fetchForTrip(
      String pickupLocation, String dropoffLocation) async {
    final slugs = <String>{};
    final s1 = _extractSlug(pickupLocation);
    final s2 = _extractSlug(dropoffLocation);
    if (s1 != null) slugs.add(s1);
    if (s2 != null) slugs.add(s2);
    if (slugs.isEmpty) return [];
    final results = await Future.wait(slugs.map(_fetchForSlug));
    final seen = <String>{};
    return results.expand((list) => list).where((cp) => seen.add(cp.id)).toList();
  }
}

// ── Notification Service ──────────────────────────────────────────────────────

class CheckpointNotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  static Future<void> _ensureInit() async {
    if (_initialized) return;
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await _plugin.initialize(const InitializationSettings(android: android));
    // Request permission on Android 13+
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    _initialized = true;
  }

  static Future<void> showCheckpointAlert(
      List<CheckpointData> checkpoints) async {
    await _ensureInit();
    final blocked = checkpoints.where((c) => c.enteringStatus != 'سالك').toList();
    final title = blocked.isNotEmpty ? '⚠️ حاجز مغلق على طريقك!' : 'ℹ️ حاجز على طريقك';
    final body = blocked.isNotEmpty
        ? '${blocked.length} حاجز مغلق - قد يكون هناك تأخير في رحلتك'
        : '${checkpoints.length} حاجز على الطريق - الطريق سالك حالياً';
    await _plugin.show(
      42,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'checkpoints_channel',
          'Checkpoint Alerts',
          channelDescription: 'إشعارات الحواجز على طريقك',
          importance: Importance.high,
          priority: Priority.high,
          playSound: true,
        ),
      ),
    );
  }
}
