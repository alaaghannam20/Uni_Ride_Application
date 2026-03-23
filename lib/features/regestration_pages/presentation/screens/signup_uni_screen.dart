import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/widgets/custom_button.dart';
import 'package:uni_ride_application/core/widgets/custom_textfiled.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/screens/otb_verification_screen.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/screens/signup_driver.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/custom_card_container.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/powered_by_widget.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/role_toggle_widget.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/tobBar_regestration_widget.dart';

class SignupUniScreen extends StatefulWidget {
  const SignupUniScreen({super.key});

  @override
  State<SignupUniScreen> createState() => _SignupUniScreenState();
}

class _SignupUniScreenState extends State<SignupUniScreen> {
  bool isStudDocSelected = true;
  final TextEditingController uniEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    uniEmailController.dispose();
    passwordController.dispose();
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
              title: 'Sign Up',
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
                          RoleToggleWidget(
                            isStudDocSelected: isStudDocSelected,
                            onStudentTap: () {
                              setState(() {
                                isStudDocSelected = false;
                              });
                            },
                            onDriverTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SignUpDriverScreen(),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 24),

                          CustomTextfiled(
                            controller: uniEmailController,
                            labelText: 'Email Address',
                            hintText: 'a.m.ghannam@student.ptuk.edu.ps',
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: const Icon(
                              Icons.email_sharp,
                              size: 18,
                              color: AppColors.languagecolor,
                            ),
                          ),
                          const SizedBox(height: 14),
                          CustomTextfiled(
                            controller: passwordController,
                            labelText: 'Password',
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
                          const SizedBox(height: 14),

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

                          const SizedBox(height: 24),

                          SizedBox(
                            height: 56,
                            child: CustomButton(
                              text: 'Sign Up',
                              backgroundColor: AppColors.orangeprimary,
                              onPressed: () {
                                final email = uniEmailController.text.trim();

                                if (email.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Enter your email'),
                                    ),
                                  );
                                  return;
                                }

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        OtbVerificationScreen(email: email),
                                  ),
                                );
                              },
                              textColor: AppColors.white,
                            ),
                          ),

                          const SizedBox(height: 24),

                          Text(
                            'Already have an account?',
                            textAlign: TextAlign.center,
                            style: AppStyle.accountQuestionStyle,
                          ),

                          const SizedBox(height: 4),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Login Now', style: AppStyle.loginNowStyle),
                              const SizedBox(width: 4),
                              Text('|', style: AppStyle.loginNowStyle),
                              const SizedBox(width: 4),
                              Text(
                                'تسجيل الدخول',
                                style: AppStyle.loginNowStyle,
                              ),
                            ],
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
