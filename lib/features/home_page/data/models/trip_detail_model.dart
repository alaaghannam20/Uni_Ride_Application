import 'package:uni_ride_application/core/constants/api_keys.dart';

class TripStopModel {
  final String stopName;
  final String estimatedArrivalTime;
  final int stopOrder;

  const TripStopModel({
    required this.stopName,
    required this.estimatedArrivalTime,
    required this.stopOrder,
  });

  factory TripStopModel.fromJson(Map<String, dynamic> json) {
    return TripStopModel(
      stopName: json[ApiKeys.stopName] ?? '',
      estimatedArrivalTime: json[ApiKeys.estimatedArrivalTime] ?? '',
      stopOrder: json[ApiKeys.stopOrder] ?? 0,
    );
  }
}

class TripDetailModel {
  final int tripId;
  final String pickupLocation;
  final String dropoffLocation;
  final String departureTime;
  final List<TripStopModel> stops;
  final int totalSeats;
  final int availableSeats;
  final int pricePerSeat;
  final String driverName;
  final double driverRating;
  final int totalDriverTrips;
  final String vehicleModel;
  final String plateNumber;
  final String vehicleType;

  const TripDetailModel({
    required this.tripId,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.departureTime,
    required this.stops,
    required this.totalSeats,
    required this.availableSeats,
    required this.pricePerSeat,
    required this.driverName,
    required this.driverRating,
    required this.totalDriverTrips,
    required this.vehicleModel,
    required this.plateNumber,
    required this.vehicleType,
  });

  factory TripDetailModel.fromJson(Map<String, dynamic> json) {
    final stopsList = json[ApiKeys.stops] as List<dynamic>? ?? [];
    return TripDetailModel(
      tripId: json[ApiKeys.tripId] ?? 0,
      pickupLocation: json[ApiKeys.pickupLocation] ?? '',
      dropoffLocation: json[ApiKeys.dropoffLocation] ?? '',
      departureTime: json[ApiKeys.departureTime] ?? '',
      stops: stopsList.map((s) => TripStopModel.fromJson(s)).toList(),
      totalSeats: json[ApiKeys.totalSeats] ?? 0,
      availableSeats: json[ApiKeys.availableSeats] ?? 0,
      pricePerSeat: json[ApiKeys.pricePerSeat] ?? 0,
      driverName: json[ApiKeys.driverName] ?? '',
      driverRating: (json[ApiKeys.driverRating] ?? 0).toDouble(),
      totalDriverTrips: json[ApiKeys.totalDriverTrips] ?? 0,
      vehicleModel: json[ApiKeys.vehicleModel] ?? '',
      plateNumber: json[ApiKeys.plateNumber] ?? '',
      vehicleType: json[ApiKeys.vehicleType] ?? '',
    );
  }
}
