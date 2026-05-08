import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/models/reward_model.dart';
import 'package:uni_ride_application/core/services/reward_service.dart';

enum RewardState { idle, loading, success, error }

class RewardProvider extends ChangeNotifier {
  final RewardService _rewardService = RewardService();

  RewardState _state = RewardState.idle;
  RewardState get state => _state;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  RewardModel? _rewardData;
  RewardModel? get rewardData => _rewardData;

  Future<void> fetchMyRewards() async {
    _state = RewardState.loading;
    notifyListeners();
    try {
      _rewardData = await _rewardService.getMyRewards();
      _state = RewardState.success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = RewardState.error;
    }
    notifyListeners();
  }

  Future<bool> redeemReward(String rewardType) async {
    _state = RewardState.loading;
    notifyListeners();
    try {
      final success = await _rewardService.redeemReward(rewardType);
      if (success) {
        await fetchMyRewards(); // Refresh points
        _state = RewardState.success;
      } else {
        _errorMessage = 'Redeem failed';
        _state = RewardState.error;
      }
      notifyListeners();
      return success;
    } catch (e) {
      _errorMessage = e.toString();
      _state = RewardState.error;
      notifyListeners();
      return false;
    }
  }
}
