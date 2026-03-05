import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/widgets/circle_arrow_button.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/widget/onboarding_widget.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/widget/tobBar_widget.dart';


class Onboarding2Screen extends StatelessWidget {
  const Onboarding2Screen({super.key});

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth  = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,

      body: SafeArea(
        child: Padding(

          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * (32 / 430),
          ),

          child: Column(
            children: [

              const TobBarWidget(),

              SizedBox(height: screenHeight * 0.068),

              const Expanded(
                child: OnboardingWidget(
                  image: 'assets/images/onboarding2.png',
                  title: 'Book • Track • Arrive',
                  description:
                      'Seamless booking, real-time tracking, and reliable transport for every university day.',
                ),
              ),

              SizedBox(height: screenHeight * (80 / 932)),

              CircleArrowButton(
                progress: 0.66,
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.onboarding3,
                  );
                },
                child: const Icon(
                  Icons.arrow_forward,
                  color: AppColors.white,
                  size: 30,
                ),
              ),

              SizedBox(height: screenHeight * 0.10),

            ],
          ),
        ),
      ),
    );
  }
}