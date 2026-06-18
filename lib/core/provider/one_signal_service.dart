import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/storage/app_prefs.dart';

class OneSignalService {
  static const String appId = 'b3cbe68c-ec75-4b0c-b12a-067a6a327a00';

  static final OneSignalService _singleton = OneSignalService._internal();

  factory OneSignalService() => _singleton;

  OneSignalService._internal();

  bool _initialized = false;
  String? _loggedExternalUserId;
  GlobalKey<NavigatorState>? _navigatorKey;

  void setNavigatorKey(GlobalKey<NavigatorState> key) {
    _navigatorKey = key;
  }

  Future<void> initialize({
    required String languageCode,
    String? externalUserId,
  }) async {
    if (_initialized) {
      await _setLanguage(languageCode);

      if ((externalUserId ?? '').trim().isNotEmpty) {
        await _ensureLogin(externalUserId!.trim());
      }

      return;
    }

    if (kDebugMode) {
      OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    }

    OneSignal.initialize(appId);

    await _setLanguage(languageCode);

    final permissionGranted =
        await OneSignal.Notifications.requestPermission(true);

    if (kDebugMode) {
      debugPrint('OneSignal permission granted: $permissionGranted');
    }

    if (permissionGranted && (externalUserId ?? '').trim().isNotEmpty) {
      await _ensureLogin(externalUserId!.trim());
    }

    OneSignal.Notifications.addClickListener((event) {
      if (kDebugMode) {
        debugPrint('Notification clicked: ${event.notification.title}');
      }
      _handleNotificationTap(event.notification.additionalData);
    });

    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      event.notification.display();
    });

    _initialized = true;
  }

  void _handleNotificationTap(Map<String, dynamic>? data) {
    if (_navigatorKey == null) return;

    final rawType = data?['type'] as String?;
    final type = rawType?.toLowerCase();
    final rawTripId = data?['tripId'];
    final tripId = rawTripId is int
        ? rawTripId
        : int.tryParse(rawTripId?.toString() ?? '');

    final userType = AppPrefs.getUserType() ?? '';
    final isDriver = userType == 'driver' || userType == 'carpool';

    switch (type) {
      // backend: "trip" / "Trip"  →  trip started or updated
      case 'trip':
      case 'trip_start':
      case 'trip_update':
        if (tripId != null) {
          _navigatorKey!.currentState?.pushNamed(
            Routes.tripDetails,
            arguments: tripId,
          );
        } else {
          _navigatorKey!.currentState?.pushNamedAndRemoveUntil(
            isDriver ? Routes.driverhome : Routes.home,
            (route) => false,
          );
        }
        break;

      // backend: "booking"  →  driver gets new booking / passenger booking confirmed
      case 'booking':
      case 'booking_confirmed':
      case 'trip_cancelled':
        if (isDriver) {
          _navigatorKey!.currentState?.pushNamedAndRemoveUntil(
            Routes.driverhome,
            (route) => false,
          );
        } else {
          _navigatorKey!.currentState?.pushNamedAndRemoveUntil(
            Routes.home,
            (route) => false,
            arguments: {'tabIndex': 1},
          );
        }
        break;

      // backend: "admin"  →  admin approved driver account
      case 'admin':
      case 'admin_approved':
      case 'new_booking':
        _navigatorKey!.currentState?.pushNamedAndRemoveUntil(
          Routes.driverhome,
          (route) => false,
        );
        break;

      default:
        _navigatorKey!.currentState?.pushNamedAndRemoveUntil(
          isDriver ? Routes.driverhome : Routes.home,
          (route) => false,
        );
    }
  }

  Future<void> _setLanguage(String languageCode) async {
    try {
      await OneSignal.User.setLanguage(languageCode);
    } catch (_) {}
  }

  Future<void> _ensureLogin(String externalUserId) async {
    try {
      if (_loggedExternalUserId == externalUserId) return;

      await OneSignal.login(externalUserId);

      _loggedExternalUserId = externalUserId;

      if (kDebugMode) {
        debugPrint('OneSignal logged in: $externalUserId');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('OneSignal login failed: $e');
      }
    }
  }

  Future<void> logout() async {
    try {
      await OneSignal.logout();
      _loggedExternalUserId = null;
    } catch (_) {}
  }

  Future<void> setTags(Map<String, String> tags) async {
    try {
      await OneSignal.User.addTags(tags);
    } catch (_) {}
  }

  Future<void> removeTags(List<String> tagKeys) async {
    try {
      await OneSignal.User.removeTags(tagKeys);
    } catch (_) {}
  }

  Future<bool> hasPermission() async {
    try {
      return OneSignal.Notifications.permission;
    } catch (_) {
      return false;
    }
  }

  Future<bool> requestPermission() async {
    try {
      return OneSignal.Notifications.requestPermission(true);
    } catch (_) {
      return false;
    }
  }

  bool get isSubscribed => OneSignal.User.pushSubscription.optedIn ?? false;

  Future<void> setSubscribed(bool enabled) async {
    try {
      if (enabled) {
        await OneSignal.User.pushSubscription.optIn();
      } else {
        await OneSignal.User.pushSubscription.optOut();
      }
    } catch (_) {}
  }

  Future<void> initializeWithContext(
    BuildContext context, {
    String? externalUserId,
  }) async {
    final locale = Localizations.localeOf(context).languageCode;

    await initialize(
      languageCode: locale,
      externalUserId: externalUserId,
    );
  }
}
