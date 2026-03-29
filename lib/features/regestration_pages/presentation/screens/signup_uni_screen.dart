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
import 'package:uni_ride_application/l10n/app_localizations.dart';

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
  final formKey = GlobalKey<FormState>();

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
              title: AppLocalizations.of(context)!.signUpUniversity,
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
                      child: Form(
                        key: formKey,
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
                              labelText: AppLocalizations.of(
                                context,
                              )!.emailAddress,
                              hintText: 'a.m.ghannam@student.ptuk.edu.ps',
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: const Icon(
                                Icons.email_sharp,
                                size: 18,
                                color: AppColors.languagecolor,
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return AppLocalizations.of(
                                    context,
                                  )!.enterEmail;
                                }
                                if (!value.contains('@')) {
                                  return AppLocalizations.of(
                                    context,
                                  )!.invalidEmail;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 14),
                            CustomTextfiled(
                              controller: passwordController,
                              labelText: AppLocalizations.of(context)!.password,
                              hintText: '• • • • • • • •',
                              isPassword: true,
                              prefixIcon: const Icon(
                                Icons.lock,
                                size: 22,
                                color: AppColors.languagecolor,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(
                                    context,
                                  )!.enterPassword;
                                }
                                if (value.length < 8) {
                                  return AppLocalizations.of(
                                    context,
                                  )!.minimum8Chars;
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 4),

                            Text(
                              AppLocalizations.of(context)!.minimum8Chars,
                              style: AppStyle.hintstyle.copyWith(fontSize: 9),
                            ),
                            const SizedBox(height: 14),

                            CustomTextfiled(
                              controller: confirmPasswordController,
                              labelText: AppLocalizations.of(
                                context,
                              )!.confirmPassword,
                              hintText: '• • • • • • • •',
                              isPassword: true,
                              prefixIcon: const Icon(
                                Icons.lock,
                                size: 22,
                                color: AppColors.languagecolor,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppLocalizations.of(
                                    context,
                                  )!.enterPassword;
                                }
                                if (value != passwordController.text) {
                                  return AppLocalizations.of(
                                    context,
                                  )!.passwordsDoNotMatch;
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 24),

                            SizedBox(
                              height: 56,
                              child: CustomButton(
                                text: AppLocalizations.of(context)!.signUp,
                                backgroundColor: AppColors.orangeprimary,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    final email = uniEmailController.text
                                        .trim();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OtbVerificationScreen(email: email),
                                      ),
                                    );
                                  }
                                },
                                textColor: AppColors.white,
                              ),
                            ),

                            const SizedBox(height: 24),

                            Text(
                              AppLocalizations.of(context)!.alreadyHaveAccount,
                              textAlign: TextAlign.center,
                              style: AppStyle.accountQuestionStyle,
                            ),

                            const SizedBox(height: 4),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Login Now',
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
