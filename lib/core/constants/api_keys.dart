class ApiKeys {
  // User Model Keys
  static const String userId = 'userId';
  static const String fullName = 'fullName';
  static const String email = 'email';
  static const String userType = 'userType';
  static const String token = 'token';
  static const String status = 'status';

  // API Response Keys
  static const String success = 'success';
  static const String message = 'message';

  // Auth / Request Keys
  static const String password = 'password';
  static const String emailOrPhone = 'emailOrPhone';
  static const String otpCode = 'otpCode';
  static const String newPassword = 'newPassword';
  static const String oldPassword = 'oldPassword';

  // User Model Keys (Login response)
  static const String profileImage = 'profileImage';

  // Profile Keys
  static const String phoneNumber = 'phoneNumber';
  static const String totalTrips = 'totalTrips';
  static const String rating = 'rating';
  static const String licenseNumber = 'licenseNumber';
  static const String profilePicturePath = 'profilePicturePath';
  static const String earned = 'earned';
  static const String seatCapacity = 'seatCapacity';
  static const String memberSince = 'memberSince';
  static const String memberType = 'memberType';
  static const String rewardPoints = 'rewardPoints';
  static const String walletBalanceKey = 'walletBalance';

  // Trip Keys
  static const String tripId = 'tripId';
  static const String tripCode = 'tripCode';
  static const String driverName = 'driverName';
  static const String pickupLocation = 'pickupLocation';
  static const String dropoffLocation = 'dropoffLocation';
  static const String departureTime = 'departureTime';
  static const String pricePerSeat = 'pricePerSeat';
  static const String availableSeats = 'availableSeats';
  static const String estimatedDurationMinutes = 'estimatedDurationMinutes';
  static const String driverType = 'driverType';
  static const String vehicleModel = 'vehicleModel';
  static const String description = 'description';
  static const String stops = 'stops';
  static const String stopName = 'stopName';
  static const String estimatedArrivalTime = 'estimatedArrivalTime';
  static const String stopOrder = 'stopOrder';
  static const String totalSeats = 'totalSeats';
  static const String driverRating = 'driverRating';
  static const String totalDriverTrips = 'totalDriverTrips';
  static const String plateNumber = 'plateNumber';
  static const String vehicleType = 'vehicleType';
  static const String data = 'data';
  static const String type = 'type';

  // Booking Keys
  static const String bookingId                = 'bookingId';
  static const String bookingCode              = 'bookingCode';
  static const String seatCount               = 'seatCount';
  static const String totalAmount             = 'totalAmount';
  static const String paymentStatus           = 'paymentStatus';
  static const String driverPhone             = 'driverPhone';

  // Admin Trip / Student Keys
  static const String route          = 'route';
  static const String price          = 'price';
  static const String timeAgo        = 'timeAgo';
  static const String id             = 'id';
  static const String joined         = 'joined';

  // GPS Keys
  static const String driverUserId = 'driverUserId';

  // Settings Keys
  static const String platformFee = 'platformFee';

  // Admin Dashboard Stats Keys
  static const String totalUsersCount         = 'totalUsersCount';
  static const String activeDriversCount      = 'activeDriversCount';
  static const String totalTripsCount         = 'totalTripsCount';
  static const String pendingApprovalsCount   = 'pendingApprovalsCount';
  static const String todayTotalRevenue       = 'todayTotalRevenue';
  static const String todayCommission         = 'todayCommission';
  static const String totalRevenue            = 'totalRevenue';
  static const String platformBalance         = 'platformBalance';
  static const String revenueChangePercentage = 'revenueChangePercentage';
  static const String activeTripsNowCount     = 'activeTripsNowCount';
  static const String recentTrips             = 'recentTrips';

  // Pending Approval Keys
  static const String appliedAt             = 'appliedAt';
  static const String appliedAtAlt          = 'AppliedAt';
  static const String driverLicenseImageUrl = 'driverLicenseImage';
  static const String vehicleLicenseImageUrl= 'vehicleLicenseImage';

  // Driver Provider Keys (Backend requested them capitalized)
  static const String driverFullName = 'FullName';
  static const String driverEmail = 'Email';
  static const String driverPhoneNumber = 'PhoneNumber';
  static const String driverPassword = 'Password';
  static const String driverLicenseNumber = 'LicenseNumber';
  static const String driverVehicleType = 'VehicleType';
  static const String driverVehicleModel = 'VehicleModel';
  static const String driverPlateNumber = 'PlateNumber';
  static const String driverSeatCapacity = 'SeatCapacity';
  static const String driverLicenseImage = 'DriverLicenseImage';
  static const String driverVehicleLicenseImage = 'VehicleLicenseImage';
  static const String driverProfileImage = 'ProfileImage';
}
