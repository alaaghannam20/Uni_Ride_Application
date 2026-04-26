class AppEndpoints {
  static const String baseUrl = 'http://uniride.runasp.net/api/';

  static const String registerMember = 'auth/register-member';
  static const String registerDriver = 'auth/register-driver';
  static const String registerCarpool = 'auth/register-carpool';
  static const String login = 'auth/login';
  static const String sendOtp = 'auth/send-otp';
  static const String verifyOtp = 'auth/verify-otp';
  static const String forgetPassword = 'auth/forget-password';
  static const String resetPassword = 'auth/reset-password';
  static const String changePassword = 'auth/change-password';

  // Admin Endpoints
  static const String pendingApprovals  = 'Admin/pending-approvals';
  static const String approve           = 'Admin/approve';
  static const String reject            = 'Admin/reject';
  static const String dashboardStats    = 'Admin/dashboard-stats';
  static const String adminStudents     = 'admin/students';
  static const String adminTrips        = 'admin/Trips';

  // Trip Endpoints
  static const String availableTrips = 'Trip/available';
  static String tripDetails(int id) => 'Trip/$id/details';
  static const String myTrips = 'Trip/my-trips';

  // Profile Endpoints
  static const String memberProfile = 'user/member-profile';
  static const String driverProfile = 'User/driver-profile';
}