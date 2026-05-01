import 'package:uni_ride_application/core/constants/api_keys.dart';

class DriverProfileModel {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String licenseNumber;
  final String? profilePicturePath;
  final String status;
  final double rating;
  final int totalTrips;
  final int earned;
  final String vehicleModel;
  final String vehicleType;
  final String plateNumber;
  final int seatCapacity;

  const DriverProfileModel({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.licenseNumber,
    this.profilePicturePath,
    required this.status,
    required this.rating,
    required this.totalTrips,
    required this.earned,
    required this.vehicleModel,
    required this.vehicleType,
    required this.plateNumber,
    required this.seatCapacity,
  });

  factory DriverProfileModel.fromJson(Map<String, dynamic> json) {
    return DriverProfileModel(
      fullName: json[ApiKeys.fullName] ?? '',
      email: json[ApiKeys.email] ?? '',
      phoneNumber: json[ApiKeys.phoneNumber] ?? '',
      licenseNumber: json[ApiKeys.licenseNumber] ?? '',
      profilePicturePath: json[ApiKeys.profilePicturePath],
      status: json[ApiKeys.status] ?? '',
      rating: (json[ApiKeys.rating] ?? 0).toDouble(),
      totalTrips: (json[ApiKeys.totalTrips] ?? 0).toInt(),
      earned: (json[ApiKeys.earned] ?? 0).toInt(),
      vehicleModel: json[ApiKeys.vehicleModel] ?? '',
      vehicleType: json[ApiKeys.vehicleType] ?? '',
      plateNumber: json[ApiKeys.plateNumber] ?? '',
      seatCapacity: (json[ApiKeys.seatCapacity] ?? 0).toInt(),
    );
  }
}
