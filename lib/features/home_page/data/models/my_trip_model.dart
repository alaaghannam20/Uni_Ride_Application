import 'package:uni_ride_application/core/constants/api_keys.dart';

class MyTripModel {
  final int tripId;
  final String tripCode;
  final String pickupLocation;
  final String dropoffLocation;
  final String departureTime;
  final int pricePerSeat;
  final String driverName;
  final String vehicleModel;
  final String status;
  final int estimatedDurationMinutes;

  const MyTripModel({
    required this.tripId,
    required this.tripCode,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.departureTime,
    required this.pricePerSeat,
    required this.driverName,
    required this.vehicleModel,
    required this.status,
    this.estimatedDurationMinutes = 0,
  });

  factory MyTripModel.fromJson(Map<String, dynamic> json) {
    final rawDur = json['estimatedDurationMinutes'] ?? json['EstimatedDurationMinutes'];
    final dur = rawDur == null ? 0 : (rawDur is int ? rawDur : int.tryParse(rawDur.toString()) ?? 0);
    return MyTripModel(
      tripId: (json[ApiKeys.tripId] ?? 0).toInt(),
      tripCode: json[ApiKeys.tripCode] ?? '',
      pickupLocation: json[ApiKeys.pickupLocation] ?? '',
      dropoffLocation: json[ApiKeys.dropoffLocation] ?? '',
      departureTime: json[ApiKeys.departureTime] ?? '',
      pricePerSeat: (json[ApiKeys.pricePerSeat] ?? 0).toInt(),
      driverName: json[ApiKeys.driverName] ?? '',
      vehicleModel: json[ApiKeys.vehicleModel] ?? '',
      status: json[ApiKeys.status] ?? '',
      estimatedDurationMinutes: dur,
    );
  }
}
