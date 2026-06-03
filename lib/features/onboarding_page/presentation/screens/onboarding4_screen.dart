import 'package:flutter/material.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/widget/onboarding_widget.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class Onboarding4Screen extends StatelessWidget {
  const Onboarding4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingWidget(
      image: 'assets/images/onboarding4.png',
      title: AppLocalizations.of(context)!.onboarding4Title,
      description: AppLocalizations.of(context)!.onboardingDescription,
    );
  }
}
