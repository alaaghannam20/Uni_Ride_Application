class AdminDriverModel {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String vehicleInfo;
  final double rating;
  final int    totalTrips;
  final String status;

  const AdminDriverModel({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.vehicleInfo,
    required this.rating,
    required this.totalTrips,
    required this.status,
  });

  factory AdminDriverModel.fromJson(Map<String, dynamic> json) {
    return AdminDriverModel(
      id:          json['id']?.toString()          ?? '',
      fullName:    json['fullName']?.toString()    ?? '',
      phoneNumber: json['phoneNumber']?.toString() ?? '',
      vehicleInfo: json['vehicleInfo']?.toString() ?? '',
      rating:      (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalTrips:  (json['totalTrips'] as num?)?.toInt() ?? 0,
      status:      json['status']?.toString()      ?? '',
    );
  }

  bool get isActive => status.toLowerCase() == 'active';
}
