import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @ar.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get ar;

  /// No description provided for @en.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get en;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @go.
  ///
  /// In en, this message translates to:
  /// **'Go'**
  String get go;

  /// No description provided for @onboarding2Title.
  ///
  /// In en, this message translates to:
  /// **'Smart Campus Transportation'**
  String get onboarding2Title;

  /// No description provided for @onboardingDescription.
  ///
  /// In en, this message translates to:
  /// **'Seamless booking, real-time tracking, and reliable transport for every university day.'**
  String get onboardingDescription;

  /// No description provided for @onboarding3Title.
  ///
  /// In en, this message translates to:
  /// **'Book • Track • Arrive'**
  String get onboarding3Title;

  /// No description provided for @onboarding4Title.
  ///
  /// In en, this message translates to:
  /// **'Connected Rides, be Connected'**
  String get onboarding4Title;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @driver.
  ///
  /// In en, this message translates to:
  /// **'Driver'**
  String get driver;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @minimum8Chars.
  ///
  /// In en, this message translates to:
  /// **'Minimum 8 characters'**
  String get minimum8Chars;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @universityMember.
  ///
  /// In en, this message translates to:
  /// **'University Member'**
  String get universityMember;

  /// No description provided for @otpVerification.
  ///
  /// In en, this message translates to:
  /// **'OTP Verification'**
  String get otpVerification;

  /// No description provided for @enterVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Verification Code'**
  String get enterVerificationCode;

  /// No description provided for @sentCodeTo.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a 4-digit code to'**
  String get sentCodeTo;

  /// No description provided for @resendCodeIn.
  ///
  /// In en, this message translates to:
  /// **'Resend code in '**
  String get resendCodeIn;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @changeEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Change Email Address'**
  String get changeEmailAddress;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @signUpCarpool.
  ///
  /// In en, this message translates to:
  /// **'Sign Up Carpool'**
  String get signUpCarpool;

  /// No description provided for @signUpDriver.
  ///
  /// In en, this message translates to:
  /// **'Sign Up Driver'**
  String get signUpDriver;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @vehicleDetails.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Details'**
  String get vehicleDetails;

  /// No description provided for @numberOfSeats.
  ///
  /// In en, this message translates to:
  /// **'Number of Seats'**
  String get numberOfSeats;

  /// No description provided for @driverInformation.
  ///
  /// In en, this message translates to:
  /// **'Driver Information'**
  String get driverInformation;

  /// No description provided for @licenseNumber.
  ///
  /// In en, this message translates to:
  /// **'License Number'**
  String get licenseNumber;

  /// No description provided for @vehicleType.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Type'**
  String get vehicleType;

  /// No description provided for @plateNumber.
  ///
  /// In en, this message translates to:
  /// **'Plate Number'**
  String get plateNumber;

  /// No description provided for @uploadDriverLicense.
  ///
  /// In en, this message translates to:
  /// **'Upload a copy of your valid driver\'s license.'**
  String get uploadDriverLicense;

  /// No description provided for @uploadVehicleLicense.
  ///
  /// In en, this message translates to:
  /// **'Upload a copy of your vehicle license.'**
  String get uploadVehicleLicense;

  /// No description provided for @uploadDocument.
  ///
  /// In en, this message translates to:
  /// **'Upload Document'**
  String get uploadDocument;

  /// No description provided for @agreeTerms.
  ///
  /// In en, this message translates to:
  /// **'I agree to the Terms and Privacy Policy'**
  String get agreeTerms;

  /// No description provided for @continu.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continu;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @emailOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Email or Phone'**
  String get emailOrPhone;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember Me'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgetPassword;

  /// No description provided for @enteryouremailtoresetyourpassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your email \n to reset your password\''**
  String get enteryouremailtoresetyourpassword;

  /// No description provided for @sendCode.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get sendCode;

  /// No description provided for @enterCode.
  ///
  /// In en, this message translates to:
  /// **'Enter Code'**
  String get enterCode;

  /// No description provided for @didntReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive a code? '**
  String get didntReceiveCode;

  /// No description provided for @sendAgain.
  ///
  /// In en, this message translates to:
  /// **'Send Again'**
  String get sendAgain;

  /// No description provided for @resetPassword.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @yourNewPasswordMustBeDifferentFromPreviousOne.
  ///
  /// In en, this message translates to:
  /// **'Your new password must be different from the previous one'**
  String get yourNewPasswordMustBeDifferentFromPreviousOne;

  /// No description provided for @passwordChanged.
  ///
  /// In en, this message translates to:
  /// **'Password Changed'**
  String get passwordChanged;

  /// No description provided for @passwordChangedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your password has been \n changed successfully'**
  String get passwordChangedSuccess;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish!'**
  String get finish;

  /// No description provided for @poweredBy.
  ///
  /// In en, this message translates to:
  /// **'Powered by '**
  String get poweredBy;

  /// No description provided for @ptukEngineering.
  ///
  /// In en, this message translates to:
  /// **'PTUK Engineering'**
  String get ptukEngineering;

  /// No description provided for @signUpUniversity.
  ///
  /// In en, this message translates to:
  /// **'Sign Up University'**
  String get signUpUniversity;

  /// No description provided for @driverDocuments.
  ///
  /// In en, this message translates to:
  /// **'Driver Documents'**
  String get driverDocuments;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmail;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email address'**
  String get invalidEmail;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @enterFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterFullName;

  /// No description provided for @enterPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterPhone;

  /// No description provided for @invalidPhone.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get invalidPhone;

  /// No description provided for @enterCarType.
  ///
  /// In en, this message translates to:
  /// **'Enter car type'**
  String get enterCarType;

  /// No description provided for @enterNumberOfSeats.
  ///
  /// In en, this message translates to:
  /// **'Enter number of seats'**
  String get enterNumberOfSeats;

  /// No description provided for @enterLicenseNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter license number'**
  String get enterLicenseNumber;

  /// No description provided for @enterVehicleType.
  ///
  /// In en, this message translates to:
  /// **'Enter vehicle type'**
  String get enterVehicleType;

  /// No description provided for @enterPlateNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter plate number'**
  String get enterPlateNumber;

  /// No description provided for @pleaseAgreeTerms.
  ///
  /// In en, this message translates to:
  /// **'Please agree to the Terms and Privacy Policy'**
  String get pleaseAgreeTerms;

  /// No description provided for @submittedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Driver Sign Up Submitted Successfully'**
  String get submittedSuccessfully;

  /// No description provided for @signUpNow.
  ///
  /// In en, this message translates to:
  /// **'Sign Up Now'**
  String get signUpNow;

  /// No description provided for @car.
  ///
  /// In en, this message translates to:
  /// **'Car'**
  String get car;

  /// No description provided for @service.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get service;

  /// No description provided for @bus.
  ///
  /// In en, this message translates to:
  /// **'Bus'**
  String get bus;

  /// No description provided for @vehicleModel.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Model'**
  String get vehicleModel;

  /// No description provided for @enterVehicleModel.
  ///
  /// In en, this message translates to:
  /// **'Enter Vehicle Model'**
  String get enterVehicleModel;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get searchHint;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @ptukAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin Panel'**
  String get ptukAdmin;

  /// No description provided for @ptukTransport.
  ///
  /// In en, this message translates to:
  /// **'PTUK Transport'**
  String get ptukTransport;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @pendingApprovals.
  ///
  /// In en, this message translates to:
  /// **'Pending Approvals'**
  String get pendingApprovals;

  /// No description provided for @driverDetails.
  ///
  /// In en, this message translates to:
  /// **'Driver Details'**
  String get driverDetails;

  /// No description provided for @applicationInfo.
  ///
  /// In en, this message translates to:
  /// **'Application Info'**
  String get applicationInfo;

  /// No description provided for @applicationType.
  ///
  /// In en, this message translates to:
  /// **'Application Type'**
  String get applicationType;

  /// No description provided for @appliedDate.
  ///
  /// In en, this message translates to:
  /// **'Applied Date'**
  String get appliedDate;

  /// No description provided for @rejectApplication.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get rejectApplication;

  /// No description provided for @approveApplication.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approveApplication;

  /// No description provided for @approvedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Application approved successfully'**
  String get approvedSuccessfully;

  /// No description provided for @uploadedDocuments.
  ///
  /// In en, this message translates to:
  /// **'Uploaded Documents'**
  String get uploadedDocuments;

  /// No description provided for @rejectedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Application rejected successfully'**
  String get rejectedSuccessfully;

  /// No description provided for @drivers.
  ///
  /// In en, this message translates to:
  /// **'Drivers'**
  String get drivers;

  /// No description provided for @students.
  ///
  /// In en, this message translates to:
  /// **'Students'**
  String get students;

  /// No description provided for @trips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get trips;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @appSettings.
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// No description provided for @carType.
  ///
  /// In en, this message translates to:
  /// **'Car Type'**
  String get carType;

  /// No description provided for @adminUser.
  ///
  /// In en, this message translates to:
  /// **'Admin User'**
  String get adminUser;

  /// No description provided for @adminEmail.
  ///
  /// In en, this message translates to:
  /// **'admin@ptuk.edu'**
  String get adminEmail;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @vehicleInformation.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Information'**
  String get vehicleInformation;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve;

  /// No description provided for @applied.
  ///
  /// In en, this message translates to:
  /// **'Applied'**
  String get applied;

  /// No description provided for @driverManagement.
  ///
  /// In en, this message translates to:
  /// **'Driver Management'**
  String get driverManagement;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @totalTrips.
  ///
  /// In en, this message translates to:
  /// **'Total Trips'**
  String get totalTrips;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @actions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actions;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @activate.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get activate;

  /// No description provided for @deactivate.
  ///
  /// In en, this message translates to:
  /// **'Deactivate'**
  String get deactivate;

  /// No description provided for @studentManagement.
  ///
  /// In en, this message translates to:
  /// **'Student Management'**
  String get studentManagement;

  /// No description provided for @student.
  ///
  /// In en, this message translates to:
  /// **'Student'**
  String get student;

  /// No description provided for @universityMemberManagement.
  ///
  /// In en, this message translates to:
  /// **'University Member Management'**
  String get universityMemberManagement;

  /// No description provided for @universityMembers.
  ///
  /// In en, this message translates to:
  /// **'University Members'**
  String get universityMembers;

  /// No description provided for @joined.
  ///
  /// In en, this message translates to:
  /// **'Joined'**
  String get joined;

  /// No description provided for @tripManagement.
  ///
  /// In en, this message translates to:
  /// **'Trip Management'**
  String get tripManagement;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @ongoing.
  ///
  /// In en, this message translates to:
  /// **'Ongoing'**
  String get ongoing;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @ils.
  ///
  /// In en, this message translates to:
  /// **'₪'**
  String get ils;

  /// No description provided for @systemSettings.
  ///
  /// In en, this message translates to:
  /// **'System Settings'**
  String get systemSettings;

  /// No description provided for @dashboardOverview.
  ///
  /// In en, this message translates to:
  /// **'Dashboard Overview'**
  String get dashboardOverview;

  /// No description provided for @totalUsers.
  ///
  /// In en, this message translates to:
  /// **'Total Users'**
  String get totalUsers;

  /// No description provided for @activeDrivers.
  ///
  /// In en, this message translates to:
  /// **'Active Drivers'**
  String get activeDrivers;

  /// No description provided for @totalTripsCount.
  ///
  /// In en, this message translates to:
  /// **'Total Trips'**
  String get totalTripsCount;

  /// No description provided for @todayRevenue.
  ///
  /// In en, this message translates to:
  /// **'Total Revenue'**
  String get todayRevenue;

  /// No description provided for @activeTripsNow.
  ///
  /// In en, this message translates to:
  /// **'Active Trips Now'**
  String get activeTripsNow;

  /// No description provided for @realtimeMonitoring.
  ///
  /// In en, this message translates to:
  /// **'Real-time monitoring'**
  String get realtimeMonitoring;

  /// No description provided for @recentTrips.
  ///
  /// In en, this message translates to:
  /// **'Recent Trips'**
  String get recentTrips;

  /// No description provided for @noRecentTrips.
  ///
  /// In en, this message translates to:
  /// **'No recent trips'**
  String get noRecentTrips;

  /// No description provided for @fromYesterday.
  ///
  /// In en, this message translates to:
  /// **'from yesterday'**
  String get fromYesterday;

  /// No description provided for @platformEarnings.
  ///
  /// In en, this message translates to:
  /// **'Platform earnings'**
  String get platformEarnings;

  /// No description provided for @systemConfiguration.
  ///
  /// In en, this message translates to:
  /// **'System Configuration'**
  String get systemConfiguration;

  /// No description provided for @pricingConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Pricing Configuration'**
  String get pricingConfiguration;

  /// No description provided for @autoApproveDrivers.
  ///
  /// In en, this message translates to:
  /// **'Auto-approve Drivers'**
  String get autoApproveDrivers;

  /// No description provided for @autoApproveDriversDesc.
  ///
  /// In en, this message translates to:
  /// **'Automatically approve verified drivers'**
  String get autoApproveDriversDesc;

  /// No description provided for @emailNotifications.
  ///
  /// In en, this message translates to:
  /// **'Email Notifications'**
  String get emailNotifications;

  /// No description provided for @emailNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Send email alerts for important events'**
  String get emailNotificationsDesc;

  /// No description provided for @smsNotifications.
  ///
  /// In en, this message translates to:
  /// **'SMS Notifications'**
  String get smsNotifications;

  /// No description provided for @smsNotificationsDesc.
  ///
  /// In en, this message translates to:
  /// **'Send SMS alerts to users'**
  String get smsNotificationsDesc;

  /// No description provided for @baseFare.
  ///
  /// In en, this message translates to:
  /// **'Base Fare (₪)'**
  String get baseFare;

  /// No description provided for @perKilometer.
  ///
  /// In en, this message translates to:
  /// **'Per Kilometer (₪)'**
  String get perKilometer;

  /// No description provided for @appFee.
  ///
  /// In en, this message translates to:
  /// **'App Fee'**
  String get appFee;

  /// No description provided for @included.
  ///
  /// In en, this message translates to:
  /// **'included'**
  String get included;

  /// No description provided for @appFeePerTrip.
  ///
  /// In en, this message translates to:
  /// **'Platform Fee per Trip (₪)'**
  String get appFeePerTrip;

  /// No description provided for @appFeePerTripDesc.
  ///
  /// In en, this message translates to:
  /// **'Automatically added on top of driver price and paid by the student'**
  String get appFeePerTripDesc;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @feeSavedSuccess.
  ///
  /// In en, this message translates to:
  /// **'App fee saved successfully'**
  String get feeSavedSuccess;

  /// No description provided for @feeSavedLocalOnly.
  ///
  /// In en, this message translates to:
  /// **'Saved locally — check connection'**
  String get feeSavedLocalOnly;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @editPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Edit Phone Number'**
  String get editPhoneNumber;

  /// No description provided for @profileUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdatedSuccess;

  /// No description provided for @vehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get vehicle;

  /// No description provided for @underReview.
  ///
  /// In en, this message translates to:
  /// **'Your account is under review by the administration. Please try again later.'**
  String get underReview;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @tripSummary.
  ///
  /// In en, this message translates to:
  /// **'Trip Summary'**
  String get tripSummary;

  /// No description provided for @route.
  ///
  /// In en, this message translates to:
  /// **'Route'**
  String get route;

  /// No description provided for @dateTime.
  ///
  /// In en, this message translates to:
  /// **'Date & Time'**
  String get dateTime;

  /// No description provided for @pricePerSeat.
  ///
  /// In en, this message translates to:
  /// **'Price per seat'**
  String get pricePerSeat;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmount;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @confirmPayment.
  ///
  /// In en, this message translates to:
  /// **'Confirm Payment'**
  String get confirmPayment;

  /// No description provided for @myWallet.
  ///
  /// In en, this message translates to:
  /// **'My Wallet'**
  String get myWallet;

  /// No description provided for @transactionHistory.
  ///
  /// In en, this message translates to:
  /// **'Transaction history'**
  String get transactionHistory;

  /// No description provided for @currentBalance.
  ///
  /// In en, this message translates to:
  /// **'Current Balance'**
  String get currentBalance;

  /// No description provided for @topUpWallet.
  ///
  /// In en, this message translates to:
  /// **'Top Up Wallet'**
  String get topUpWallet;

  /// No description provided for @searchTransactions.
  ///
  /// In en, this message translates to:
  /// **'Search transactions...'**
  String get searchTransactions;

  /// No description provided for @allTabs.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allTabs;

  /// No description provided for @paymentsTabs.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get paymentsTabs;

  /// No description provided for @refundsTabs.
  ///
  /// In en, this message translates to:
  /// **'Refunds'**
  String get refundsTabs;

  /// No description provided for @topUpsTabs.
  ///
  /// In en, this message translates to:
  /// **'Top-ups'**
  String get topUpsTabs;

  /// No description provided for @tripPayment.
  ///
  /// In en, this message translates to:
  /// **'Trip Payment'**
  String get tripPayment;

  /// No description provided for @walletTopUp.
  ///
  /// In en, this message translates to:
  /// **'Wallet Top-up'**
  String get walletTopUp;

  /// No description provided for @tripCancellationRefund.
  ///
  /// In en, this message translates to:
  /// **'Trip Cancellation Refund'**
  String get tripCancellationRefund;

  /// No description provided for @driverCancellationRefund.
  ///
  /// In en, this message translates to:
  /// **'Driver Cancellation Refund'**
  String get driverCancellationRefund;

  /// No description provided for @ptukWallet.
  ///
  /// In en, this message translates to:
  /// **'PTUK Wallet'**
  String get ptukWallet;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @manageAccount.
  ///
  /// In en, this message translates to:
  /// **'Manage your account'**
  String get manageAccount;

  /// No description provided for @memberSince.
  ///
  /// In en, this message translates to:
  /// **'Member since'**
  String get memberSince;

  /// No description provided for @tripsCount.
  ///
  /// In en, this message translates to:
  /// **'trips'**
  String get tripsCount;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light mode'**
  String get lightMode;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @markAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get markAllRead;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get noNotifications;

  /// No description provided for @notifTypeTrip.
  ///
  /// In en, this message translates to:
  /// **'Trip'**
  String get notifTypeTrip;

  /// No description provided for @notifTypeBooking.
  ///
  /// In en, this message translates to:
  /// **'Booking'**
  String get notifTypeBooking;

  /// No description provided for @notifTypeAdmin.
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get notifTypeAdmin;

  /// No description provided for @notifTypeGeneral.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notifTypeGeneral;

  /// No description provided for @notifTypeWallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get notifTypeWallet;

  /// No description provided for @timeJustNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get timeJustNow;

  /// No description provided for @pushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push notifications'**
  String get pushNotifications;

  /// No description provided for @securitySupport.
  ///
  /// In en, this message translates to:
  /// **'Security & Support'**
  String get securitySupport;

  /// No description provided for @privacySecurity.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get privacySecurity;

  /// No description provided for @managePrivacySettings.
  ///
  /// In en, this message translates to:
  /// **'Manage your privacy settings'**
  String get managePrivacySettings;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// No description provided for @getHelpOrContact.
  ///
  /// In en, this message translates to:
  /// **'Get help or contact us'**
  String get getHelpOrContact;

  /// No description provided for @rateYourDriver.
  ///
  /// In en, this message translates to:
  /// **'Rate Your Driver'**
  String get rateYourDriver;

  /// No description provided for @howWasExperience.
  ///
  /// In en, this message translates to:
  /// **'How was your experience?'**
  String get howWasExperience;

  /// No description provided for @ratingPoor.
  ///
  /// In en, this message translates to:
  /// **'Poor'**
  String get ratingPoor;

  /// No description provided for @ratingFair.
  ///
  /// In en, this message translates to:
  /// **'Fair'**
  String get ratingFair;

  /// No description provided for @ratingGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get ratingGood;

  /// No description provided for @ratingVeryGood.
  ///
  /// In en, this message translates to:
  /// **'Very Good'**
  String get ratingVeryGood;

  /// No description provided for @ratingExcellent.
  ///
  /// In en, this message translates to:
  /// **'Excellent'**
  String get ratingExcellent;

  /// No description provided for @additionalComments.
  ///
  /// In en, this message translates to:
  /// **'Additional Comments'**
  String get additionalComments;

  /// No description provided for @shareMoreDetails.
  ///
  /// In en, this message translates to:
  /// **'Share more details about your experience (optional)'**
  String get shareMoreDetails;

  /// No description provided for @commentHint.
  ///
  /// In en, this message translates to:
  /// **'What did you like or dislike about this trip?'**
  String get commentHint;

  /// No description provided for @characters.
  ///
  /// In en, this message translates to:
  /// **'characters'**
  String get characters;

  /// No description provided for @quickFeedback.
  ///
  /// In en, this message translates to:
  /// **'Quick Feedback'**
  String get quickFeedback;

  /// No description provided for @friendly.
  ///
  /// In en, this message translates to:
  /// **'Friendly'**
  String get friendly;

  /// No description provided for @onTime.
  ///
  /// In en, this message translates to:
  /// **'On Time'**
  String get onTime;

  /// No description provided for @safeDriver.
  ///
  /// In en, this message translates to:
  /// **'Safe Driver'**
  String get safeDriver;

  /// No description provided for @cleanCar.
  ///
  /// In en, this message translates to:
  /// **'Clean Car'**
  String get cleanCar;

  /// No description provided for @submitRating.
  ///
  /// In en, this message translates to:
  /// **'Submit Rating'**
  String get submitRating;

  /// No description provided for @find_trips.
  ///
  /// In en, this message translates to:
  /// **'Find Trips'**
  String get find_trips;

  /// No description provided for @my_trips.
  ///
  /// In en, this message translates to:
  /// **'My Trips'**
  String get my_trips;

  /// No description provided for @carpool.
  ///
  /// In en, this message translates to:
  /// **'Carpool'**
  String get carpool;

  /// No description provided for @rewards.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get rewards;

  /// No description provided for @where_to_today.
  ///
  /// In en, this message translates to:
  /// **'Where to today?'**
  String get where_to_today;

  /// No description provided for @search_trips.
  ///
  /// In en, this message translates to:
  /// **'Search for trips...'**
  String get search_trips;

  /// No description provided for @available_trips.
  ///
  /// In en, this message translates to:
  /// **'Available Trips'**
  String get available_trips;

  /// No description provided for @view_all.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get view_all;

  /// No description provided for @hello_user.
  ///
  /// In en, this message translates to:
  /// **'Hello, '**
  String get hello_user;

  /// No description provided for @offer_a_ride.
  ///
  /// In en, this message translates to:
  /// **'Offer a Ride'**
  String get offer_a_ride;

  /// No description provided for @offer_ride_sub.
  ///
  /// In en, this message translates to:
  /// **'Share your journey and earn rewards'**
  String get offer_ride_sub;

  /// No description provided for @available_rides.
  ///
  /// In en, this message translates to:
  /// **'Available Rides'**
  String get available_rides;

  /// No description provided for @my_rides.
  ///
  /// In en, this message translates to:
  /// **'My Rides'**
  String get my_rides;

  /// No description provided for @find_rides.
  ///
  /// In en, this message translates to:
  /// **'Find Rides'**
  String get find_rides;

  /// No description provided for @no_rides_yet.
  ///
  /// In en, this message translates to:
  /// **'No rides yet'**
  String get no_rides_yet;

  /// No description provided for @no_rides_sub.
  ///
  /// In en, this message translates to:
  /// **'Start offering rides or join carpools to see them here'**
  String get no_rides_sub;

  /// No description provided for @offer_first_ride.
  ///
  /// In en, this message translates to:
  /// **'Offer Your First Ride'**
  String get offer_first_ride;

  /// No description provided for @your_points.
  ///
  /// In en, this message translates to:
  /// **'Your Points'**
  String get your_points;

  /// No description provided for @level.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get level;

  /// No description provided for @gold_member.
  ///
  /// In en, this message translates to:
  /// **'Gold Member'**
  String get gold_member;

  /// No description provided for @rank.
  ///
  /// In en, this message translates to:
  /// **'Rank'**
  String get rank;

  /// No description provided for @refer_a_friend.
  ///
  /// In en, this message translates to:
  /// **'Refer a Friend'**
  String get refer_a_friend;

  /// No description provided for @refer_sub.
  ///
  /// In en, this message translates to:
  /// **'Get 10 points for each referral'**
  String get refer_sub;

  /// No description provided for @friends_joined.
  ///
  /// In en, this message translates to:
  /// **'3 friends joined · +150 pts earned'**
  String get friends_joined;

  /// No description provided for @achievements.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievements;

  /// No description provided for @redeem_rewards.
  ///
  /// In en, this message translates to:
  /// **'Redeem Rewards'**
  String get redeem_rewards;

  /// No description provided for @ach_first_ride_title.
  ///
  /// In en, this message translates to:
  /// **'First Ride'**
  String get ach_first_ride_title;

  /// No description provided for @ach_first_ride_sub.
  ///
  /// In en, this message translates to:
  /// **'Complete your first trip'**
  String get ach_first_ride_sub;

  /// No description provided for @ach_top_rider_title.
  ///
  /// In en, this message translates to:
  /// **'Top Rider'**
  String get ach_top_rider_title;

  /// No description provided for @ach_top_rider_sub.
  ///
  /// In en, this message translates to:
  /// **'Complete 20 trips'**
  String get ach_top_rider_sub;

  /// No description provided for @rew_free_ride_title.
  ///
  /// In en, this message translates to:
  /// **'Free Ride'**
  String get rew_free_ride_title;

  /// No description provided for @rew_free_ride_sub.
  ///
  /// In en, this message translates to:
  /// **'Get one trip completely free'**
  String get rew_free_ride_sub;

  /// No description provided for @rew_half_off_title.
  ///
  /// In en, this message translates to:
  /// **'50% Off Next Ride'**
  String get rew_half_off_title;

  /// No description provided for @rew_half_off_sub.
  ///
  /// In en, this message translates to:
  /// **'Half price on your next trip'**
  String get rew_half_off_sub;

  /// No description provided for @per_seat.
  ///
  /// In en, this message translates to:
  /// **'per seat'**
  String get per_seat;

  /// No description provided for @trip_details.
  ///
  /// In en, this message translates to:
  /// **'Trip Details'**
  String get trip_details;

  /// No description provided for @trips_label.
  ///
  /// In en, this message translates to:
  /// **'trips'**
  String get trips_label;

  /// No description provided for @driver_information.
  ///
  /// In en, this message translates to:
  /// **'Driver Information'**
  String get driver_information;

  /// No description provided for @pickup_points.
  ///
  /// In en, this message translates to:
  /// **'Pickup Points'**
  String get pickup_points;

  /// No description provided for @available_seats.
  ///
  /// In en, this message translates to:
  /// **'Available Seats'**
  String get available_seats;

  /// No description provided for @select_seats.
  ///
  /// In en, this message translates to:
  /// **'Select Seats'**
  String get select_seats;

  /// No description provided for @seats_remaining.
  ///
  /// In en, this message translates to:
  /// **'seats remaining'**
  String get seats_remaining;

  /// No description provided for @how_many_seats.
  ///
  /// In en, this message translates to:
  /// **'How many seats approach?'**
  String get how_many_seats;

  /// No description provided for @seats_available.
  ///
  /// In en, this message translates to:
  /// **'seats available'**
  String get seats_available;

  /// No description provided for @number_of_seats_label.
  ///
  /// In en, this message translates to:
  /// **'Number of seats'**
  String get number_of_seats_label;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @total_price.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get total_price;

  /// No description provided for @book_now.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get book_now;

  /// No description provided for @booking_confirmed.
  ///
  /// In en, this message translates to:
  /// **'Booking Confirmed!'**
  String get booking_confirmed;

  /// No description provided for @booking_confirmed_sub.
  ///
  /// In en, this message translates to:
  /// **'Your trip has been booked successfully.'**
  String get booking_confirmed_sub;

  /// No description provided for @will_be_charged.
  ///
  /// In en, this message translates to:
  /// **'will be charged from your wallet.'**
  String get will_be_charged;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @pickup_ptuk_gate.
  ///
  /// In en, this message translates to:
  /// **'PTUK Main Gate'**
  String get pickup_ptuk_gate;

  /// No description provided for @pickup_eng_building.
  ///
  /// In en, this message translates to:
  /// **'Industry Gateway'**
  String get pickup_eng_building;

  /// No description provided for @pickup_student_housing.
  ///
  /// In en, this message translates to:
  /// **'Energy Gateway'**
  String get pickup_student_housing;

  /// No description provided for @selectPickupPoint.
  ///
  /// In en, this message translates to:
  /// **'Select pickup point'**
  String get selectPickupPoint;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @upcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get upcoming;

  /// No description provided for @recurring.
  ///
  /// In en, this message translates to:
  /// **'Recurring'**
  String get recurring;

  /// No description provided for @per_seat_label.
  ///
  /// In en, this message translates to:
  /// **'/seat'**
  String get per_seat_label;

  /// No description provided for @recurring_ride.
  ///
  /// In en, this message translates to:
  /// **'Recurring Ride'**
  String get recurring_ride;

  /// No description provided for @filter_label.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter_label;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;

  /// No description provided for @carpool_find_rides.
  ///
  /// In en, this message translates to:
  /// **'Find Rides'**
  String get carpool_find_rides;

  /// No description provided for @carpool_my_rides.
  ///
  /// In en, this message translates to:
  /// **'My Rides'**
  String get carpool_my_rides;

  /// No description provided for @no_rides_found.
  ///
  /// In en, this message translates to:
  /// **'No rides found.'**
  String get no_rides_found;

  /// No description provided for @refer_friend_title.
  ///
  /// In en, this message translates to:
  /// **'Refer a Friend & Earn'**
  String get refer_friend_title;

  /// No description provided for @refer_friend_sub.
  ///
  /// In en, this message translates to:
  /// **'Get 50 points for each referral and your friend gets \$10 off.'**
  String get refer_friend_sub;

  /// No description provided for @referrals_label.
  ///
  /// In en, this message translates to:
  /// **'referrals'**
  String get referrals_label;

  /// No description provided for @points_label.
  ///
  /// In en, this message translates to:
  /// **'points'**
  String get points_label;

  /// No description provided for @total_points_label.
  ///
  /// In en, this message translates to:
  /// **'Total Points'**
  String get total_points_label;

  /// No description provided for @redeem_points_btn.
  ///
  /// In en, this message translates to:
  /// **'Redeem Your Points'**
  String get redeem_points_btn;

  /// No description provided for @all_available_trips.
  ///
  /// In en, this message translates to:
  /// **'All Available Trips'**
  String get all_available_trips;

  /// No description provided for @trips_available_count.
  ///
  /// In en, this message translates to:
  /// **'{count} trips available'**
  String trips_available_count(Object count);

  /// No description provided for @offer_a_carpool.
  ///
  /// In en, this message translates to:
  /// **'Offer a Carpool'**
  String get offer_a_carpool;

  /// No description provided for @offer_carpool_sub.
  ///
  /// In en, this message translates to:
  /// **'Share your ride and earn rewards'**
  String get offer_carpool_sub;

  /// No description provided for @car_details.
  ///
  /// In en, this message translates to:
  /// **'Car Details'**
  String get car_details;

  /// No description provided for @car_type.
  ///
  /// In en, this message translates to:
  /// **'Car Type'**
  String get car_type;

  /// No description provided for @number_of_car_seats.
  ///
  /// In en, this message translates to:
  /// **'Number of Car\'s Seats'**
  String get number_of_car_seats;

  /// No description provided for @route_details.
  ///
  /// In en, this message translates to:
  /// **'Route Details'**
  String get route_details;

  /// No description provided for @pickup_loc.
  ///
  /// In en, this message translates to:
  /// **'Pickup Location'**
  String get pickup_loc;

  /// No description provided for @dropoff_loc.
  ///
  /// In en, this message translates to:
  /// **'Dropoff Location'**
  String get dropoff_loc;

  /// No description provided for @when_leaving.
  ///
  /// In en, this message translates to:
  /// **'When are you leaving?'**
  String get when_leaving;

  /// No description provided for @available_seats_label.
  ///
  /// In en, this message translates to:
  /// **'Available Seats'**
  String get available_seats_label;

  /// No description provided for @how_many_passengers.
  ///
  /// In en, this message translates to:
  /// **'How many passengers can you take?'**
  String get how_many_passengers;

  /// No description provided for @price_per_seat_label.
  ///
  /// In en, this message translates to:
  /// **'Price per Seat'**
  String get price_per_seat_label;

  /// No description provided for @set_price.
  ///
  /// In en, this message translates to:
  /// **'Set your price in ILS (₪)'**
  String get set_price;

  /// No description provided for @suggested_price_range.
  ///
  /// In en, this message translates to:
  /// **'₪3 will be added to your price for the app'**
  String get suggested_price_range;

  /// No description provided for @additional_notes_optional.
  ///
  /// In en, this message translates to:
  /// **'Additional Notes (Optional)'**
  String get additional_notes_optional;

  /// No description provided for @notes_hint.
  ///
  /// In en, this message translates to:
  /// **'Any special requirements or information...'**
  String get notes_hint;

  /// No description provided for @estimated_earnings.
  ///
  /// In en, this message translates to:
  /// **'Estimated Earnings'**
  String get estimated_earnings;

  /// No description provided for @continue_to_preview.
  ///
  /// In en, this message translates to:
  /// **'Continue to Preview'**
  String get continue_to_preview;

  /// No description provided for @registration_submitted.
  ///
  /// In en, this message translates to:
  /// **'Registration Submitted'**
  String get registration_submitted;

  /// No description provided for @under_review_message.
  ///
  /// In en, this message translates to:
  /// **'Your registration is under review. You will be able to login once the admin approves your account.'**
  String get under_review_message;

  /// No description provided for @upload_both_licenses.
  ///
  /// In en, this message translates to:
  /// **'Please upload both license images'**
  String get upload_both_licenses;

  /// No description provided for @oK.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get oK;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @preview_your_offer.
  ///
  /// In en, this message translates to:
  /// **'Preview Your Offer'**
  String get preview_your_offer;

  /// No description provided for @review_before_posting.
  ///
  /// In en, this message translates to:
  /// **'Review before posting'**
  String get review_before_posting;

  /// No description provided for @your_route.
  ///
  /// In en, this message translates to:
  /// **'Your Route'**
  String get your_route;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @approx_drive.
  ///
  /// In en, this message translates to:
  /// **'Approx. drive'**
  String get approx_drive;

  /// No description provided for @departure_details.
  ///
  /// In en, this message translates to:
  /// **'Departure Details'**
  String get departure_details;

  /// No description provided for @departure_time.
  ///
  /// In en, this message translates to:
  /// **'Departure Time'**
  String get departure_time;

  /// No description provided for @pricing_details.
  ///
  /// In en, this message translates to:
  /// **'Pricing Details'**
  String get pricing_details;

  /// No description provided for @total_potential_earnings.
  ///
  /// In en, this message translates to:
  /// **'Total Potential Earnings'**
  String get total_potential_earnings;

  /// No description provided for @if_all_seats_booked.
  ///
  /// In en, this message translates to:
  /// **'If all seats are booked'**
  String get if_all_seats_booked;

  /// No description provided for @ready_to_post.
  ///
  /// In en, this message translates to:
  /// **'Ready to Post?'**
  String get ready_to_post;

  /// No description provided for @ready_to_post_sub.
  ///
  /// In en, this message translates to:
  /// **'Your offer will be visible to all students. You\'ll receive notifications when someone books a seat.'**
  String get ready_to_post_sub;

  /// No description provided for @post_carpool_offer.
  ///
  /// In en, this message translates to:
  /// **'Post Carpool Offer'**
  String get post_carpool_offer;

  /// No description provided for @offer_posted_successfully.
  ///
  /// In en, this message translates to:
  /// **'Carpool Offer Posted Successfully!'**
  String get offer_posted_successfully;

  /// No description provided for @congratulations.
  ///
  /// In en, this message translates to:
  /// **'Congratulations!'**
  String get congratulations;

  /// No description provided for @back_to_home.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get back_to_home;

  /// No description provided for @offer_posted.
  ///
  /// In en, this message translates to:
  /// **'Offer Posted!'**
  String get offer_posted;

  /// No description provided for @offer_posted_sub.
  ///
  /// In en, this message translates to:
  /// **'Your carpool is now live and visible to students'**
  String get offer_posted_sub;

  /// No description provided for @carpool_id.
  ///
  /// In en, this message translates to:
  /// **'Carpool ID'**
  String get carpool_id;

  /// No description provided for @your_carpool_offer.
  ///
  /// In en, this message translates to:
  /// **'Your Carpool Offer'**
  String get your_carpool_offer;

  /// No description provided for @offer_statistics.
  ///
  /// In en, this message translates to:
  /// **'Offer Statistics'**
  String get offer_statistics;

  /// No description provided for @potential_earnings.
  ///
  /// In en, this message translates to:
  /// **'Potential Earnings'**
  String get potential_earnings;

  /// No description provided for @activeTrip.
  ///
  /// In en, this message translates to:
  /// **'Active Trip'**
  String get activeTrip;

  /// No description provided for @pickupIn5Min.
  ///
  /// In en, this message translates to:
  /// **'Pickup in 5 min'**
  String get pickupIn5Min;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @scheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get scheduled;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @navigate.
  ///
  /// In en, this message translates to:
  /// **'Navigate'**
  String get navigate;

  /// No description provided for @bookingId.
  ///
  /// In en, this message translates to:
  /// **'Booking ID'**
  String get bookingId;

  /// No description provided for @confirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get confirmed;

  /// No description provided for @pickupLocation.
  ///
  /// In en, this message translates to:
  /// **'Pickup Location'**
  String get pickupLocation;

  /// No description provided for @dropoffLocation.
  ///
  /// In en, this message translates to:
  /// **'Dropoff Location'**
  String get dropoffLocation;

  /// No description provided for @availableSeats.
  ///
  /// In en, this message translates to:
  /// **'Available Seats'**
  String get availableSeats;

  /// No description provided for @tripDetails.
  ///
  /// In en, this message translates to:
  /// **'Trip Details'**
  String get tripDetails;

  /// No description provided for @cancelBooking.
  ///
  /// In en, this message translates to:
  /// **'Cancel Booking'**
  String get cancelBooking;

  /// No description provided for @contactDriver.
  ///
  /// In en, this message translates to:
  /// **'Contact Driver'**
  String get contactDriver;

  /// No description provided for @viewRoute.
  ///
  /// In en, this message translates to:
  /// **'View Route'**
  String get viewRoute;

  /// No description provided for @downloadTicket.
  ///
  /// In en, this message translates to:
  /// **'Download Ticket'**
  String get downloadTicket;

  /// No description provided for @shareTrip.
  ///
  /// In en, this message translates to:
  /// **'Share Trip'**
  String get shareTrip;

  /// No description provided for @cancelBookingTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel Booking'**
  String get cancelBookingTitle;

  /// No description provided for @cancelBookingMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this booking? You will receive a refund according to our cancellation policy.'**
  String get cancelBookingMessage;

  /// No description provided for @keepBooking.
  ///
  /// In en, this message translates to:
  /// **'Keep Booking'**
  String get keepBooking;

  /// No description provided for @confirmCancel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Cancel'**
  String get confirmCancel;

  /// No description provided for @bookingCancelled.
  ///
  /// In en, this message translates to:
  /// **'Booking Cancelled'**
  String get bookingCancelled;

  /// No description provided for @bookingCancelledMessage.
  ///
  /// In en, this message translates to:
  /// **'Your booking has been cancelled successfully. You will receive a refund within 3-5 business days.'**
  String get bookingCancelledMessage;

  /// No description provided for @driverContact.
  ///
  /// In en, this message translates to:
  /// **'Driver Contact'**
  String get driverContact;

  /// No description provided for @callDriver.
  ///
  /// In en, this message translates to:
  /// **'Call Driver'**
  String get callDriver;

  /// No description provided for @messageDriver.
  ///
  /// In en, this message translates to:
  /// **'Message Driver'**
  String get messageDriver;

  /// No description provided for @tripRoute.
  ///
  /// In en, this message translates to:
  /// **'Trip Route'**
  String get tripRoute;

  /// No description provided for @estimatedDuration.
  ///
  /// In en, this message translates to:
  /// **'Estimated Duration'**
  String get estimatedDuration;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// No description provided for @vehicleInfo.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Information'**
  String get vehicleInfo;

  /// No description provided for @driverInfo.
  ///
  /// In en, this message translates to:
  /// **'Driver Information'**
  String get driverInfo;

  /// No description provided for @paymentInfo.
  ///
  /// In en, this message translates to:
  /// **'Payment Information'**
  String get paymentInfo;

  /// No description provided for @paymentStatus.
  ///
  /// In en, this message translates to:
  /// **'Payment Status'**
  String get paymentStatus;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @bookingConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Booking Confirmed'**
  String get bookingConfirmed;

  /// No description provided for @bookingConfirmedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your booking has been confirmed successfully. You can view all trip details here.'**
  String get bookingConfirmedMessage;

  /// No description provided for @pickupReminder.
  ///
  /// In en, this message translates to:
  /// **'Please arrive at the pickup point 5 minutes before departure time'**
  String get pickupReminder;

  /// No description provided for @my_offers.
  ///
  /// In en, this message translates to:
  /// **'My Offers'**
  String get my_offers;

  /// No description provided for @what_happens_next.
  ///
  /// In en, this message translates to:
  /// **'What Happens Next?'**
  String get what_happens_next;

  /// No description provided for @next1_title.
  ///
  /// In en, this message translates to:
  /// **'Students Browse Your Offer'**
  String get next1_title;

  /// No description provided for @next1_sub.
  ///
  /// In en, this message translates to:
  /// **'Your carpool is now visible to all students looking for rides'**
  String get next1_sub;

  /// No description provided for @next2_title.
  ///
  /// In en, this message translates to:
  /// **'Get Booking Notifications'**
  String get next2_title;

  /// No description provided for @next2_sub.
  ///
  /// In en, this message translates to:
  /// **'You\'ll receive instant notifications when someone books a seat'**
  String get next2_sub;

  /// No description provided for @next3_title.
  ///
  /// In en, this message translates to:
  /// **'Complete the Ride'**
  String get next3_title;

  /// No description provided for @next3_sub.
  ///
  /// In en, this message translates to:
  /// **'Pick up passengers and earn money + reward points'**
  String get next3_sub;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @pro_tip.
  ///
  /// In en, this message translates to:
  /// **'Pro Tip'**
  String get pro_tip;

  /// No description provided for @pro_tip_description.
  ///
  /// In en, this message translates to:
  /// **'Be punctual and communicate clearly with your passengers for better ratings and more bookings!'**
  String get pro_tip_description;

  /// No description provided for @cancel_the_trip.
  ///
  /// In en, this message translates to:
  /// **'Cancel The Trip'**
  String get cancel_the_trip;

  /// No description provided for @cancel_trip.
  ///
  /// In en, this message translates to:
  /// **'Cancel Trip'**
  String get cancel_trip;

  /// No description provided for @cancel_trip_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this trip? You will receive a refund according to our cancellation policy.'**
  String get cancel_trip_confirmation;

  /// No description provided for @keep_booking.
  ///
  /// In en, this message translates to:
  /// **'Keep Booking'**
  String get keep_booking;

  /// No description provided for @confirm_cancel.
  ///
  /// In en, this message translates to:
  /// **'Confirm Cancel'**
  String get confirm_cancel;

  /// No description provided for @booking_id.
  ///
  /// In en, this message translates to:
  /// **'Booking ID'**
  String get booking_id;

  /// No description provided for @driver_details.
  ///
  /// In en, this message translates to:
  /// **'Driver Details'**
  String get driver_details;

  /// No description provided for @payment_status.
  ///
  /// In en, this message translates to:
  /// **'Payment Status'**
  String get payment_status;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @pickup_reminder.
  ///
  /// In en, this message translates to:
  /// **'Please arrive at the pickup point 5 minutes before departure time'**
  String get pickup_reminder;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @earned.
  ///
  /// In en, this message translates to:
  /// **'Earned'**
  String get earned;

  /// No description provided for @manageYourAlerts.
  ///
  /// In en, this message translates to:
  /// **'Manage your alerts'**
  String get manageYourAlerts;

  /// No description provided for @controlYourData.
  ///
  /// In en, this message translates to:
  /// **'Control your data'**
  String get controlYourData;

  /// No description provided for @paymentMethods.
  ///
  /// In en, this message translates to:
  /// **'Payment Methods'**
  String get paymentMethods;

  /// No description provided for @manageWithdrawals.
  ///
  /// In en, this message translates to:
  /// **'Manage withdrawals'**
  String get manageWithdrawals;

  /// No description provided for @faqsAndContactUs.
  ///
  /// In en, this message translates to:
  /// **'FAQs and contact us'**
  String get faqsAndContactUs;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get version;

  /// No description provided for @driverActiveStatus.
  ///
  /// In en, this message translates to:
  /// **'Driver • Active'**
  String get driverActiveStatus;

  /// No description provided for @carpoolActiveStatus.
  ///
  /// In en, this message translates to:
  /// **'Carpool • Active'**
  String get carpoolActiveStatus;

  /// No description provided for @walletBalance.
  ///
  /// In en, this message translates to:
  /// **'Wallet Balance'**
  String get walletBalance;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @viewAndEditProfile.
  ///
  /// In en, this message translates to:
  /// **'View and edit profile'**
  String get viewAndEditProfile;

  /// No description provided for @viewTripHistory.
  ///
  /// In en, this message translates to:
  /// **'View trip history'**
  String get viewTripHistory;

  /// No description provided for @rewardsAndPoints.
  ///
  /// In en, this message translates to:
  /// **'Rewards & Points'**
  String get rewardsAndPoints;

  /// No description provided for @noTripsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No trips available'**
  String get noTripsAvailable;

  /// No description provided for @noTripsFound.
  ///
  /// In en, this message translates to:
  /// **'No trips found'**
  String get noTripsFound;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @noPendingApprovals.
  ///
  /// In en, this message translates to:
  /// **'No pending approvals'**
  String get noPendingApprovals;

  /// No description provided for @noStudentsFound.
  ///
  /// In en, this message translates to:
  /// **'No students found'**
  String get noStudentsFound;

  /// No description provided for @noUniversityMembersFound.
  ///
  /// In en, this message translates to:
  /// **'No university members found'**
  String get noUniversityMembersFound;

  /// No description provided for @noDriversFound.
  ///
  /// In en, this message translates to:
  /// **'No drivers found'**
  String get noDriversFound;

  /// No description provided for @scheduleATrip.
  ///
  /// In en, this message translates to:
  /// **'Schedule a Trip'**
  String get scheduleATrip;

  /// No description provided for @scheduleTrip.
  ///
  /// In en, this message translates to:
  /// **'Schedule Trip'**
  String get scheduleTrip;

  /// No description provided for @newTrip.
  ///
  /// In en, this message translates to:
  /// **'New Trip'**
  String get newTrip;

  /// No description provided for @dateAndTime.
  ///
  /// In en, this message translates to:
  /// **'Date & Time'**
  String get dateAndTime;

  /// No description provided for @tripDuration.
  ///
  /// In en, this message translates to:
  /// **'Trip Duration'**
  String get tripDuration;

  /// No description provided for @estimatedTripTime.
  ///
  /// In en, this message translates to:
  /// **'Estimated trip time'**
  String get estimatedTripTime;

  /// No description provided for @howManyPassengers.
  ///
  /// In en, this message translates to:
  /// **'How many passengers can you take?'**
  String get howManyPassengers;

  /// No description provided for @setPriceInILS.
  ///
  /// In en, this message translates to:
  /// **'Set your price in ILS (₪)'**
  String get setPriceInILS;

  /// No description provided for @pleaseSelectDateTime.
  ///
  /// In en, this message translates to:
  /// **'Please select date and time'**
  String get pleaseSelectDateTime;

  /// No description provided for @custom.
  ///
  /// In en, this message translates to:
  /// **'Custom...'**
  String get custom;

  /// No description provided for @publish.
  ///
  /// In en, this message translates to:
  /// **'Publish'**
  String get publish;

  /// No description provided for @start_trip.
  ///
  /// In en, this message translates to:
  /// **'Start Trip'**
  String get start_trip;

  /// No description provided for @start_trip_confirm_title.
  ///
  /// In en, this message translates to:
  /// **'Start this trip?'**
  String get start_trip_confirm_title;

  /// No description provided for @start_trip_confirm_body.
  ///
  /// In en, this message translates to:
  /// **'Your live location will be shared with passengers until you mark the trip as complete.'**
  String get start_trip_confirm_body;

  /// No description provided for @start_trip_action.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start_trip_action;

  /// No description provided for @live.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get live;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @selectTime.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get selectTime;

  /// No description provided for @enterPickupLocation.
  ///
  /// In en, this message translates to:
  /// **'Enter pickup location'**
  String get enterPickupLocation;

  /// No description provided for @enterDropoffLocation.
  ///
  /// In en, this message translates to:
  /// **'Enter dropoff location'**
  String get enterDropoffLocation;

  /// No description provided for @profileMenuSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View and edit profile'**
  String get profileMenuSubtitle;

  /// No description provided for @tripsMenuSubtitle.
  ///
  /// In en, this message translates to:
  /// **'View trip history'**
  String get tripsMenuSubtitle;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Server error'**
  String get serverError;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternetConnection;

  /// No description provided for @connectionTimeout.
  ///
  /// In en, this message translates to:
  /// **'Connection timeout, try again'**
  String get connectionTimeout;

  /// No description provided for @loginNow.
  ///
  /// In en, this message translates to:
  /// **'Login Now'**
  String get loginNow;

  /// No description provided for @bookingFailed.
  ///
  /// In en, this message translates to:
  /// **'Booking Failed'**
  String get bookingFailed;

  /// No description provided for @seatTakenMessage.
  ///
  /// In en, this message translates to:
  /// **'Sorry, this seat was just booked by another student. Please go back and check available seats.'**
  String get seatTakenMessage;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// No description provided for @walletPaymentSoon.
  ///
  /// In en, this message translates to:
  /// **'Wallet payment coming soon!'**
  String get walletPaymentSoon;

  /// No description provided for @confirmingPayment.
  ///
  /// In en, this message translates to:
  /// **'Confirming payment...'**
  String get confirmingPayment;

  /// No description provided for @topUpSuccess.
  ///
  /// In en, this message translates to:
  /// **'Wallet Topped Up!'**
  String get topUpSuccess;

  /// No description provided for @walletHasBeenCharged.
  ///
  /// In en, this message translates to:
  /// **'Your wallet has been charged successfully.'**
  String get walletHasBeenCharged;

  /// No description provided for @backToWallet.
  ///
  /// In en, this message translates to:
  /// **'Back to Wallet'**
  String get backToWallet;

  /// No description provided for @confirmationFailed.
  ///
  /// In en, this message translates to:
  /// **'Confirmation Failed'**
  String get confirmationFailed;

  /// No description provided for @rateDriver.
  ///
  /// In en, this message translates to:
  /// **'Rate Driver'**
  String get rateDriver;

  /// No description provided for @ratingSubmittedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Rating submitted successfully!'**
  String get ratingSubmittedSuccess;

  /// No description provided for @noAchievementsFound.
  ///
  /// In en, this message translates to:
  /// **'No achievements found.'**
  String get noAchievementsFound;

  /// No description provided for @referralCopied.
  ///
  /// In en, this message translates to:
  /// **'Referral code copied to clipboard!'**
  String get referralCopied;

  /// No description provided for @rewardRedeemedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Reward redeemed successfully!'**
  String get rewardRedeemedSuccess;

  /// No description provided for @profileMenuItem.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileMenuItem;

  /// No description provided for @enterAmountILS.
  ///
  /// In en, this message translates to:
  /// **'Enter amount (ILS)'**
  String get enterAmountILS;

  /// No description provided for @topUpAction.
  ///
  /// In en, this message translates to:
  /// **'Top-up'**
  String get topUpAction;

  /// No description provided for @failedToGetTripId.
  ///
  /// In en, this message translates to:
  /// **'Failed to get trip ID'**
  String get failedToGetTripId;

  /// No description provided for @profilePictureUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile picture updated!'**
  String get profilePictureUpdated;

  /// No description provided for @refundAutoMessage.
  ///
  /// In en, this message translates to:
  /// **'The full amount will be automatically refunded'**
  String get refundAutoMessage;

  /// No description provided for @refundWalletSuccess.
  ///
  /// In en, this message translates to:
  /// **'Cancelled — ₪{amount} refunded to your wallet'**
  String refundWalletSuccess(String amount);

  /// No description provided for @refundStripeSuccess.
  ///
  /// In en, this message translates to:
  /// **'Cancelled — Your amount will be returned to your card within 3-5 days'**
  String get refundStripeSuccess;

  /// No description provided for @cancelledSuccess.
  ///
  /// In en, this message translates to:
  /// **'Booking cancelled successfully'**
  String get cancelledSuccess;

  /// No description provided for @myReviews.
  ///
  /// In en, this message translates to:
  /// **'My Reviews'**
  String get myReviews;

  /// No description provided for @noReviewsYet.
  ///
  /// In en, this message translates to:
  /// **'No reviews yet'**
  String get noReviewsYet;

  /// No description provided for @reviewsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Reviews'**
  String reviewsCount(int count);

  /// No description provided for @gpsConnecting.
  ///
  /// In en, this message translates to:
  /// **'Connecting...'**
  String get gpsConnecting;

  /// No description provided for @gpsConnectionFailed.
  ///
  /// In en, this message translates to:
  /// **'Connection failed'**
  String get gpsConnectionFailed;

  /// No description provided for @gpsWaitingForDriver.
  ///
  /// In en, this message translates to:
  /// **'Waiting for driver...'**
  String get gpsWaitingForDriver;

  /// No description provided for @gpsLive.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get gpsLive;

  /// No description provided for @trackTrip.
  ///
  /// In en, this message translates to:
  /// **'Track Trip'**
  String get trackTrip;

  /// No description provided for @timeMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}m ago'**
  String timeMinutesAgo(int count);

  /// No description provided for @timeHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}h ago'**
  String timeHoursAgo(int count);

  /// No description provided for @timeDaysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}d ago'**
  String timeDaysAgo(int count);

  /// No description provided for @timeWeeksAgo.
  ///
  /// In en, this message translates to:
  /// **'{count}w ago'**
  String timeWeeksAgo(int count);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
