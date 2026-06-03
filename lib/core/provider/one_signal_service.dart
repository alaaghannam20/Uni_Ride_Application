import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalService {
  // Replace with your UniRide OneSignal App ID
  static const String appId = 'b3cbe68c-ec75-4b0c-b12a-067a6a327a00';

  static final OneSignalService _singleton =
      OneSignalService._internal();

  factory OneSignalService() => _singleton;

  OneSignalService._internal();

  bool _initialized = false;
  String? _loggedExternalUserId;

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

    // Initialize OneSignal
    OneSignal.initialize(appId);

    // Set language
    await _setLanguage(languageCode);

    // Request notification permission
    final permissionGranted =
        await OneSignal.Notifications.requestPermission(true);

    if (kDebugMode) {
      debugPrint(
        'OneSignal permission granted: $permissionGranted',
      );
    }

    // Login user if permission granted
    if (permissionGranted &&
        (externalUserId ?? '').trim().isNotEmpty) {
      await _ensureLogin(externalUserId!.trim());
    }

    // Notification click listener
    OneSignal.Notifications.addClickListener((event) {
      if (kDebugMode) {
        debugPrint(
          'Notification clicked: ${event.notification.title}',
        );
      }

      // Example:
      // final data = event.notification.additionalData;
      // Navigate user based on notification payload
    });

    // Foreground notification listener
    OneSignal.Notifications
        .addForegroundWillDisplayListener((event) {
      // Show notification while app is open
      event.notification.display();
    });

    _initialized = true;
  }

  Future<void> _setLanguage(String languageCode) async {
    try {
      await OneSignal.User.setLanguage(languageCode);
    } catch (_) {}
  }

  Future<void> _ensureLogin(String externalUserId) async {
    try {
      if (_loggedExternalUserId == externalUserId) return;

      final hasPermission =
          await OneSignal.Notifications.permission;

      if (!hasPermission) {
        if (kDebugMode) {
          debugPrint(
            'OneSignal: Cannot login without permission',
          );
        }
        return;
      }

      await OneSignal.login(externalUserId);

      _loggedExternalUserId = externalUserId;

      if (kDebugMode) {
        debugPrint(
          'OneSignal logged in: $externalUserId',
        );
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

  Future<void> setTags(
    Map<String, String> tags,
  ) async {
    try {
      await OneSignal.User.addTags(tags);
    } catch (_) {}
  }

  Future<void> removeTags(
    List<String> tagKeys,
  ) async {
    try {
      await OneSignal.User.removeTags(tagKeys);
    } catch (_) {}
  }

  Future<bool> hasPermission() async {
    try {
      return await OneSignal.Notifications.permission;
    } catch (_) {
      return false;
    }
  }

  Future<bool> requestPermission() async {
    try {
      return await OneSignal.Notifications
          .requestPermission(true);
    } catch (_) {
      return false;
    }
  }

  Future<void> initializeWithContext(
    BuildContext context, {
    String? externalUserId,
  }) async {
    final locale =
        Localizations.localeOf(context).languageCode;

    await initialize(
      languageCode: locale,
      externalUserId: externalUserId,
    );
  }
}
