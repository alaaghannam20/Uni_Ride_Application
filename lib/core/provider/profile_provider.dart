import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/services/profile_service.dart';
import 'package:uni_ride_application/features/profile_memberuni/data/models/driver_profile_model.dart';
import 'package:uni_ride_application/features/profile_memberuni/data/models/member_profile_model.dart';

enum ProfileState { idle, loading, success, error }

class ProfileProvider extends ChangeNotifier {
  final ProfileService _profileService = ProfileService();

  ProfileState _state = ProfileState.idle;
  MemberProfileModel? _memberProfile;
  DriverProfileModel? _driverProfile;
  String _errorMessage = '';

  ProfileState get state => _state;
  MemberProfileModel? get memberProfile => _memberProfile;
  DriverProfileModel? get driverProfile => _driverProfile;
  String get errorMessage => _errorMessage;

  Future<void> fetchMemberProfile() async {
    _state = ProfileState.loading;
    notifyListeners();
    try {
      _memberProfile = await _profileService.getMemberProfile();
      _state = ProfileState.success;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _state = ProfileState.error;
    }
    notifyListeners();
  }

  Future<void> fetchDriverProfile() async {
    _state = ProfileState.loading;
    notifyListeners();
    try {
      _driverProfile = await _profileService.getDriverProfile();
      _state = ProfileState.success;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _state = ProfileState.error;
    }
    notifyListeners();
  }
}
