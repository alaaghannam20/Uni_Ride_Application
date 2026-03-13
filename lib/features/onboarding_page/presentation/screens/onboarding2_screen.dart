import 'package:flutter/material.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/widget/onboarding_widget.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class Onboarding2Screen extends StatelessWidget {
  const Onboarding2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingWidget(
      image: 'assets/images/onboarding2.png',
      title: AppLocalizations.of(context)!.onboarding2Title,
      description: AppLocalizations.of(context)!.onboardingDescription,
    );
  }
}
