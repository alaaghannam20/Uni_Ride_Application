// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/widgets/language_button.dart';

class Onboarding1Screen extends StatelessWidget {
  const Onboarding1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.transparent,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/onboarding1.png',
              fit: BoxFit.fitHeight,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 45, right: 24),
            child: Align(
              alignment: Alignment.topRight,
              child: LanguageButton(),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 40,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 56,
                    width: double.infinity,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          Routes.mainOnboarding,
                          arguments: {'withFade': true},
                        );
                      },
                      child: Container(
                        decoration: ShapeDecoration(
                          color: const Color(0x33FFFFFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Get Started',
                              style: TextStyle(
                                color: AppColors.orangeprimary,
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                height: 1.20,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward,
                              color: AppColors.orangeprimary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),


                  SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Powered by ',
                          style: TextStyle(
                            color: AppColors.languagecolor,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'PTUK Engineering',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}