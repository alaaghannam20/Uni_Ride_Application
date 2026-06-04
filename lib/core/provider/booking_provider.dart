import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/models/booking_model.dart';
import 'package:uni_ride_application/core/services/booking_service.dart';

enum BookingState { idle, loading, success, error }

class BookingProvider extends ChangeNotifier {
  final BookingService _service = BookingService();

  BookingState _createState  = BookingState.idle;
  BookingState _cancelState  = BookingState.idle;
  BookingState _listState    = BookingState.idle;

  BookingModel?        _createdBooking;
  List<BookingModel>   _myBookings = [];
  String               _errorMessage  = '';
  double?              _refundAmount;
  String               _refundMethod  = '';

  BookingState       get createState    => _createState;
  BookingState       get cancelState    => _cancelState;
  BookingState       get listState      => _listState;
  BookingModel?      get createdBooking => _createdBooking;
  List<BookingModel> get myBookings     => _myBookings;
  String             get errorMessage   => _errorMessage;
  double?            get refundAmount   => _refundAmount;
  String             get refundMethod   => _refundMethod;

  Future<BookingModel?> createBooking({
    required int tripId,
    required int seatCount,
  }) async {
    _createState = BookingState.loading;
    notifyListeners();
    try {
      _createdBooking = await _service.createBooking(
        tripId:    tripId,
        seatCount: seatCount,
      );
      _createState = BookingState.success;
      notifyListeners();
      return _createdBooking;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _createState  = BookingState.error;
      notifyListeners();
      return null;
    }
  }

  Future<bool> cancelBooking(int bookingId) async {
    _cancelState = BookingState.loading;
    notifyListeners();
    try {
      final result = await _service.cancelBooking(bookingId);
      final rawAmount = result['refundAmount'] ?? result['RefundAmount'];
      _refundAmount = rawAmount != null ? (rawAmount as num).toDouble() : null;
      _refundMethod = (result['refundMethod'] ?? result['RefundMethod'] ?? '').toString();
      _cancelState = BookingState.success;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _cancelState  = BookingState.error;
      notifyListeners();
      return false;
    }
  }

  Future<void> fetchMyBookings({String? status}) async {
    _listState = BookingState.loading;
    notifyListeners();
    try {
      _myBookings = await _service.getMyBookings(status: status);
      _listState  = BookingState.success;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _listState    = BookingState.error;
    }
    notifyListeners();
  }

  void reset() {
    _createState = BookingState.idle;
    _errorMessage = '';
    notifyListeners();
  }
}
