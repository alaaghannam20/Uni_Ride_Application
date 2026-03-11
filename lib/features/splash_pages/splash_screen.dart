import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/storage/app_prefs.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    final seenOnboarding = AppPrefs.getSeenOnboarding();
    final isLoggedIn = AppPrefs.getIsLoggedIn();

    if (!mounted) return;

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, Routes.home);
    } else if (!seenOnboarding) {
      Navigator.pushReplacementNamed(context, Routes.onboarding1);
    } else {
      Navigator.pushReplacementNamed(context, Routes.signUp);
    }
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
