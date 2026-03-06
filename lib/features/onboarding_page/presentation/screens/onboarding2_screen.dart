import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/widgets/circle_arrow_button.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/widget/onboarding_widget.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/widget/tobbar_widget.dart';

class Onboarding2Screen extends StatefulWidget {
  const Onboarding2Screen({super.key});

  @override
  State<Onboarding2Screen> createState() => _Onboarding2ScreenState();
}

class _Onboarding2ScreenState extends State<Onboarding2Screen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            TobBarWidget(),
            SizedBox(height: 40),

            const OnboardingWidget(
              image: 'assets/images/onboarding2.png',
              title: 'Smart Campus Transportation',
              description:
                  'Seamless booking, real-time tracking, and reliable transport for every university day.',
            ),

            SizedBox(height: 0),

            Center(
              child: CircleArrowButton(
                progress: 0.33,
                onPressed: () {
                  Navigator.pushNamed(context, Routes.onboarding3);
                },
                child: Icon(
                  Icons.arrow_forward,
                  color: AppColors.white,
                  size: 30,
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
