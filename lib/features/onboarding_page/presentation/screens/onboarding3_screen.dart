import 'package:flutter/material.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/widget/onboarding_widget.dart';

class Onboarding3Screen extends StatelessWidget {
  const Onboarding3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingWidget(
      image: 'assets/images/onboarding3.png',
      title: 'Book • Track • Arrive',
      description:
          'Seamless booking, real-time tracking, and reliable transport for every university day.',
    );
  }
}
