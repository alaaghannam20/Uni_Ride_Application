import 'package:uni_ride_application/core/constants/api_keys.dart';
import 'package:uni_ride_application/core/models/booking_model.dart';
import 'package:uni_ride_application/core/network/app_endpoints.dart';
import 'package:uni_ride_application/core/services/dio_factory/dio_factory.dart';

class BookingService {
  String _cleanError(dynamic e) => e.toString().replaceAll('Exception: ', '');

  Future<BookingModel> createBooking({
    required int tripId,
    required int seatCount,
    String paymentMethod = 'Wallet',
  }) async {
    try {
      final response = await DioFactory.post(
        AppEndpoints.bookingCreate,
        data: {
          ApiKeys.tripId:       tripId,
          ApiKeys.seatCount:    seatCount,
          'paymentMethod':      paymentMethod,
          'discountId':         null,
        },
      );
      final json = (response.data is Map && response.data[ApiKeys.data] != null)
          ? response.data[ApiKeys.data]
          : response.data;
      return BookingModel.fromJson(json);
    } catch (e) {
      throw Exception(_cleanError(e));
    }
  }

  Future<void> cancelBooking(int bookingId) async {
    try {
      await DioFactory.post(AppEndpoints.bookingCancel(bookingId));
    } catch (e) {
      throw Exception(_cleanError(e));
    }
  }

  Future<List<BookingModel>> getMyBookings({String? status}) async {
    try {
      final response = await DioFactory.get(
        AppEndpoints.myBookings,
        queryParameters: status != null ? {ApiKeys.status: status} : null,
      );
      final data = response.data;
      List<dynamic> list = data is List ? data : [];
      return list.map((item) => BookingModel.fromJson(item)).toList();
    } catch (e) {
      throw Exception(_cleanError(e));
    }
  }
}
