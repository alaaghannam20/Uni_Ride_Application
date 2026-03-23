import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/widgets/custom_button.dart';
import 'package:uni_ride_application/core/widgets/custom_textfiled.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/custom_card_container.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/powered_by_widget.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/tobBar_regestration_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isChecked = false;

  @override
  void dispose() {
    emailOrPhoneController.dispose();
    passwordController.dispose();
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
              title: 'Sign In',
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
                            width: 332,
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/signin.png',
                                  width: 64,
                                  height: 64,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Welcome Back',
                                  style: AppStyle.custombuttonstyle.copyWith(
                                    fontSize: 20,
                                    color: AppColors.skiptextcolor,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          SizedBox(
                            width: 332,
                            child: Column(
                              children: [
                                CustomTextfiled(
                                  controller: emailOrPhoneController,
                                  labelText: 'Email or Phone',
                                  hintText: 'a.m.ghannam@student.ptuk.edu.ps',
                                  keyboardType: TextInputType.emailAddress,
                                  prefixIcon: const Icon(
                                    Icons.badge,
                                    size: 22,
                                    color: AppColors.languagecolor,
                                  ),
                                ),

                                const SizedBox(height: 16),

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

                                const SizedBox(height: 12),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: Checkbox(
                                              value: isChecked,
                                              onChanged: (value) {
                                                setState(() {
                                                  isChecked = value ?? false;
                                                });
                                              },
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              visualDensity:
                                                  VisualDensity.compact,
                                              side: const BorderSide(
                                                width: 1.8,
                                                color: AppColors.orangeprimary,
                                              ),
                                              activeColor:
                                                  AppColors.orangeprimary,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Flexible(
                                            child: Text(
                                              'Remember Me',
                                              overflow: TextOverflow.ellipsis,
                                              style: AppStyle.passwordStyle
                                                  .copyWith(
                                                    color: AppColors.black,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        'Forgot Password?',
                                        style: AppStyle.passwordStyle.copyWith(
                                          color: AppColors.orangeprimary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 24),

                          SizedBox(
                            width: 332,
                            child: Column(
                              children: [
                                CustomButton(
                                  text: 'Login',
                                  backgroundColor: AppColors.orangeprimary,
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      Routes.home,
                                    );
                                  },
                                  textColor: AppColors.white,
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  'Dont have an account?',
                                  textAlign: TextAlign.center,
                                  style: AppStyle.accountQuestionStyle,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Sign Up Now',
                                      style: AppStyle.loginNowStyle,
                                    ),
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
