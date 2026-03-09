import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/widgets/custom_button.dart';
import 'package:uni_ride_application/core/widgets/custom_textfiled.dart';
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

  @override
  void dispose() {
    uniEmailController.dispose();
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
                padding: const EdgeInsets.only(
                  top: 32,
                  left: 24,
                  right: 24,
                  bottom: 32,
                ),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0x66E0E0E0),
                          width: 1,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1A000000),
                            blurRadius: 3,
                            offset: Offset(0, 1),
                          ),
                          BoxShadow(
                            color: Color(0x1A000000),
                            blurRadius: 2,
                            offset: Offset(0, 1),
                            spreadRadius: -1,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          RoleToggleWidget(
                            isStudDocSelected: isStudDocSelected,
                            onStudentTap: () {
                              setState(() {
                                isStudDocSelected = true;
                              });
                            },
                            onDriverTap: () {
                              setState(() {
                                isStudDocSelected = false;
                              });
                            },
                          ),

                          const SizedBox(height: 24),

                          CustomTextfiled(
                            controller: uniEmailController,
                            labelText: 'Email Address',
                            hintText: 'a.m.ghannam@student.ptuk.edu.ps',
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              size: 18,
                              color: AppColors.languagecolor,
                            ),
                          ),

                          const SizedBox(height: 24),

                          SizedBox(
                            height: 56,
                            child: CustomButton(
                              text: 'Sign Up',
                              backgroundColor: AppColors.orangeprimary,
                              onPressed: () {},
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

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Powered by ',
                          style: AppStyle.lablestyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppColors.languagecolor,
                          ),
                        ),
                        const SizedBox(width: 7),
                        Text(
                          'PTUK Engineering',
                          style: AppStyle.lablestyle.copyWith(
                            color: AppColors.orangeprimary,
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
