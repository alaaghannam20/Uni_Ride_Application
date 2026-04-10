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
import 'package:uni_ride_application/features/admin/pages/admin_settings_page.dart';

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
          builder: (_) =>
              const Scaffold(body: Center(child: Text("  HomeScreen here"))),
        );

      case Routes.adminOverview:
        return MaterialPageRoute(
          builder: (_) => const AdminOverviewPage(),
        );

      case Routes.adminPendingApprovals:
        return MaterialPageRoute(
          builder: (_) => const AdminPendingApprovalsPage(),
        );

      case Routes.adminDrivers:
        return MaterialPageRoute(
          builder: (_) => const AdminDriversPage(),
        );

      case Routes.adminStudents:
        return MaterialPageRoute(
          builder: (_) => const AdminStudentsPage(),
        );

      case Routes.adminTrips:
        return MaterialPageRoute(
          builder: (_) => const AdminTripsPage(),
        );

      case Routes.adminSettings:
        return MaterialPageRoute(
          builder: (_) => const AdminSettingsPage(),
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
