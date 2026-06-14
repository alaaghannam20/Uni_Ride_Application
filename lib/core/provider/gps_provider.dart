import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/services/gps_hub_service.dart';

class GpsProvider extends ChangeNotifier {
  final GpsHubService _service = GpsHubService();
  int? _activeTripId;

  int? get activeTripId => _activeTripId;
  bool get isTracking => _activeTripId != null;

  Future<bool> startTracking(int tripId) async {
    if (_activeTripId == tripId && _service.isSending) return true;

    final ok = await _service.startSending(tripId: tripId);
    if (ok) {
      _activeTripId = tripId;
      notifyListeners();
    }
    return ok;
  }

  Future<void> stopTracking() async {
    await _service.stopSending();
    _activeTripId = null;
    notifyListeners();
  }
}
