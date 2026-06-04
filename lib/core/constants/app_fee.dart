import 'package:uni_ride_application/core/storage/app_prefs.dart';

/// Platform fee added on top of driver's price per seat (in ILS).
/// Configurable by admin from Settings page. Defaults to 3.
int get kAppFee => AppPrefs.getAppFee();
