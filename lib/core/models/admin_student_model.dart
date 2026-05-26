import 'package:uni_ride_application/core/constants/api_keys.dart';

class AdminStudentModel {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String email;
  final int    totalTrips;
  final String joined;
  final String status;

  const AdminStudentModel({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.totalTrips,
    required this.joined,
    required this.status,
  });

  factory AdminStudentModel.fromJson(Map<String, dynamic> json) {
    return AdminStudentModel(
      id:          json[ApiKeys.id]          ?? '',
      fullName:    json[ApiKeys.fullName]     ?? '',
      phoneNumber: json[ApiKeys.phoneNumber]  ?? '',
      email:       json[ApiKeys.email]        ?? '',
      totalTrips:  (json[ApiKeys.totalTrips]  ?? 0).toInt(),
      joined:      json[ApiKeys.joined]       ?? '',
      status:      json[ApiKeys.status]       ?? '',
    );
  }

  bool get isActive => status.toLowerCase() == 'active';
}
