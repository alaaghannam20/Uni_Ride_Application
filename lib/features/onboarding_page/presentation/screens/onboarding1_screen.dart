import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/widgets/circle_arrow_button.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/widget/onboarding_widget.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/widget/tobBar_widget.dart';

class Onboarding1Screen extends StatefulWidget {
  const Onboarding1Screen({super.key});

  @override
  State<Onboarding1Screen> createState() => _Onboarding1ScreenState();
}

class _Onboarding1ScreenState extends State<Onboarding1Screen> {
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
              image: 'assets/images/onboarding1.png',
              title: 'Smart Campus Transportation',
              description:
                  'Seamless booking, real-time tracking, and reliable transport for every university day.',
            ),

            SizedBox(height: 0),

            Center(
              child: CircleArrowButton(
                progress: 0.33,
                onPressed: () {
                  Navigator.pushNamed(context, Routes.onboarding2);
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
