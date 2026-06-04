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
    final token = AppPrefs.getToken();

   if (!mounted) return;

  if (!seenOnboarding) {
    Navigator.pushReplacementNamed(context, Routes.onboarding1);
  } else {
    if (token != null && token.isNotEmpty) {
      final userType = AppPrefs.getUserType();
      switch (userType) {
        case 'admin':
          Navigator.pushReplacementNamed(context, Routes.adminOverview);
          break;
        case 'driver':
          Navigator.pushReplacementNamed(context, Routes.driverhome);
          break;
        case 'carpool':
          Navigator.pushReplacementNamed(context, Routes.home);
          break;
        default:
          Navigator.pushReplacementNamed(context, Routes.home);
      }
    } else {
      Navigator.pushReplacementNamed(context, Routes.signIn);
    }
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
