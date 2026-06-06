import 'package:uni_ride_application/core/models/reward_model.dart';
import 'package:uni_ride_application/core/network/app_endpoints.dart';
import 'package:uni_ride_application/core/services/dio_factory/dio_factory.dart';

class RewardService {
  String _cleanError(dynamic e) => e.toString().replaceAll('Exception: ', '');

  Future<RewardModel> getMyRewards() async {
    try {
      final response = await DioFactory.get(AppEndpoints.myRewards);
      final data = (response.data is Map && response.data['data'] != null)
          ? response.data['data']
          : response.data;
      return RewardModel.fromJson(data);
    } catch (e) {
      throw Exception(_cleanError(e));
    }
  }

  Future<bool> redeemReward(String rewardType) async {
    try {
      final response = await DioFactory.post(
        AppEndpoints.redeemReward,
        data: {'rewardType': rewardType},
      );
      final data = (response.data is Map && response.data['data'] != null)
          ? response.data['data']
          : response.data;
      return data['success'] == true;
    } catch (e) {
      throw Exception(_cleanError(e));
    }
  }
}
