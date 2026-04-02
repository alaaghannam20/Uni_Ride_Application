import 'package:flutter/material.dart';
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
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController newpasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),

              child: TobbarRegestrationWidget(
                title: AppLocalizations.of(context)!.resetPassword,
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
                            CustomTextfiled(
                              controller: newpasswordController,
                              labelText: AppLocalizations.of(
                                context,
                              )!.newPassword,
                              hintText: '• • • • • • • •',
                              isPassword: true,
                              prefixIcon: const Icon(
                                Icons.lock,
                                size: 22,
                                color: AppColors.languagecolor,
                              ),
                              validator: (value) =>
                                  AppValidators.validatePassword(
                                    context,
                                    value,
                                  ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              AppLocalizations.of(context)!.minimum8Chars,
                              style: AppStyle.hintstyle.copyWith(fontSize: 9),
                            ),
                            const SizedBox(height: 22),

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
                              child: CustomButton(
                                text: AppLocalizations.of(
                                  context,
                                )!.resetPassword,
                                backgroundColor: AppColors.orangeprimary,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.passwordChanged,
                                    );
                                  }
                                },
                                textColor: AppColors.white,
                              ),
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
