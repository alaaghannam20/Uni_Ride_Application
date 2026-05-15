import 'package:uni_ride_application/core/constants/api_keys.dart';

class MemberProfileModel {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String? profilePicturePath;
  final String memberSince;
  final String? memberType;
  final int totalTrips;
  final int rewardPoints;
  final double walletBalance;

  const MemberProfileModel({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    this.profilePicturePath,
    required this.memberSince,
    this.memberType,
    required this.totalTrips,
    required this.rewardPoints,
    required this.walletBalance,
  });

  factory MemberProfileModel.fromJson(Map<String, dynamic> json) {
    return MemberProfileModel(
      fullName: json[ApiKeys.fullName] ?? '',
      email: json[ApiKeys.email] ?? '',
      phoneNumber: json[ApiKeys.phoneNumber] ?? '',
      profilePicturePath: json[ApiKeys.profilePicturePath] ?? json[ApiKeys.profileImage] ?? json['ProfileImage'],
      memberSince: json[ApiKeys.memberSince] ?? '',
      memberType: json[ApiKeys.memberType],
      totalTrips: (json[ApiKeys.totalTrips] ?? 0).toInt(),
      rewardPoints: (json[ApiKeys.rewardPoints] ?? 0).toInt(),
      walletBalance: (json[ApiKeys.walletBalanceKey] ?? 0).toDouble(),
    );
  }
}
