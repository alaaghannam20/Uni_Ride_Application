import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/models/booking_model.dart';
import 'package:uni_ride_application/core/models/checkout_model.dart';
import 'package:uni_ride_application/core/models/wallet_model.dart';
import 'package:uni_ride_application/core/services/payment_service.dart';

enum PaymentState { idle, loading, success, error }

class PaymentProvider extends ChangeNotifier {
  final PaymentService _paymentService = PaymentService();

  PaymentState _walletState = PaymentState.idle;
  PaymentState get walletState => _walletState;

  PaymentState _checkoutState = PaymentState.idle;
  PaymentState get checkoutState => _checkoutState;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  WalletModel? _wallet;
  WalletModel? get wallet => _wallet;

  CheckoutSessionModel? _currentSession;
  CheckoutSessionModel? get currentSession => _currentSession;

  BookingModel? _confirmedBooking;
  BookingModel? get confirmedBooking => _confirmedBooking;

  Future<void> fetchWalletBalance() async {
    _walletState = PaymentState.loading;
    notifyListeners();
    try {
      _wallet = await _paymentService.getWalletBalance();
      _walletState = PaymentState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _walletState = PaymentState.error;
    }
    notifyListeners();
  }

  Future<CheckoutSessionModel?> startBookTrip({
    required int tripId,
    required int seatCount,
    String successUrl = 'https://google.com',
    String cancelUrl = 'https://google.com',
  }) async {
    _checkoutState = PaymentState.loading;
    notifyListeners();
    try {
      _currentSession = await _paymentService.bookTrip(
        tripId: tripId,
        seatCount: seatCount,
        successUrl: successUrl,
        cancelUrl: cancelUrl,
      );
      _checkoutState = PaymentState.success;
      notifyListeners();
      return _currentSession;
    } catch (e) {
      _errorMessage = e.toString();
      _checkoutState = PaymentState.error;
      notifyListeners();
      return null;
    }
  }

  Future<bool> confirmBooking(String sessionId) async {
    _checkoutState = PaymentState.loading;
    notifyListeners();
    try {
      _confirmedBooking = await _paymentService.confirmBooking(sessionId);
      _checkoutState = PaymentState.success;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _checkoutState = PaymentState.error;
      notifyListeners();
      return false;
    }
  }

  Future<CheckoutSessionModel?> startTopUp({
    required double amount,
    String successUrl = 'https://google.com',
    String cancelUrl = 'https://google.com',
  }) async {
    _checkoutState = PaymentState.loading;
    notifyListeners();
    try {
      _currentSession = await _paymentService.topUp(
        amount: amount,
        successUrl: successUrl,
        cancelUrl: cancelUrl,
      );
      _checkoutState = PaymentState.success;
      notifyListeners();
      return _currentSession;
    } catch (e) {
      _errorMessage = e.toString();
      _checkoutState = PaymentState.error;
      notifyListeners();
      return null;
    }
  }

  Future<bool> confirmTopUp(String sessionId) async {
    _checkoutState = PaymentState.loading;
    notifyListeners();
    try {
      final success = await _paymentService.confirmTopUp(sessionId);
      if (success) {
        await fetchWalletBalance();
      }
      _checkoutState = PaymentState.success;
      notifyListeners();
      return success;
    } catch (e) {
      _errorMessage = e.toString();
      _checkoutState = PaymentState.error;
      notifyListeners();
      return false;
    }
  }
}
