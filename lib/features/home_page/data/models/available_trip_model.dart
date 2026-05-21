import 'package:uni_ride_application/core/constants/api_keys.dart';

class AvailableTripModel {
  final int tripId;
  final String tripCode;
  final String driverName;
  final String pickupLocation;
  final String dropoffLocation;
  final String departureTime;
  final int pricePerSeat;
  final int availableSeats;
  final int estimatedDurationMinutes;
  final String driverType;
  final String vehicleModel;
  final String? profilePicturePath;
  final String? description;
  final String status;
  final double driverRating;

  const AvailableTripModel({
    required this.tripId,
    required this.tripCode,
    required this.driverName,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.departureTime,
    required this.pricePerSeat,
    required this.availableSeats,
    required this.estimatedDurationMinutes,
    required this.driverType,
    required this.vehicleModel,
    this.profilePicturePath,
    this.description,
    required this.status,
    this.driverRating = 0.0,
  });

  factory AvailableTripModel.fromJson(Map<String, dynamic> json) {
    return AvailableTripModel(
      tripId: (json[ApiKeys.tripId] ?? 0).toInt(),
      tripCode: json[ApiKeys.tripCode] ?? '',
      driverName: json[ApiKeys.driverName] ?? '',
      pickupLocation: json[ApiKeys.pickupLocation] ?? '',
      dropoffLocation: json[ApiKeys.dropoffLocation] ?? '',
      departureTime: json[ApiKeys.departureTime] ?? '',
      pricePerSeat: (json[ApiKeys.pricePerSeat] ?? 0).toInt(),
      availableSeats: (json[ApiKeys.availableSeats] ?? 0).toInt(),
      estimatedDurationMinutes: (() {
        final fromApi = (json[ApiKeys.estimatedDurationMinutes] ?? 0).toInt();
        if (fromApi > 0) return fromApi;
        final desc = (json[ApiKeys.description] ?? '') as String;
        final match = RegExp(r'estimatedDurationMinutes\s*:\s*(\d+)').firstMatch(desc);
        return match != null ? int.tryParse(match.group(1)!) ?? 0 : 0;
      })(),
      driverType: json[ApiKeys.driverType] ?? '',
      vehicleModel: json[ApiKeys.vehicleModel] ?? '',
      profilePicturePath: json[ApiKeys.profilePicturePath],
      description: json[ApiKeys.description],
      status: json[ApiKeys.status] ?? '',
      driverRating: double.tryParse((json[ApiKeys.driverRating] ?? json['rating'] ?? 0).toString()) ?? 0.0,
    );
  }
}
