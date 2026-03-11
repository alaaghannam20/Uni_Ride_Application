import 'package:flutter/material.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/widget/onboarding_widget.dart';

class Onboarding4Screen extends StatelessWidget {
  const Onboarding4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingWidget(
      image: 'assets/images/onboarding4.png',
      title: 'Connected Rides, be \nConnected',
      description:
          'Choose your ride, set your schedule, and enjoy hassle-free campus transportation.',
    );
  }
}
