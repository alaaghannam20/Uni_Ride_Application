import 'package:uni_ride_application/core/network/app_endpoints.dart';
import 'package:uni_ride_application/core/services/dio_factory/dio_factory.dart';

class RatingService {
  String _cleanError(dynamic e) => e.toString().replaceAll('Exception: ', '');

  Future<bool> submitRating({
    required int bookingId,
    required int score,
    String comment = '',
  }) async {
    try {
      final response = await DioFactory.post(
        AppEndpoints.ratingSubmit,
        data: {
          'bookingId': bookingId,
          'score': score,
          'comment': comment,
        },
      );
      return response.data['success'] == true;
    } catch (e) {
      throw Exception(_cleanError(e));
    }
  }
}
