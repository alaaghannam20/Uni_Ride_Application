import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/widgets/custom_button.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/custom_card_container.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/tobBar_regestration_widget.dart';

class PasswordChangedScreen extends StatefulWidget {
  const PasswordChangedScreen({super.key});

  @override
  State<PasswordChangedScreen> createState() => _PasswordChangedScreenState();
}

class _PasswordChangedScreenState extends State<PasswordChangedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            TobbarRegestrationWidget(
              title: 'Password Changed',
              onBackPressed: () {
                Navigator.pop(context);
              },
            ),
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
                                'Password Changed!',
                                style: AppStyle.custombuttonstyle.copyWith(
                                  fontSize: 25,
                                  color: AppColors.skiptextcolor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Your password has been \n changed successfully',
                                style: AppStyle.accountQuestionStyle,
                                textAlign: TextAlign.center,
                              ),
                    
                              SizedBox(height: 30),
                              SizedBox(
                                height: 56,
                                child: CustomButton(
                                  text: 'Finish!',
                                  backgroundColor: AppColors.orangeprimary,
                                  onPressed: () {},
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
