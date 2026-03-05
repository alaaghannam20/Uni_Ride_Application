import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/routes/routes.dart';

import 'package:uni_ride_application/features/splash_pages/splash_screen1.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/screens/splash_screen2.dart';

import 'package:uni_ride_application/features/onboarding_page/presentation/screens/onboarding1_screen.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/screens/onboarding2_screen.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/screens/onboarding3_screen.dart';

import 'package:uni_ride_application/features/signup_pages/presentation/screens/signup_uni_screen.dart';



class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final bool withFade =
        (settings.arguments is Map &&
                (settings.arguments as Map).containsKey('withFade'))
            ? (settings.arguments as Map)['withFade'] == true
            : false;

    switch (settings.name) {
      case Routes.splash1:
        return MaterialPageRoute(builder: (_) => const SplashScreen1());

      case Routes.splash2:
        return MaterialPageRoute(builder: (_) => const Splash02Screen());

      case Routes.onboarding1:
        return withFade
            ? PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                pageBuilder: (_, animation, __) => const Onboarding1Screen(),
                transitionsBuilder: (_, animation, __, child) => FadeTransition(
                  opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
                  child: child,
                ),
              )
            : MaterialPageRoute(builder: (_) => const Onboarding1Screen());

      case Routes.onboarding2:
        return PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (_, __, ___) => const Onboarding2Screen(),
          transitionsBuilder: (_, animation, __, child) => FadeTransition(
            opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
            child: child,
          ),
        );

      case Routes.onboarding3:
        return withFade
            ? PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 300),
                pageBuilder: (_, __, ___) => const Onboarding3Screen(),
                transitionsBuilder: (_, animation, __, child) => FadeTransition(
                  opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
                  child: child,
                ),
              )
            : MaterialPageRoute(builder: (_) => const Onboarding3Screen());

      case Routes.signUp:
        return PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1200),
          pageBuilder: (_, __, ___) => SignupUniScreen(),
          transitionsBuilder: (_, animation, __, child) {
            final offsetAnimation = Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: animation, curve: Curves.linear));
            return SlideTransition(position: offsetAnimation, child: child);
          },
        );


      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("TODO: Put HomeScreen here")),
          ),
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