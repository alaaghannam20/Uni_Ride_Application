import 'package:uni_ride_application/core/constants/api_keys.dart';

class BookingModel {
  final int bookingId;
  final String bookingCode;
  final String pickupLocation;
  final String dropoffLocation;
  final String departureTime;
  final String driverName;
  final String vehicleModel;
  final String? profilePicturePath;
  final String driverPhone;
  final int seatCount;
  final int estimatedDurationMinutes;
  final double totalAmount;
  final String paymentStatus;
  final String status;

  final bool isRated;

  const BookingModel({
    required this.bookingId,
    required this.bookingCode,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.departureTime,
    required this.driverName,
    required this.vehicleModel,
    this.profilePicturePath,
    required this.driverPhone,
    required this.seatCount,
    required this.estimatedDurationMinutes,
    required this.totalAmount,
    required this.paymentStatus,
    required this.status,
    this.isRated = false,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookingId:                  (json[ApiKeys.bookingId] ?? 0).toInt(),
      bookingCode:                json[ApiKeys.bookingCode] ?? '',
      pickupLocation:             json[ApiKeys.pickupLocation] ?? '',
      dropoffLocation:            json[ApiKeys.dropoffLocation] ?? '',
      departureTime:              json[ApiKeys.departureTime] ?? '',
      driverName:                 json[ApiKeys.driverName] ?? '',
      vehicleModel:               json[ApiKeys.vehicleModel] ?? '',
      profilePicturePath:         json[ApiKeys.profilePicturePath],
      driverPhone:                json[ApiKeys.driverPhone] ?? '',
      seatCount:                  (json[ApiKeys.seatCount] ?? 0).toInt(),
      estimatedDurationMinutes:   (json[ApiKeys.estimatedDurationMinutes] ?? 0).toInt(),
      totalAmount:                (json[ApiKeys.totalAmount] ?? 0).toDouble(),
      paymentStatus:              json[ApiKeys.paymentStatus] ?? '',
      status:                     json[ApiKeys.status] ?? '',
      isRated:                    json['isRated'] ?? false,
    );
  }
}
