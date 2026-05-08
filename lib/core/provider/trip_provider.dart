import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/services/trip_service.dart';
import 'package:uni_ride_application/features/home_page/data/models/available_trip_model.dart';
import 'package:uni_ride_application/features/home_page/data/models/my_trip_model.dart';
import 'package:uni_ride_application/features/home_page/data/models/trip_detail_model.dart';

enum TripState { idle, loading, success, error }

class TripProvider extends ChangeNotifier {
  final TripService _tripService = TripService();

  TripState _availableTripsState  = TripState.idle;
  TripState _tripDetailsState     = TripState.idle;
  TripState _myTripsState         = TripState.idle;
  TripState _createState          = TripState.idle;
  TripState _actionState          = TripState.idle;
  TripState _scheduledState       = TripState.idle;
  TripState _historyState         = TripState.idle;

  List<AvailableTripModel> _availableTrips  = [];
  TripDetailModel?         _tripDetails;
  List<MyTripModel>        _myTrips          = [];
  List<MyTripModel>        _driverScheduled  = [];
  List<MyTripModel>        _driverHistory    = [];

  String _errorMessage = '';

  TripState get availableTripsState => _availableTripsState;
  TripState get tripDetailsState    => _tripDetailsState;
  TripState get myTripsState        => _myTripsState;
  TripState get createState         => _createState;
  TripState get actionState         => _actionState;
  TripState get scheduledState      => _scheduledState;
  TripState get historyState        => _historyState;
  List<AvailableTripModel> get availableTrips     => _availableTrips;
  TripDetailModel?         get tripDetails         => _tripDetails;
  List<MyTripModel>        get driverScheduled     => _driverScheduled;
  List<MyTripModel>        get driverHistory       => _driverHistory;
  List<MyTripModel> get myTrips     => _myTrips;
  String get errorMessage           => _errorMessage;

  Future<void> fetchAvailableTrips({String? type}) async {
    _availableTripsState = TripState.loading;
    notifyListeners();
    try {
      _availableTrips = await _tripService.getAvailableTrips(type: type);
      _availableTripsState = TripState.success;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _availableTripsState = TripState.error;
    }
    notifyListeners();
  }

  Future<void> fetchTripDetails(int tripId) async {
    _tripDetailsState = TripState.loading;
    notifyListeners();
    try {
      _tripDetails = await _tripService.getTripDetails(tripId);
      _tripDetailsState = TripState.success;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _tripDetailsState = TripState.error;
    }
    notifyListeners();
  }

  Future<bool> createTrip({
    required String pickupLocation,
    required String dropoffLocation,
    required String departureTime,
    required double pricePerSeat,
    required int totalSeats,
    String description = '',
    List<Map<String, dynamic>> stops = const [],
  }) async {
    _createState = TripState.loading;
    notifyListeners();
    try {
      await _tripService.createTrip(
        pickupLocation: pickupLocation,
        dropoffLocation: dropoffLocation,
        departureTime: departureTime,
        pricePerSeat: pricePerSeat,
        totalSeats: totalSeats,
        description: description,
        stops: stops,
      );
      _createState = TripState.success;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _createState  = TripState.error;
      notifyListeners();
      return false;
    }
  }

  Future<void> fetchDriverScheduled() async {
    _scheduledState = TripState.loading;
    notifyListeners();
    try {
      _driverScheduled = await _tripService.getDriverScheduled();
      _scheduledState  = TripState.success;
    } catch (e) {
      _errorMessage   = e.toString().replaceAll('Exception: ', '');
      _scheduledState = TripState.error;
    }
    notifyListeners();
  }

  Future<void> fetchDriverHistory() async {
    _historyState = TripState.loading;
    notifyListeners();
    try {
      _driverHistory = await _tripService.getDriverHistory();
      _historyState  = TripState.success;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _historyState = TripState.error;
    }
    notifyListeners();
  }

  Future<bool> updateTrip(int tripId, {
    required String pickupLocation,
    required String dropoffLocation,
    required String departureTime,
    required double pricePerSeat,
    required int totalSeats,
    String description = '',
    List<Map<String, dynamic>> stops = const [],
  }) async {
    _actionState = TripState.loading;
    notifyListeners();
    try {
      await _tripService.updateTrip(tripId,
        pickupLocation: pickupLocation,
        dropoffLocation: dropoffLocation,
        departureTime: departureTime,
        pricePerSeat: pricePerSeat,
        totalSeats: totalSeats,
        description: description,
        stops: stops,
      );
      _actionState = TripState.success;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _actionState  = TripState.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> completeTrip(int tripId) async {
    _actionState = TripState.loading;
    notifyListeners();
    try {
      await _tripService.completeTrip(tripId);
      _actionState = TripState.success;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _actionState  = TripState.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> cancelTrip(int tripId) async {
    _actionState = TripState.loading;
    notifyListeners();
    try {
      await _tripService.cancelTrip(tripId);
      _actionState = TripState.success;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _actionState  = TripState.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> publishTrip(int tripId) async {
    _actionState = TripState.loading;
    notifyListeners();
    try {
      await _tripService.publishTrip(tripId);
      _actionState = TripState.success;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _actionState  = TripState.error;
      notifyListeners();
      return false;
    }
  }

  Future<void> fetchMyTrips() async {
    _myTripsState = TripState.loading;
    notifyListeners();
    try {
      _myTrips = await _tripService.getMyTrips();
      _myTripsState = TripState.success;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _myTripsState = TripState.error;
    }
    notifyListeners();
  }
}
