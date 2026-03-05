import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/widgets/circle_arrow_button.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/widget/onboarding_widget.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/widget/tobbar_widget.dart';

class Onboarding3Screen extends StatelessWidget {
  const Onboarding3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.white,

      body: SafeArea(
        child: Column(
          children: [
            const TobBarWidget(),

            SizedBox(height: 40),

            OnboardingWidget(
              image: 'assets/images/onboarding2.png',
              title: 'Book • Track • Arrive',
              description:
                  'Seamless booking, real-time tracking, and reliable transport for every university day.',
            ),

            SizedBox(height: 80),

            CircleArrowButton(
              progress: 0.66,
              onPressed: () {
                Navigator.pushNamed(context, Routes.onboarding4);
              },
              child: const Icon(
                Icons.arrow_forward,
                color: AppColors.white,
                size: 30,
              ),
            ),

            SizedBox(height: screenHeight * 0.15),
          ],
        ),
      ),
    );
  }
}
