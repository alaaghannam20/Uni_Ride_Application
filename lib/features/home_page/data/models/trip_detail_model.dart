import 'package:uni_ride_application/core/constants/api_keys.dart';
import 'package:uni_ride_application/core/constants/app_fee.dart';

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
      stopOrder: (json[ApiKeys.stopOrder] ?? 0).toInt(),
    );
  }
}

class TripDetailModel {
  final int tripId;
  final String tripCode;
  final String pickupLocation;
  final String dropoffLocation;
  final String departureTime;
  final List<TripStopModel> stops;
  final int totalSeats;
  final int availableSeats;
  final int pricePerSeat;
  final String? description;
  final String driverName;
  final String? profilePicturePath;
  final double driverRating;
  final int totalDriverTrips;
  final String vehicleModel;
  final String? plateNumber;
  final String vehicleType;
  final String driverPhone;
  final int platformFee;

  const TripDetailModel({
    required this.tripId,
    required this.tripCode,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.departureTime,
    required this.stops,
    required this.totalSeats,
    required this.availableSeats,
    required this.pricePerSeat,
    this.description,
    required this.driverName,
    this.profilePicturePath,
    required this.driverRating,
    required this.totalDriverTrips,
    required this.vehicleModel,
    this.plateNumber,
    required this.vehicleType,
    required this.driverPhone,
    this.platformFee = 0,
  });

  factory TripDetailModel.fromJson(Map<String, dynamic> json) {
    final stopsList = json[ApiKeys.stops] as List<dynamic>? ?? [];
    return TripDetailModel(
      tripId: (json[ApiKeys.tripId] ?? 0).toInt(),
      tripCode: json[ApiKeys.tripCode] ?? '',
      pickupLocation: json[ApiKeys.pickupLocation] ?? '',
      dropoffLocation: json[ApiKeys.dropoffLocation] ?? '',
      departureTime: json[ApiKeys.departureTime] ?? '',
      stops: stopsList.map((s) => TripStopModel.fromJson(s)).toList(),
      totalSeats: (json[ApiKeys.totalSeats] ?? 0).toInt(),
      availableSeats: (json[ApiKeys.availableSeats] ?? 0).toInt(),
      pricePerSeat: (json[ApiKeys.pricePerSeat] ?? 0).toInt(),
      description: json[ApiKeys.description],
      driverName: json[ApiKeys.driverName] ?? '',
      profilePicturePath: json[ApiKeys.profilePicturePath],
      driverRating: (json[ApiKeys.driverRating] ?? 0).toDouble(),
      totalDriverTrips: (json[ApiKeys.totalDriverTrips] ?? 0).toInt(),
      vehicleModel: json[ApiKeys.vehicleModel] ?? '',
      plateNumber: json[ApiKeys.plateNumber],
      vehicleType: json[ApiKeys.vehicleType] ?? '',
      driverPhone: json[ApiKeys.driverPhone] ?? '',
      platformFee: (json[ApiKeys.platformFee] ?? kAppFee).toInt(),
    );
  }
}
