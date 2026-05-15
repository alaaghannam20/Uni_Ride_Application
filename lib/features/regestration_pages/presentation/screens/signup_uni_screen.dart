import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/auth_provider.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/validators/app_validators.dart';
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
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController referralCodeController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    uniEmailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    referralCodeController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!formKey.currentState!.validate()) return;

    final provider = context.read<AuthProvider>();
    final email = uniEmailController.text.trim();

    final success = await provider.registerMember(
      email,
      passwordController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtbVerificationScreen(email: email),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthProvider>().state == AuthState.loading;

    return Scaffold(
      backgroundColor: context.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TobbarRegestrationWidget(
                title: AppLocalizations.of(context)!.signUpUniversity,
              ),
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
                              labelText: AppLocalizations.of(context)!.emailAddress,
                              hintText: '',
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: const Icon(
                                Icons.email_sharp,
                                size: 18,
                                color: AppColors.languagecolor,
                              ),
                              validator: (value) =>
                                  AppValidators.validateEmail(context, value),
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
                              validator: (value) =>
                                  AppValidators.validatePassword(context, value),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              AppLocalizations.of(context)!.minimum8Chars,
                              style: AppStyle.hintstyle.copyWith(fontSize: 9),
                            ),
                            const SizedBox(height: 14),
                            CustomTextfiled(
                              controller: confirmPasswordController,
                              labelText: AppLocalizations.of(context)!.confirmPassword,
                              hintText: '• • • • • • • •',
                              isPassword: true,
                              prefixIcon: const Icon(
                                Icons.lock,
                                size: 22,
                                color: AppColors.languagecolor,
                              ),
                              validator: (value) =>
                                  AppValidators.validateConfirmPassword(
                                    context,
                                    value,
                                    passwordController.text,
                                  ),
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              height: 56,
                              child: isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.orangeprimary,
                                      ),
                                    )
                                  : CustomButton(
                                      text: AppLocalizations.of(context)!.signUp,
                                      backgroundColor: AppColors.orangeprimary,
                                      onPressed: _handleRegister,
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
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/signIn');
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Login Now', style: AppStyle.loginNowStyle),
                                  const SizedBox(width: 4),
                                  Text('|', style: AppStyle.loginNowStyle),
                                  const SizedBox(width: 4),
                                  Text('تسجيل الدخول', style: AppStyle.loginNowStyle),
                                ],
                              ),
                            ),
                          ],
                        ),
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