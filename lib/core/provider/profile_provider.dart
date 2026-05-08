import 'dart:io';
import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/services/profile_service.dart';
import 'package:uni_ride_application/features/profile_memberuni/data/models/driver_profile_model.dart';
import 'package:uni_ride_application/features/profile_memberuni/data/models/member_profile_model.dart';

enum ProfileState { idle, loading, success, error }

class ProfileProvider extends ChangeNotifier {
  final ProfileService _profileService = ProfileService();

  ProfileState _state          = ProfileState.idle;
  MemberProfileModel?  _memberProfile;
  DriverProfileModel?  _driverProfile;
  DriverProfileModel?  _carpoolProfile;
  String _errorMessage   = '';
  bool   _uploadingImage = false;

  ProfileState        get state          => _state;
  MemberProfileModel? get memberProfile  => _memberProfile;
  DriverProfileModel? get driverProfile  => _driverProfile;
  DriverProfileModel? get carpoolProfile => _carpoolProfile;
  String              get errorMessage   => _errorMessage;
  bool                get uploadingImage => _uploadingImage;

  Future<bool> uploadMemberProfileImage(File imageFile) async {
    _uploadingImage = true;
    notifyListeners();
    final result = await _profileService.updateProfileImage(imageFile);
    _uploadingImage = false;
    if (result.success) {
      await fetchMemberProfile();
    } else {
      _errorMessage = result.message;
      notifyListeners();
    }
    return result.success;
  }

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

  Future<bool> updateProfile({required String phoneNumber}) async {
    _state = ProfileState.loading;
    notifyListeners();
    final result = await _profileService.updateProfile(phoneNumber: phoneNumber);
    if (result.success && _memberProfile != null) {
      _memberProfile = MemberProfileModel(
        fullName:      _memberProfile!.fullName,
        email:         _memberProfile!.email,
        phoneNumber:   phoneNumber,
        profilePicturePath: _memberProfile!.profilePicturePath,
        memberSince:   _memberProfile!.memberSince,
        memberType:    _memberProfile!.memberType,
        totalTrips:    _memberProfile!.totalTrips,
        rewardPoints:  _memberProfile!.rewardPoints,
        walletBalance: _memberProfile!.walletBalance,
      );
      _state = ProfileState.success;
    } else {
      _errorMessage = result.message;
      _state = ProfileState.error;
    }
    notifyListeners();
    return result.success;
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

  Future<void> fetchCarpoolProfile() async {
    _state = ProfileState.loading;
    notifyListeners();
    try {
      _carpoolProfile = await _profileService.getCarpoolProfile();
      _state = ProfileState.success;
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _state = ProfileState.error;
    }
    notifyListeners();
  }
}
