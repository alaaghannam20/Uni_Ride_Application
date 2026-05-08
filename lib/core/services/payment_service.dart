import 'package:uni_ride_application/core/models/booking_model.dart';
import 'package:uni_ride_application/core/models/checkout_model.dart';
import 'package:uni_ride_application/core/models/wallet_model.dart';
import 'package:uni_ride_application/core/network/app_endpoints.dart';
import 'package:uni_ride_application/core/services/dio_factory/dio_factory.dart';

class PaymentService {
  String _cleanError(dynamic e) => e.toString().replaceAll('Exception: ', '');

  Future<WalletModel> getWalletBalance() async {
    try {
      final response = await DioFactory.get(AppEndpoints.walletBalance);
      final data = (response.data is Map && response.data['data'] != null)
          ? response.data['data']
          : response.data;
      return WalletModel.fromJson(data);
    } catch (e) {
      throw Exception(_cleanError(e));
    }
  }

  Future<CheckoutSessionModel> bookTrip({
    required int tripId,
    required int seatCount,
    required String successUrl,
    required String cancelUrl,
  }) async {
    try {
      final response = await DioFactory.post(
        AppEndpoints.checkoutBookTrip,
        data: {
          'tripId': tripId,
          'seatCount': seatCount,
          'successUrl': successUrl,
          'cancelUrl': cancelUrl,
        },
      );
      final data = (response.data is Map && response.data['data'] != null)
          ? response.data['data']
          : response.data;
      return CheckoutSessionModel.fromJson(data);
    } catch (e) {
      throw Exception(_cleanError(e));
    }
  }

  Future<BookingModel> confirmBooking(String sessionId) async {
    try {
      final response = await DioFactory.get(AppEndpoints.checkoutConfirmBooking(sessionId));
      final data = (response.data is Map && response.data['data'] != null)
          ? response.data['data']
          : response.data;
      return BookingModel.fromJson(data);
    } catch (e) {
      throw Exception(_cleanError(e));
    }
  }

  Future<CheckoutSessionModel> topUp({
    required double amount,
    required String successUrl,
    required String cancelUrl,
  }) async {
    try {
      final response = await DioFactory.post(
        AppEndpoints.checkoutTopUp,
        data: {
          'amount': amount,
          'successUrl': successUrl,
          'cancelUrl': cancelUrl,
        },
      );
      final data = (response.data is Map && response.data['data'] != null)
          ? response.data['data']
          : response.data;
      return CheckoutSessionModel.fromJson(data);
    } catch (e) {
      throw Exception(_cleanError(e));
    }
  }

  Future<bool> confirmTopUp(String sessionId) async {
    try {
      final response = await DioFactory.get(AppEndpoints.checkoutConfirmTopUp(sessionId));
      return response.data['success'] == true;
    } catch (e) {
      throw Exception(_cleanError(e));
    }
  }
}
