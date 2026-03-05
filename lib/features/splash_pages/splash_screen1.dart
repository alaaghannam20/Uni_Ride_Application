import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/storage/app_prefs.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({super.key});

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 3));

    final seenOnboarding = AppPrefs.getSeenOnboarding();
    final seenSplash2 = AppPrefs.getSeenSplash2();
    final isLoggedIn = AppPrefs.getIsLoggedIn();

    if (!mounted) return;

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, Routes.home);
      return;
    }

      if (!seenSplash2) {
      Navigator.pushReplacementNamed(context, Routes.splash2);
      return;
    }

    if (!seenOnboarding) {
      Navigator.pushReplacementNamed(context, Routes.onboarding1);
      return;
    }
    Navigator.pushReplacementNamed(context, Routes.signUp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orangeprimary,
      body: Center(
        child: Image.asset(
          'assets/images/logo1.png',
          width: MediaQuery.of(context).size.width * 0.35,
        ),
      ),
    );
  }
}
