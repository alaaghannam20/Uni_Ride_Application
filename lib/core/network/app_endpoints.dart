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
  static String pendingApprovalDetails(String id) => 'Admin/pending-approvals/$id';
  static const String approve           = 'Admin/approve';
  static const String reject            = 'Admin/reject';
  static const String dashboardStats    = 'Admin/dashboard-stats';
  static const String adminSettings     = 'Admin/settings';
  static const String adminStudents     = 'admin/students';
  static const String adminTrips         = 'admin/Trips';
  static const String adminDrivers = 'admin/drivers';
  static String toggleDriverStatus(String id)  => 'admin/drivers/$id/toggle-status';
  static String toggleStudentStatus(String id) => 'admin/students/$id/toggle-status';

  // Trip Endpoints
  static const String tripLocations   = 'Trip/locations';
  static const String availableTrips  = 'Trip/available';
  static String tripDetails(int id) => 'Trip/$id/details';
  static const String myTrips          = 'Trip/my-trips';
  static const String driverScheduled  = 'Trip/driver/scheduled';
  static const String driverHistory    = 'Trip/driver/history';
  static const String createTrip     = 'Trip/create';
  static String updateTrip(int id)   => 'Trip/$id';
  static String cancelTrip(int id)   => 'Trip/$id/cancel';
  static String completeTrip(int id) => 'Trip/$id/complete';
  static String publishTrip(int id)  => 'Trip/$id/publish';

  // Booking Endpoints
  static const String bookingCreate = 'booking/create';
  static String bookingCancel(int id) => 'booking/cancel/$id';
  static const String myBookings = 'booking/my-trips';

  // Profile Endpoints
  static const String memberProfile  = 'user/member-profile';
  static const String driverProfile   = 'User/driver-profile';
  static const String carpoolProfile  = 'User/carpool-profile';
  static const String updateProfile       = 'user/update-profile';
  static const String updateProfileImage  = 'user/update-profile-image';

  // Wallet & Payment Endpoints
  static const String walletBalance = 'Wallet/balance';
  static const String checkoutBookTrip = 'Checkout/book-trip';
  static String checkoutConfirmBooking(String sessionId) => 'Checkout/confirm-booking?session_id=$sessionId';
  static const String checkoutTopUp = 'Checkout/top-up';
  static String checkoutConfirmTopUp(String sessionId) => 'Checkout/confirm-top-up?session_id=$sessionId';
  static const String checkoutBookTripWallet = 'Checkout/book-trip-wallet';

  // GPS Endpoints
  static const String gpsUpdate                    = 'Gps/update';
  static String gpsLocation(String driverUserId)   => 'Gps/location/$driverUserId';
  static const String gpsHubUrl                    = 'http://uniride.runasp.net/gpsHub';

  // Notification Endpoints
  static const String notifications      = 'Notification';
  static const String notificationsRead  = 'Notification/read';
  static String notificationRead(int id) => 'Notification/$id/read';

  // Rating Endpoints
  static const String ratingSubmit        = 'Rating/submit';
  static const String ratingMyReviews     = 'Rating/my-reviews';
  static const String ratingUnreadCount   = 'Rating/unread-count';
  static const String ratingMarkAllRead   = 'Rating/mark-read';

  // Reward Endpoints
  static const String myRewards = 'Reward/my-rewards';
  static const String redeemReward = 'Reward/redeem';
}