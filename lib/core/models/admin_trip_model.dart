import 'package:uni_ride_application/core/constants/api_keys.dart';

class AdminTripModel {
  final int    tripId;
  final String driverName;
  final String route;
  final double price;
  final String status;
  final String timeAgo;
  final String driverType;

  const AdminTripModel({
    required this.tripId,
    required this.driverName,
    required this.route,
    required this.price,
    required this.status,
    required this.timeAgo,
    required this.driverType,
  });

  factory AdminTripModel.fromJson(Map<String, dynamic> json) {
    return AdminTripModel(
      tripId:     (json[ApiKeys.tripId]     ?? 0).toInt(),
      driverName: json[ApiKeys.driverName]  ?? '',
      route:      json[ApiKeys.route]       ?? '',
      price:      (json[ApiKeys.price]      ?? 0).toDouble(),
      status:     json[ApiKeys.status]      ?? '',
      timeAgo:    json[ApiKeys.timeAgo]     ?? '',
      driverType: json[ApiKeys.driverType]  ?? '',
    );
  }
}
