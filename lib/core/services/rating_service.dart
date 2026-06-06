import 'package:uni_ride_application/core/models/driver_review_model.dart';
import 'package:uni_ride_application/core/network/app_endpoints.dart';
import 'package:uni_ride_application/core/services/dio_factory/dio_factory.dart';

class RatingService {
  String _cleanError(dynamic e) => e.toString().replaceAll('Exception: ', '');

  Future<bool> submitRating({
    required int bookingId,
    required int score,
    String comment = '',
    List<String> tags = const [],
  }) async {
    try {
      final response = await DioFactory.post(
        AppEndpoints.ratingSubmit,
        data: {
          'bookingId': bookingId,
          'score': score,
          'comment': comment,
          'tags': tags,
        },
      );
      return response.data['success'] == true;
    } catch (e) {
      throw Exception(_cleanError(e));
    }
  }

  Future<DriverReviewsResponse> fetchMyReviews() async {
    try {
      final response = await DioFactory.get(AppEndpoints.ratingMyReviews);
      final data = response.data['data'] ?? response.data;
      return DriverReviewsResponse.fromJson(data);
    } catch (e) {
      throw Exception(_cleanError(e));
    }
  }

  Future<int> fetchUnreadReviewsCount() async {
    try {
      final response = await DioFactory.get(AppEndpoints.ratingUnreadCount);
      final data = response.data['data'] ?? response.data;
      return (data['count'] ?? data['Count'] ?? 0) as int;
    } catch (_) {
      return 0;
    }
  }

  Future<void> markReviewsRead() async {
    await DioFactory.put(AppEndpoints.ratingMarkAllRead);
  }
}
