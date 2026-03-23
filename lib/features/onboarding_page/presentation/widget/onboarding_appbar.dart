import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/widgets/language_button.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class OnboardingAppbar extends StatelessWidget {
  final bool showSkip;
  const OnboardingAppbar({super.key, required this.showSkip});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.white,
      elevation: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            if (showSkip)
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.signUp);
                },
                child: Text(
                  AppLocalizations.of(context)!.skip,
                  style: AppStyle.skipstyle,
                ),
              ),
            Spacer(),
            LanguageButton(),
          ],
        ),
      ),
    );
  }
}
