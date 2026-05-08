import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/models/admin_dashboard_stats_model.dart';
import 'package:uni_ride_application/core/models/admin_driver_model.dart';
import 'package:uni_ride_application/core/models/admin_student_model.dart';
import 'package:uni_ride_application/core/models/admin_trip_model.dart';
import 'package:uni_ride_application/core/models/pending_approval_model.dart';
import 'package:uni_ride_application/core/services/admin_service.dart';

enum AdminState { idle, loading, success, error }

class AdminProvider extends ChangeNotifier {
  final AdminService _adminService = AdminService();

  AdminState _state           = AdminState.idle;
  AdminState _dashboardState  = AdminState.idle;
  AdminState _studentsState   = AdminState.idle;
  AdminState _tripsState      = AdminState.idle;
  AdminState _detailsState    = AdminState.idle;
  AdminState _driversState    = AdminState.idle;

  AdminState get state          => _state;
  AdminState get dashboardState => _dashboardState;
  AdminState get studentsState  => _studentsState;
  AdminState get tripsState     => _tripsState;
  AdminState get detailsState   => _detailsState;
  AdminState get driversState   => _driversState;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<PendingApprovalModel>    _pendingApprovals  = [];
  AdminDashboardStatsModel?     _dashboardStats;
  List<AdminStudentModel>       _students          = [];
  List<AdminTripModel>          _adminTrips        = [];
  PendingApprovalModel?         _selectedApproval;
  List<AdminDriverModel>        _drivers           = [];

  List<PendingApprovalModel>    get pendingApprovals  => _pendingApprovals;
  AdminDashboardStatsModel?     get dashboardStats    => _dashboardStats;
  List<AdminStudentModel>       get students          => _students;
  List<AdminTripModel>          get adminTrips        => _adminTrips;
  PendingApprovalModel?         get selectedApproval  => _selectedApproval;
  List<AdminDriverModel>        get drivers           => _drivers;

  void _setState(AdminState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> fetchDashboardStats() async {
    _dashboardState = AdminState.loading;
    notifyListeners();
    try {
      _dashboardStats = await _adminService.getDashboardStats();
      _dashboardState = AdminState.success;
    } catch (e) {
      _errorMessage   = e.toString().replaceAll('Exception: ', '');
      _dashboardState = AdminState.error;
    }
    notifyListeners();
  }

  Future<void> fetchStudents() async {
    _studentsState = AdminState.loading;
    notifyListeners();
    try {
      _students      = await _adminService.getStudents();
      _studentsState = AdminState.success;
    } catch (e) {
      _errorMessage  = e.toString().replaceAll('Exception: ', '');
      _studentsState = AdminState.error;
    }
    notifyListeners();
  }

  Future<bool> toggleDriverStatus(String id) async {
    final result = await _adminService.toggleDriverStatus(id);
    if (!result.success) _errorMessage = result.message;
    return result.success;
  }

  Future<void> fetchAdminTrips() async {
    _tripsState = AdminState.loading;
    notifyListeners();
    try {
      _adminTrips = await _adminService.getAdminTrips();
      _tripsState = AdminState.success;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _tripsState   = AdminState.error;
    }
    notifyListeners();
  }

  Future<void> fetchDriversList() async {
    _driversState = AdminState.loading;
    notifyListeners();
    try {
      _drivers      = await _adminService.getDriversList();
      _driversState = AdminState.success;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _driversState = AdminState.error;
    }
    notifyListeners();
  }

  Future<void> fetchPendingApprovalDetails(String id, String type) async {
    _detailsState = AdminState.loading;
    notifyListeners();
    try {
      _selectedApproval = await _adminService.getPendingApprovalDetails(id, type);
      _detailsState = AdminState.success;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _detailsState = AdminState.error;
    }
    notifyListeners();
  }

  Future<void> fetchPendingApprovals() async {
    _setState(AdminState.loading);
    try {
      _pendingApprovals = await _adminService.getPendingApprovals();
      _setState(AdminState.success);
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _setState(AdminState.error);
    }
  }

  Future<bool> approveApplication(String id, String type) async {
    // Note: We don't want to show global loading for list items unless specified, 
    // but following AuthProvider's pattern for consistency.
    _setState(AdminState.loading);
    final result = await _adminService.approveApplication(id, type);
    if (result.success) {
      _pendingApprovals.removeWhere((item) => item.id == id);
      _setState(AdminState.success);
      return true;
    } else {
      _errorMessage = result.message;
      _setState(AdminState.error);
      return false;
    }
  }

  Future<bool> rejectApplication(String id, String type) async {
    _setState(AdminState.loading);
    final result = await _adminService.rejectApplication(id, type);
    if (result.success) {
      _pendingApprovals.removeWhere((item) => item.id == id);
      _setState(AdminState.success);
      return true;
    } else {
      _errorMessage = result.message;
      _setState(AdminState.error);
      return false;
    }
  }
}
