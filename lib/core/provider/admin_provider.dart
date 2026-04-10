import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/models/pending_approval_model.dart';
import 'package:uni_ride_application/core/services/admin_service.dart';

enum AdminState { idle, loading, success, error }

class AdminProvider extends ChangeNotifier {
  final AdminService _adminService = AdminService();

  AdminState _state = AdminState.idle;
  AdminState get state => _state;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  List<PendingApprovalModel> _pendingApprovals = [];
  List<PendingApprovalModel> get pendingApprovals => _pendingApprovals;

  void _setState(AdminState newState) {
    _state = newState;
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
