import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/widgets/custom_button.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class PasswordChangedScreen extends StatelessWidget {
  const PasswordChangedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
          
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: 70,
                  horizontal: 22,
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 332,
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/check pass.png',
                                width: 150,
                                height: 150,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(height: 13),
                              Text(
                                AppLocalizations.of(context)!.passwordChanged,
                                style: AppStyle.custombuttonstyle.copyWith(
                                  fontSize: 25,
                                  color: AppColors.skiptextcolor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 12),
                              Text(
                                AppLocalizations.of(context)!.passwordChangedSuccess,
                                style: AppStyle.accountQuestionStyle,
                                textAlign: TextAlign.center,
                              ),

                              SizedBox(height: 30),
                              SizedBox(
                                height: 56,
                                child: CustomButton(
                                  text: AppLocalizations.of(context)!.finish,
                                  backgroundColor: AppColors.orangeprimary,
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      Routes.signIn,
                                      (route) => false,
                                    );
                                  },
                                  textColor: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
