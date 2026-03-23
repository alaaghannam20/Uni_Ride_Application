import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/widgets/custom_button.dart';
import 'package:uni_ride_application/core/widgets/custom_textfiled.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/custom_card_container.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/powered_by_widget.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/tobBar_regestration_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController newpasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    newpasswordController.dispose();
    confirmPasswordController.dispose();
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
              title: 'Reset password',
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextfiled(
                            controller: newpasswordController,
                            labelText: 'New Password',
                            hintText: '• • • • • • • •',
                            isPassword: true,
                            prefixIcon: const Icon(
                              Icons.lock,
                              size: 22,
                              color: AppColors.languagecolor,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            'Minimum 8 characters',
                            style: AppStyle.hintstyle.copyWith(fontSize: 9),
                          ),
                          const SizedBox(height: 22),

                          CustomTextfiled(
                            controller: confirmPasswordController,
                            labelText: 'Confirm Password',
                            hintText: '• • • • • • • •',
                            isPassword: true,
                            prefixIcon: const Icon(
                              Icons.lock,
                              size: 22,
                              color: AppColors.languagecolor,
                            ),
                          ),
                          const SizedBox(height: 26),
                          SizedBox(
                            height: 56,
                            child: CustomButton(
                              text: 'Reset password',
                              backgroundColor: AppColors.orangeprimary,
                              onPressed: () {
                                if (newpasswordController.text.length < 8) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Minimum 8 characters'),
                                    ),
                                  );
                                  return;
                                }

                                if (newpasswordController.text !=
                                    confirmPasswordController.text) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Passwords do not match'),
                                    ),
                                  );
                                  return;
                                }

                                Navigator.pushNamed(
                                  context,
                                  Routes.passwordChanged,
                                );
                              },
                              textColor: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),
                    PoweredByWidget(),
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
