import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/storage/app_prefs.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/widgets/circle_arrow_button.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/widget/onboarding_widget.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/widget/tobbar_widget.dart';

class Onboarding4Screen extends StatelessWidget {
  const Onboarding4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            TobBarWidget(showSkip: false),

            SizedBox(height: 40),

            const OnboardingWidget(
              image: 'assets/images/onboarding3.png',
              title: 'Connected Rides, be \nConnected',
              description:
                  'Choose your ride, set your schedule, and enjoy hassle-free campus transportation.',
            ),

            SizedBox(height: 80),

            CircleArrowButton(
              progress: 1.0,
              onPressed: () async {
                await AppPrefs.setSeenOnboarding(true);
                if (!context.mounted) return;

                Navigator.pushReplacementNamed(context, Routes.signUp);
              },
              child: const Text(
                'Go',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.30,
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.15),
          ],
        ),
      ),
    );
  }
}
