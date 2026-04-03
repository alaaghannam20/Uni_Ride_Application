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

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),

              child: TobbarRegestrationWidget(
                title: AppLocalizations.of(context)!.signIn,
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
                      child: Column(
                        children: [
                          SizedBox(
                            width: 332,
                            child: Form(
                              key: formKey,
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
                                    AppLocalizations.of(context)!.welcomeBack,
                                    style: AppStyle.custombuttonstyle.copyWith(
                                      fontSize: 20,
                                      color: AppColors.skiptextcolor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          SizedBox(
                            width: 332,
                            child: Column(
                              children: [
                                CustomTextfiled(
                                  controller: emailOrPhoneController,
                                  labelText: AppLocalizations.of(
                                    context,
                                  )!.emailOrPhone,
                                  hintText: 'a.m.ghannam@student.ptuk.edu.ps',
                                  keyboardType: TextInputType.emailAddress,
                                  prefixIcon: const Icon(
                                    Icons.badge,
                                    size: 22,
                                    color: AppColors.languagecolor,
                                  ),
                                  validator: (value) =>
                                      AppValidators.validateEmail(
                                        context,
                                        value,
                                      ),
                                ),

                                const SizedBox(height: 16),

                                CustomTextfiled(
                                  controller: passwordController,
                                  labelText: AppLocalizations.of(
                                    context,
                                  )!.password,
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
                                              AppLocalizations.of(
                                                context,
                                              )!.rememberMe,
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
                                        AppLocalizations.of(
                                          context,
                                        )!.forgotPassword,
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
                                  text: AppLocalizations.of(context)!.login,
                                  backgroundColor: AppColors.orangeprimary,
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        Routes.home,
                                      );
                                    }
                                  },
                                  textColor: AppColors.white,
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  AppLocalizations.of(context)!.dontHaveAccount,
                                  textAlign: TextAlign.center,
                                  style: AppStyle.accountQuestionStyle,
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          Routes.signUpUni,
                                        );
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!.signUpNow,
                                        style: AppStyle.loginNowStyle,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Text('|', style: AppStyle.loginNowStyle),
                                    const SizedBox(width: 4),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          Routes.signUpUni,
                                        );
                                      },
                                      child: Text(
                                        'انشاء حساب',
                                        style: AppStyle.loginNowStyle,
                                      ),
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
