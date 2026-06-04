import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/auth_provider.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/validators/app_validators.dart';
import 'package:uni_ride_application/core/widgets/custom_button.dart';
import 'package:uni_ride_application/core/widgets/custom_textfiled.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/custom_card_container.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/powered_by_widget.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/tobBar_regestration_widget.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailOrPhoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailOrPhoneController.dispose();
    super.dispose();
  }

  Future<void> _handleForgetPassword() async {
    if (!formKey.currentState!.validate()) return;

    final provider = context.read<AuthProvider>();
    final email = emailOrPhoneController.text.trim();

    final success = await provider.forgetPassword(email);

    if (!mounted) return;

    if (success) {
      Navigator.pushNamed(
        context,
        Routes.codeVerification,
        arguments: email,
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
                title: AppLocalizations.of(context)!.forgetPassword,
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
                          children: [
                            const SizedBox(height: 30),
                            Text(
                              AppLocalizations.of(context)!.enteryouremailtoresetyourpassword,
                              style: AppStyle.hintstyle.copyWith(
                                color: AppColors.titlecolor,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 40),
                            CustomTextfiled(
                              controller: emailOrPhoneController,
                              labelText: AppLocalizations.of(context)!.emailAddress,
                              hintText: 'a.m.ghannam@student.ptuk.edu.ps',
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: const Icon(
                                Icons.email,
                                size: 22,
                                color: AppColors.languagecolor,
                              ),
                              validator: (value) =>
                                  AppValidators.validateEmail(context, value),
                            ),
                            const SizedBox(height: 30),

                            isLoading
                                ? const CircularProgressIndicator(
                                    color: AppColors.orangeprimary,
                                  )
                                : CustomButton(
                                    text: AppLocalizations.of(context)!.sendCode,
                                    backgroundColor: AppColors.orangeprimary,
                                    onPressed: _handleForgetPassword,
                                    textColor: AppColors.white,
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