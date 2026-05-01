import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/auth_provider.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/validators/app_validators.dart';
import 'package:uni_ride_application/core/widgets/custom_button.dart';
import 'package:uni_ride_application/core/widgets/custom_textfiled.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/custom_card_container.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/powered_by_widget.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/tobBar_regestration_widget.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;   
  final String otpCode; 
  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.otpCode,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController newpasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    newpasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleReset() async {
    if (!formKey.currentState!.validate()) return;

    final provider = context.read<AuthProvider>();
    final success = await provider.resetPassword(
      email: widget.email,
      otpCode: widget.otpCode,
      newPassword: newpasswordController.text.trim(),
    );

    if (!mounted) return;

    if (success) {
      Navigator.pushNamed(context, Routes.passwordChanged);
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
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TobbarRegestrationWidget(
                title: AppLocalizations.of(context)!.resetPassword,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 22),
                child: Column(
                  children: [
                    CustomCardContainer(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextfiled(
                              controller: newpasswordController,
                              labelText: AppLocalizations.of(context)!.newPassword,
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
                            const SizedBox(height: 22),
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
                                    newpasswordController.text,
                                  ),
                            ),
                            const SizedBox(height: 26),
                            SizedBox(
                              height: 56,
                              child: isLoading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.orangeprimary,
                                      ),
                                    )
                                  : CustomButton(
                                      text: AppLocalizations.of(context)!.resetPassword,
                                      backgroundColor: AppColors.orangeprimary,
                                      onPressed: _handleReset,
                                      textColor: AppColors.white,
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