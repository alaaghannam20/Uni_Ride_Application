import 'package:uni_ride_application/core/constants/api_keys.dart';
import 'package:uni_ride_application/core/network/app_endpoints.dart';
import 'package:uni_ride_application/core/services/dio_factory/dio_factory.dart';
import 'package:uni_ride_application/features/home_page/data/models/available_trip_model.dart';
import 'package:uni_ride_application/features/home_page/data/models/location_model.dart';
import 'package:uni_ride_application/features/home_page/data/models/my_trip_model.dart';
import 'package:uni_ride_application/features/home_page/data/models/trip_detail_model.dart';

class TripService {
  String _cleanError(dynamic e) {
    return e.toString().replaceAll('Exception: ', '');
  }

  Future<List<LocationModel>> getLocations() async {
    try {
      final response = await DioFactory.get(AppEndpoints.tripLocations);
      List<dynamic> list = [];
      if (response.data is List) {
        list = response.data as List;
      } else if (response.data is Map && response.data['data'] is List) {
        list = response.data['data'] as List;
      }
      return list.map((e) => LocationModel.fromJson(e as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception(_cleanError(e));
    }
  }

  Future<List<AvailableTripModel>> getAvailableTrips({String? type}) async {
    try {
      final response = await DioFactory.get(
        AppEndpoints.availableTrips,
        queryParameters: type != null ? {ApiKeys.type: type} : null,
      );
      List<dynamic> list = [];
      if (response.data is List) {
        list = response.data as List;
      } else if (response.data is Map && response.data['data'] is List) {
        list = response.data['data'] as List;
      }
      return list.map((item) => AvailableTripModel.fromJson(item)).toList();
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

  Future<int> createTrip({
    required String pickupLocation,
    required String dropoffLocation,
    required String departureTime,
    required double pricePerSeat,
    required int totalSeats,
    String description = '',
    int estimatedDurationMinutes = 0,
    List<Map<String, dynamic>> stops = const [],
  }) async {
    try {
      final Map<String, dynamic> body = {
        'pickupLocation': pickupLocation,
        'dropoffLocation': dropoffLocation,
        'departureTime': departureTime,
        'pricePerSeat': pricePerSeat,
        'totalSeats': totalSeats,
        'estimatedDurationMinutes': estimatedDurationMinutes,
      };
      if (description.isNotEmpty) body['description'] = description;
      body['stops'] = stops;

      final response = await DioFactory.post(AppEndpoints.createTrip, data: body);
      final responseBody = (response.data is Map && response.data[ApiKeys.data] != null)
          ? response.data[ApiKeys.data]
          : response.data;
      final id = responseBody[ApiKeys.tripId] ?? responseBody['id'] ?? responseBody['TripId'] ?? responseBody['trip_id'] ?? 0;
      return (id is int) ? id : int.tryParse(id.toString()) ?? 0;
    } catch (e) {
      throw Exception(_cleanError(e));
    }
  }

  Future<void> updateTrip(int tripId, {
    required String pickupLocation,
    required String dropoffLocation,
    required String departureTime,
    required double pricePerSeat,
    required int totalSeats,
    String description = '',
    List<Map<String, dynamic>> stops = const [],
  }) async {
    try {
      await DioFactory.put(AppEndpoints.updateTrip(tripId), data: {
        'pickupLocation': pickupLocation,
        'dropoffLocation': dropoffLocation,
        'departureTime': departureTime,
        'pricePerSeat': pricePerSeat,
        'totalSeats': totalSeats,
        'description': description,
        'stops': stops,
      });
    } catch (e) {
      throw Exception(_cleanError(e));
    }
  }

  Future<void> completeTrip(int tripId) async {
    try {
      await DioFactory.post(AppEndpoints.completeTrip(tripId));
    } catch (e) {
      throw Exception(_cleanError(e));
    }
  }

  Future<void> publishTrip(int tripId) async {
    try {
      await DioFactory.post(AppEndpoints.publishTrip(tripId));
    } catch (e) {
      throw Exception(_cleanError(e));
    }
  }

  Future<void> startTrip(int tripId) async {
    try {
      await DioFactory.post(AppEndpoints.startTrip(tripId));
    } catch (e) {
      throw Exception(_cleanError(e));
    }
  }

  Future<void> cancelTrip(int tripId) async {
    try {
      await DioFactory.put(AppEndpoints.cancelTrip(tripId));
    } catch (e) {
      throw Exception(_cleanError(e));
    }
  }

  Future<List<MyTripModel>> getDriverScheduled() async {
    try {
      final response = await DioFactory.get(AppEndpoints.driverScheduled);
      final data = response.data;
      if (data is List) return data.map((e) => MyTripModel.fromJson(e)).toList();
      if (data is Map && data['data'] is List) return (data['data'] as List).map((e) => MyTripModel.fromJson(e)).toList();
      return [];
    } catch (e) {
      throw Exception(_cleanError(e));
    }
  }

  Future<List<MyTripModel>> getDriverHistory() async {
    try {
      final response = await DioFactory.get(AppEndpoints.driverHistory);
      final data = response.data;
      if (data is List) return data.map((e) => MyTripModel.fromJson(e)).toList();
      if (data is Map && data['data'] is List) return (data['data'] as List).map((e) => MyTripModel.fromJson(e)).toList();
      return [];
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
