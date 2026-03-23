import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/storage/app_prefs.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/widgets/custom_button.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/custom_card_container.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/otp_pin_field_widget.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/powered_by_widget.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/tobBar_regestration_widget.dart';

class OtbVerificationScreen extends StatefulWidget {
  final String email;
  const OtbVerificationScreen({super.key, required this.email});

  @override
  State<OtbVerificationScreen> createState() => _OtbVerificationScreenState();
}

class _OtbVerificationScreenState extends State<OtbVerificationScreen> {
  String otpCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            TobbarRegestrationWidget(
              title: 'OTP Verification',
              onBackPressed: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 22,
                ),
                child: Column(
                  children: [
                    CustomCardContainer(
                      child: Column(
                        children: [
                          SizedBox(
                            width: 303,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Enter Verification Code',
                                  style: AppStyle.custombuttonstyle.copyWith(
                                    height: 24 / 18,
                                    color: AppColors.skiptextcolor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "We've sent a 4-digit code to",
                                  style: AppStyle.accountQuestionStyle,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  widget.email,
                                  style: AppStyle.loginNowStyle.copyWith(
                                    color: AppColors.skiptextcolor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          OtpPinFieldWidget(
                            onChanged: (value) {
                              otpCode = value;
                            },
                            onCompleted: (value) {
                              otpCode = value;
                            },
                          ),

                          const SizedBox(height: 12),

                          RichText(
                            text: TextSpan(
                              text: 'Resend code in ',
                              style: AppStyle.accountQuestionStyle,
                              children: [
                                TextSpan(
                                  text: '50s',
                                  style: AppStyle.loginNowStyle.copyWith(
                                    color: AppColors.orangeprimary,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          SizedBox(
                            height: 56,
                            child: CustomButton(
                              text: 'Verify',
                              backgroundColor: AppColors.orangeprimary,
                              onPressed: () async {
                                if (otpCode.length == 4) {
                                  // API 
                                  String fakeToken = "123456_token";

                                  await AppPrefs.setToken(fakeToken);

                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    Routes.home,
                                    (route) => false,
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Enter the 4 digit code'),
                                    ),
                                  );
                                }
                              },
                              textColor: AppColors.white,
                            ),
                          ),

                          const SizedBox(height: 24),

                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Change Email Address',
                              textAlign: TextAlign.center,
                              style: AppStyle.loginNowStyle.copyWith(
                                color: AppColors.languagecolor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    const PoweredByWidget(),
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
