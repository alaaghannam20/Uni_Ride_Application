import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/storage/app_prefs.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/widgets/circle_arrow_button.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/widget/onboarding_widget.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/widget/tobBar_widget.dart';

class Onboarding3Screen extends StatelessWidget {
  const Onboarding3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final contentW = screenWidth * (343 / 430);

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 0),
              child: TobBarWidget(showSkip: false),
            ),

            SizedBox(height: screenHeight * 0.068),

            Expanded(
              child: Center(
                child: SizedBox(
                  width: contentW,
                  child: const OnboardingWidget(
                    image: 'assets/images/onboarding3.png',
                    title: 'Connected Rides, be \nConnected',
                    description:
                        'Choose your ride, set your schedule, and enjoy hassle-free campus transportation.',
                  ),
                ),
              ),
            ),

            SizedBox(height: screenHeight * (80 / 932)),

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
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.30,
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.10),
          ],
        ),
      ),
    );
  }
}
