import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/storage/app_prefs.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/widgets/circle_arrow_button.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/screens/onboarding2_screen.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/screens/onboarding3_screen.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/screens/onboarding4_screen.dart';
import 'package:uni_ride_application/features/onboarding_page/presentation/widget/onboarding_appbar.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class MainOnboarding extends StatefulWidget {
  const MainOnboarding({super.key});

  @override
  State<MainOnboarding> createState() => _MainOnboardingState();
}

class _MainOnboardingState extends State<MainOnboarding> {
  final PageController pageController = PageController();
  int currentPage = 0;
  double get progress => (currentPage + 1) / onboardingPages.length;

  final List<Widget> onboardingPages = const [
    Onboarding2Screen(),
    Onboarding3Screen(),
    Onboarding4Screen(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          children: [
            const SizedBox(height: 35),

            OnboardingAppbar(
              showSkip: currentPage != onboardingPages.length - 1,
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                reverse: false,
                allowImplicitScrolling: false,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: onboardingPages,
              ),
            ),
            Center(
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: progress),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                builder: (context, animatedProgress, child) {
                  return CircleArrowButton(
                    progress: animatedProgress,
                    onPressed: () async {
                      if (currentPage < onboardingPages.length - 1) {
                        pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        await AppPrefs.setSeenOnboarding(true);
                        if (!context.mounted) return;
                        Navigator.pushNamedAndRemoveUntil(context, Routes.signIn, (route) => false);
                      }
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                        );
                      },
                      child: currentPage == onboardingPages.length - 1
                          ? Text(
                              AppLocalizations.of(context)!.go,
                              key: ValueKey('go'),
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.30,
                              ),
                            )
                          : Icon(
                              isArabic ? Icons.arrow_forward : Icons.arrow_forward,
                              key: ValueKey(isArabic),
                              color: AppColors.white,
                              size: 30,
                            ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: screenHeight * 0.14),
          ],
        ),
      ),
    );
  }
}
