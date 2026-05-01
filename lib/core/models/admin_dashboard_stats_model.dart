import 'package:uni_ride_application/core/constants/api_keys.dart';
import 'package:uni_ride_application/core/models/admin_trip_model.dart';

class AdminDashboardStatsModel {
  final int    totalUsersCount;
  final int    activeDriversCount;
  final int    totalTripsCount;
  final int    pendingApprovalsCount;
  final double todayTotalRevenue;
  final double todayCommission;
  final int    revenueChangePercentage;
  final int    activeTripsNowCount;
  final List<AdminTripModel> recentTrips;

  const AdminDashboardStatsModel({
    required this.totalUsersCount,
    required this.activeDriversCount,
    required this.totalTripsCount,
    required this.pendingApprovalsCount,
    required this.todayTotalRevenue,
    required this.todayCommission,
    required this.revenueChangePercentage,
    required this.activeTripsNowCount,
    required this.recentTrips,
  });

  factory AdminDashboardStatsModel.fromJson(Map<String, dynamic> json) {
    final trips = (json[ApiKeys.recentTrips] as List? ?? [])
        .map((e) => AdminTripModel.fromJson(e))
        .toList();
    return AdminDashboardStatsModel(
      totalUsersCount:          (json[ApiKeys.totalUsersCount]         ?? 0).toInt(),
      activeDriversCount:       (json[ApiKeys.activeDriversCount]      ?? 0).toInt(),
      totalTripsCount:          (json[ApiKeys.totalTripsCount]         ?? 0).toInt(),
      pendingApprovalsCount:    (json[ApiKeys.pendingApprovalsCount]   ?? 0).toInt(),
      todayTotalRevenue:        (json[ApiKeys.todayTotalRevenue]       ?? 0).toDouble(),
      todayCommission:          (json[ApiKeys.todayCommission]         ?? 0).toDouble(),
      revenueChangePercentage:  (json[ApiKeys.revenueChangePercentage] ?? 0).toInt(),
      activeTripsNowCount:      (json[ApiKeys.activeTripsNowCount]     ?? 0).toInt(),
      recentTrips:              trips,
    );
  }
}
