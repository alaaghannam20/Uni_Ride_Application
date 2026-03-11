import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/screens/main_onboarding.dart';

import 'package:uni_ride_application/features/splash_pages/splash_screen.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/screens/onboarding1_screen.dart';

import 'package:uni_ride_application/features/onboarding_page/presentation/screens/onboarding2_screen.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/screens/onboarding3_screen.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/screens/onboarding4_screen.dart';

import 'package:uni_ride_application/features/regestration_pages/presentation/screens/signup_uni_screen.dart';

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

      case Routes.signUp:
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

      case Routes.home:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("  HomeScreen here"))),
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
