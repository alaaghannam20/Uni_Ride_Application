import 'package:flutter/material.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/widget/onboarding_widget.dart';

class Onboarding2Screen extends StatelessWidget {
  const Onboarding2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingWidget(
      image: 'assets/images/onboarding2.png',
      title: 'Smart Campus Transportation',
      description:
          'Seamless booking, real-time tracking, and reliable transport for every university day.',
    );
  }
}
