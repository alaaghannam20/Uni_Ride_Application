import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:uni_ride_application/core/network/app_endpoints.dart';
import 'package:uni_ride_application/core/services/dio_factory/dio_factory.dart';
import 'package:uni_ride_application/core/storage/app_prefs.dart';

class DriverGpsLocation {
  final double latitude;
  final double longitude;
  final String driverName;
  final String driverId;
  final String tripId;

  DriverGpsLocation({
    required this.latitude,
    required this.longitude,
    required this.driverName,
    required this.driverId,
    required this.tripId,
  });

  factory DriverGpsLocation.fromArgs(List<dynamic>? args) {
    if (args == null || args.isEmpty) throw Exception('No GPS data');
    final data = args[0] as Map<String, dynamic>;
    return DriverGpsLocation(
      latitude: (data['latitude'] as num).toDouble(),
      longitude: (data['longitude'] as num).toDouble(),
      driverName: data['driverName']?.toString() ?? '',
      driverId: data['driverId']?.toString() ?? '',
      tripId: data['tripId']?.toString() ?? '',
    );
  }
}

class GpsHubService {
  HubConnection? _connection;
  Timer? _sendTimer;

  // ── PASSENGER: connect to hub and listen for driver location ──────────────
  Future<void> startTracking({
    required int tripId,
    required void Function(DriverGpsLocation) onLocation,
    void Function(String)? onError,
  }) async {
    try {
      final token = AppPrefs.getToken() ?? '';

      _connection = HubConnectionBuilder()
          .withUrl(
            AppEndpoints.gpsHubUrl,
            options: HttpConnectionOptions(
              accessTokenFactory: () async => token,
            ),
          )
          .withAutomaticReconnect()
          .build();

      _connection!.on('ReceiveLocation', (args) {
        try {
          onLocation(DriverGpsLocation.fromArgs(args));
        } catch (_) {}
      });

      await _connection!.start();
      await _connection!.invoke('JoinTripGroup', args: [tripId.toString()]);
    } catch (e) {
      onError?.call(e.toString());
    }
  }

  // ── DRIVER: request permission and start sending GPS every 5 seconds ──────
  Future<bool> startSending({required int tripId}) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return false;
    }

    await _sendLocation(tripId);

    _sendTimer = Timer.periodic(const Duration(seconds: 5), (_) async {
      await _sendLocation(tripId);
    });
    return true;
  }

  Future<void> _sendLocation(int tripId) async {
    try {
      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );
      await DioFactory.post(AppEndpoints.gpsUpdate, data: {
        'tripId': tripId,
        'latitude': pos.latitude,
        'longitude': pos.longitude,
      });
    } catch (_) {}
  }

  bool get isSending => _sendTimer?.isActive ?? false;

  Future<void> stopSending() async {
    _sendTimer?.cancel();
    _sendTimer = null;
  }

  Future<void> dispose() async {
    _sendTimer?.cancel();
    _sendTimer = null;
    try {
      await _connection?.stop();
    } catch (_) {}
    _connection = null;
  }
}
