import 'package:uni_ride_application/core/constants/api_keys.dart';
import 'package:uni_ride_application/core/network/app_endpoints.dart';
import 'package:uni_ride_application/core/services/dio_factory/dio_factory.dart';
import 'package:uni_ride_application/features/home_page/data/models/available_trip_model.dart';
import 'package:uni_ride_application/features/home_page/data/models/my_trip_model.dart';
import 'package:uni_ride_application/features/home_page/data/models/trip_detail_model.dart';

class TripService {
  String _cleanError(dynamic e) {
    return e.toString().replaceAll('Exception: ', '');
  }

  Future<List<AvailableTripModel>> getAvailableTrips({String? type}) async {
    try {
      final response = await DioFactory.get(
        AppEndpoints.availableTrips,
        queryParameters: type != null ? {ApiKeys.type: type} : null,
      );
      if (response.data is List) {
        return (response.data as List)
            .map((item) => AvailableTripModel.fromJson(item))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception(_cleanError(e));
    }
  }

  Future<TripDetailModel> getTripDetails(int tripId) async {
    try {
      final response = await DioFactory.get(AppEndpoints.tripDetails(tripId));
      final json = (response.data is Map && response.data[ApiKeys.data] != null)
          ? response.data[ApiKeys.data]
          : response.data;
      return TripDetailModel.fromJson(json);
    } catch (e) {
      throw Exception(_cleanError(e));
    }
  }

  Future<List<MyTripModel>> getMyTrips() async {
    try {
      final response = await DioFactory.get(AppEndpoints.myTrips);
      if (response.data is List) {
        return (response.data as List)
            .map((item) => MyTripModel.fromJson(item))
            .toList();
      }
      if (response.data is Map && response.data[ApiKeys.data] is List) {
        return (response.data[ApiKeys.data] as List)
            .map((item) => MyTripModel.fromJson(item))
            .toList();
      }
      return [];
    } catch (e) {
      throw Exception(_cleanError(e));
    }
  }
}
