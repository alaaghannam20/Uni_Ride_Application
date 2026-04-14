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

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

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

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark mode'**
  String get darkMode;
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
