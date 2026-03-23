import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/widgets/custom_button.dart';
import 'package:uni_ride_application/core/widgets/custom_textfiled.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/custom_card_container.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/powered_by_widget.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/tobBar_regestration_widget.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailOrPhoneController = TextEditingController();

  @override
  void dispose() {
    emailOrPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            TobbarRegestrationWidget(
              title: 'Forget Password',
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
                          SizedBox(height: 30),
                          Text(
                            'Enter your email \n to reset your password',
                            style: AppStyle.hintstyle.copyWith(
                              color: AppColors.titlecolor,
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 40),
                          CustomTextfiled(
                            controller: emailOrPhoneController,
                            labelText: 'Email ',
                            hintText: 'a.m.ghannam@student.ptuk.edu.ps',
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: const Icon(
                              Icons.email,
                              size: 22,
                              color: AppColors.languagecolor,
                            ),
                          ),
                          const SizedBox(height: 30),
                          CustomButton(
                            text: 'Send code',
                            backgroundColor: AppColors.orangeprimary,
                            onPressed: () {
                              if (emailOrPhoneController.text.isNotEmpty) {
                                Navigator.pushNamed(
                                  context,
                                  Routes.codeVerification,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Enter your email'),
                                  ),
                                );
                              }
                            },
                            textColor: AppColors.white,
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
