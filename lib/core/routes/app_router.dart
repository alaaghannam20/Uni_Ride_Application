import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/screens/main_onboarding.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/screens/code_verification_screen.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/screens/forget_password_screen.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/screens/otb_verification_screen.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/screens/password_changed_screen.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/screens/reset_password_screen.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/screens/sign_in_screen.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/screens/signup_driver.dart';

import 'package:uni_ride_application/features/splash_pages/splash_screen.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/screens/onboarding1_screen.dart';

import 'package:uni_ride_application/features/regestration_pages/presentation/screens/signup_uni_screen.dart';
import 'package:uni_ride_application/features/admin/pages/admin_overview_page.dart';
import 'package:uni_ride_application/features/admin/pages/admin_pending_approvals_page.dart';
import 'package:uni_ride_application/features/admin/pages/admin_drivers_page.dart';
import 'package:uni_ride_application/features/admin/pages/admin_students_page.dart';
import 'package:uni_ride_application/features/admin/pages/admin_trips_page.dart';
import 'package:uni_ride_application/features/admin/pages/admin_driver_details_page.dart';
import 'package:uni_ride_application/features/admin/pages/admin_settings_page.dart';
import 'package:uni_ride_application/features/payment/pages/payment_page.dart';
import 'package:uni_ride_application/features/payment/pages/my_wallet_page.dart';
import 'package:uni_ride_application/features/rating/pages/rate_driver_page.dart';
import 'package:uni_ride_application/features/profile_memberuni/pages/profile_member_uni_page.dart';
import 'package:uni_ride_application/features/home_page/presentation/screens/home_screen.dart';
import 'package:uni_ride_application/features/home_page/presentation/screens/all_available_trips_screen.dart';
import 'package:uni_ride_application/features/home_page/presentation/screens/offer_carpool_screen.dart';
import 'package:uni_ride_application/features/home_page/presentation/screens/preview_carpool_screen.dart';
import 'package:uni_ride_application/features/home_page/presentation/screens/offer_confirmation_screen.dart';
import 'package:uni_ride_application/features/driver/presentation/screens/driver_home_screen.dart';
import 'package:uni_ride_application/features/driver/presentation/screens/create_trip_screen.dart';
import 'package:uni_ride_application/features/carpool/carpool_profile_screen.dart';
import 'package:uni_ride_application/features/driver/driver_profile_screen.dart';
import 'package:uni_ride_application/features/trip_details/presentation/screens/trip_details_screen.dart';
import 'package:uni_ride_application/features/trip_details/presentation/screens/booking_confirmed_screen.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final bool withFade =
        (settings.arguments is Map &&
            (settings.arguments as Map).containsKey('withFade'))
        ? (settings.arguments as Map)['withFade'] == true
        : false;

    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.onboarding1:
        return MaterialPageRoute(builder: (_) => const Onboarding1Screen());

      case Routes.mainOnboarding:
        return withFade
            ? PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                pageBuilder: (_, animation, _) => const MainOnboarding(),
                transitionsBuilder: (_, animation, _, child) => FadeTransition(
                  opacity: CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeOut,
                  ),
                  child: child,
                ),
              )
            : MaterialPageRoute(builder: (_) => const MainOnboarding());

      case Routes.signUpUni:
        return PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1200),
          pageBuilder: (_, _, _) => SignupUniScreen(),
          transitionsBuilder: (_, animation, _, child) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: animation, curve: Curves.linear));
            return SlideTransition(position: offsetAnimation, child: child);
          },
        );

      case Routes.signUpDriver:
        return PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1200),
          pageBuilder: (_, _, _) => SignUpDriverScreen(),
          transitionsBuilder: (_, animation, _, child) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: animation, curve: Curves.linear));
            return SlideTransition(position: offsetAnimation, child: child);
          },
        );

      case Routes.OtbVerification:
        final email = settings.arguments as String;
        return PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1200),
          pageBuilder: (_, _, _) => OtbVerificationScreen(email: email),
          transitionsBuilder: (_, animation, _, child) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: animation, curve: Curves.linear));
            return SlideTransition(position: offsetAnimation, child: child);
          },
        );

      case Routes.signIn:
        return PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1200),
          pageBuilder: (_, _, _) => SignInScreen(),
          transitionsBuilder: (_, animation, _, child) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: animation, curve: Curves.linear));
            return SlideTransition(position: offsetAnimation, child: child);
          },
        );

      case Routes.forgetPassword:
        return PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1200),
          pageBuilder: (_, _, _) => ForgetPasswordScreen(),
          transitionsBuilder: (_, animation, _, child) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: animation, curve: Curves.linear));
            return SlideTransition(position: offsetAnimation, child: child);
          },
        );
      case Routes.codeVerification:
        final email = settings.arguments as String;
        return PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1200),
          pageBuilder: (_, _, _) => CodeVerificationScreen(email: email),
          transitionsBuilder: (_, animation, _, child) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: animation, curve: Curves.linear));
            return SlideTransition(position: offsetAnimation, child: child);
          },
        );

      case Routes.passwordChanged:
        return PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1200),
          pageBuilder: (_, _, _) => PasswordChangedScreen(),
          transitionsBuilder: (_, animation, _, child) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: animation, curve: Curves.linear));
            return SlideTransition(position: offsetAnimation, child: child);
          },
        );

      case Routes.resetPassword:
        final args = settings.arguments as Map<String, String>;
        return PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1200),
          pageBuilder: (_, _, _) => ResetPasswordScreen(
            email: args['email']!,
            otpCode: args['otpCode']!,
          ),
          transitionsBuilder: (_, animation, _, child) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: animation, curve: Curves.linear));
            return SlideTransition(position: offsetAnimation, child: child);
          },
        );

      case Routes.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const HomeScreen(),
        );

      case Routes.adminOverview:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const AdminOverviewPage(),
        );

      case Routes.adminPendingApprovals:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const AdminPendingApprovalsPage(),
        );

      case Routes.adminDrivers:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const AdminDriversPage(),
        );

      case Routes.adminStudents:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const AdminStudentsPage(),
        );

      case Routes.adminTrips:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const AdminTripsPage(),
        );

      case Routes.adminSettings:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const AdminSettingsPage(),
        );

      case Routes.adminDriverDetails:
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => AdminDriverDetailsPage(id: args['id']!, type: args['type']!),
        );

      case Routes.payment:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const PaymentPage(),
        );

      case Routes.myWallet:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const MyWalletPage(),
        );

      case Routes.rateDriver:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => RateDriverPage(
            bookingId: args['bookingId'],
            driverName: args['driverName'] ?? 'Ali M.',
          ),
        );

      case Routes.profile:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const ProfilePage(),
        );

      case Routes.allAvailableTrips:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const AllAvailableTripsScreen(),
        );
      case Routes.offerCarpool:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const OfferCarpoolScreen(),
        );
      case Routes.previewCarpool:
        final args = settings.arguments as Map<String, dynamic>? ?? {
          'pickupLocation': 'PTUK Main Gate',
          'dropoffLocation': 'Engineering Building',
          'date': '2024-05-20',
          'time': '08:30 AM',
          'availableSeats': 3,
          'pricePerSeat': 8,
        };
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => PreviewCarpoolScreen(
            pickupLocation: args['pickupLocation'],
            dropoffLocation: args['dropoffLocation'],
            date: args['date'],
            time: args['time'],
            availableSeats: args['availableSeats'],
            pricePerSeat: args['pricePerSeat'],
          ),
        );
      case Routes.offerConfirmation:
        final args = settings.arguments as Map<String, dynamic>? ?? {
          'pickupLocation': 'PTUK Main Gate',
          'dropoffLocation': 'Engineering Building',
          'date': '2024-05-20',
          'time': '08:30 AM',
          'availableSeats': 3,
          'pricePerSeat': 8,
        };
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => OfferConfirmationScreen(
            pickupLocation: args['pickupLocation'],
            dropoffLocation: args['dropoffLocation'],
            date: args['date'],
            time: args['time'],
            availableSeats: args['availableSeats'],
            pricePerSeat: args['pricePerSeat'],
          ),
        );
      case Routes.driverhome:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const DriverHomeScreen(),
        );
      case Routes.createTrip:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const CreateTripScreen(),
        );
      case Routes.driverprofile:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const DriverProfileScreen(),
        );
      case Routes.carpoolProfile:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const CarpoolProfileScreen(),
        );
      case Routes.tripDetails:
        final tripId = settings.arguments as int;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => TripDetailsScreen(tripId: tripId),
        );
      case Routes.bookingConfirmed:
        final sessionId = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BookingConfirmedScreen(sessionId: sessionId),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text("Route Not Found: ${settings.name}")),
          ),
        );
    }
  }
}
