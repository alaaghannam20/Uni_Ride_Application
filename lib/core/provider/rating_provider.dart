import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/services/rating_service.dart';

enum RatingState { idle, loading, success, error }

class RatingProvider extends ChangeNotifier {
  final RatingService _ratingService = RatingService();

  RatingState _state = RatingState.idle;
  RatingState get state => _state;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> submitRating({
    required int bookingId,
    required int score,
    String comment = '',
  }) async {
    _state = RatingState.loading;
    notifyListeners();
    try {
      final success = await _ratingService.submitRating(
        bookingId: bookingId,
        score: score,
        comment: comment,
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
