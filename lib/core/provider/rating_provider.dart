import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/models/driver_review_model.dart';
import 'package:uni_ride_application/core/services/rating_service.dart';

enum RatingState { idle, loading, success, error }

class RatingProvider extends ChangeNotifier {
  final RatingService _ratingService = RatingService();

  RatingState _state = RatingState.idle;
  RatingState get state => _state;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  RatingState _reviewsState = RatingState.idle;
  RatingState get reviewsState => _reviewsState;

  DriverReviewsResponse? _reviews;
  DriverReviewsResponse? get reviews => _reviews;

  int _unreadReviewsCount = 0;
  int get unreadReviewsCount => _unreadReviewsCount;

  Future<void> fetchUnreadReviewsCount() async {
    _unreadReviewsCount = await _ratingService.fetchUnreadReviewsCount();
    notifyListeners();
  }

  Future<void> markReviewsRead() async {
    try {
      await _ratingService.markReviewsRead();
      _unreadReviewsCount = 0;
      notifyListeners();
    } catch (_) {}
  }

  Future<void> fetchMyReviews() async {
    _reviewsState = RatingState.loading;
    notifyListeners();
    try {
      _reviews = await _ratingService.fetchMyReviews();
      _reviewsState = RatingState.success;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _reviewsState = RatingState.error;
    }
    notifyListeners();
  }

  Future<bool> submitRating({
    required int bookingId,
    required int score,
    String comment = '',
    List<String> tags = const [],
  }) async {
    _state = RatingState.loading;
    notifyListeners();
    try {
      final success = await _ratingService.submitRating(
        bookingId: bookingId,
        score: score,
        comment: comment,
        tags: tags,
      );
      if (success) {
        _state = RatingState.success;
      } else {
        _errorMessage = 'Failed to submit rating';
        _state = RatingState.error;
      }
      notifyListeners();
      return success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = RatingState.error;
      notifyListeners();
      return false;
    }
  }
}
