import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/services/trip_service.dart';
import 'package:uni_ride_application/features/home_page/data/models/available_trip_model.dart';
import 'package:uni_ride_application/features/home_page/data/models/my_trip_model.dart';
import 'package:uni_ride_application/features/home_page/data/models/trip_detail_model.dart';

enum TripState { idle, loading, success, error }

class TripProvider extends ChangeNotifier {
  final TripService _tripService = TripService();

  TripState _availableTripsState = TripState.idle;
  TripState _tripDetailsState = TripState.idle;
  TripState _myTripsState = TripState.idle;

  List<AvailableTripModel> _availableTrips = [];
  TripDetailModel? _tripDetails;
  List<MyTripModel> _myTrips = [];

  String _errorMessage = '';

  TripState get availableTripsState => _availableTripsState;
  TripState get tripDetailsState => _tripDetailsState;
  TripState get myTripsState => _myTripsState;
  List<AvailableTripModel> get availableTrips => _availableTrips;
  TripDetailModel? get tripDetails => _tripDetails;
  List<MyTripModel> get myTrips => _myTrips;
  String get errorMessage => _errorMessage;

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
