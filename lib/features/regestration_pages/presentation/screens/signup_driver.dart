import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/storage/app_prefs.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/validators/app_validators.dart';
import 'package:uni_ride_application/core/widgets/custom_button.dart';
import 'package:uni_ride_application/core/widgets/custom_textfiled.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/screens/signup_uni_screen.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/custom_card_container.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/powered_by_widget.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/role_toggle_widget.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/tobBar_regestration_widget.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class SignUpDriverScreen extends StatefulWidget {
  const SignUpDriverScreen({super.key});

  @override
  State<SignUpDriverScreen> createState() => _SignUpDriverScreenState();
}

class _SignUpDriverScreenState extends State<SignUpDriverScreen> {
  int currentStep = 0;
  bool isStudDocSelected = false;
  bool agreeTerms = false;

  final _formKeyStep1 = GlobalKey<FormState>();
  final _formKeyStep2 = GlobalKey<FormState>();
  final _formKeyStep3 = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? selectedCarType;
  final carSeatsController = TextEditingController();
  final carModelController = TextEditingController();

  final licenseNumberController = TextEditingController();
  final plateNumberController = TextEditingController();
  final driverSeatsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadProgress();
    licenseNumberController.addListener(saveProgress);
    plateNumberController.addListener(saveProgress);
    driverSeatsController.addListener(saveProgress);
  }

  Future<void> saveProgress() async {
    await AppPrefs.saveDriverProgress(
      currentStep: currentStep,
      fullName: fullNameController.text,
      email: emailController.text,
      phone: phoneController.text,
      carType: selectedCarType ?? '',
      carModel: carModelController.text,
      carSeats: carSeatsController.text,
      license: licenseNumberController.text,
      plate: plateNumberController.text,
    );
  }

  Future<void> loadProgress() async {
    setState(() {
      currentStep = AppPrefs.getDriverCurrentStep();
      fullNameController.text = AppPrefs.getDriverFullName();
      emailController.text = AppPrefs.getDriverEmail();
      phoneController.text = AppPrefs.getDriverPhone();
      selectedCarType = AppPrefs.getDriverCarType();
      carModelController.text = AppPrefs.getDriverCarModel();
      carSeatsController.text = AppPrefs.getDriverCarSeats();
      licenseNumberController.text = AppPrefs.getDriverLicense();
      plateNumberController.text = AppPrefs.getDriverPlate();
    });
  }

  Future<void> clearProgress() async {
    await AppPrefs.clearDriverProgress();
  }

  @override
  void dispose() {
    licenseNumberController.removeListener(saveProgress);
    plateNumberController.removeListener(saveProgress);
    driverSeatsController.removeListener(saveProgress);
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    carSeatsController.dispose();
    carModelController.dispose();

    licenseNumberController.dispose();
    plateNumberController.dispose();
    driverSeatsController.dispose();
    super.dispose();
  }

  void goToNextStep() {
    if (currentStep == 0) {
      if (!_formKeyStep1.currentState!.validate()) return;
      setState(() => currentStep += 1);
      saveProgress();
    } else if (currentStep == 1) {
      if (!_formKeyStep2.currentState!.validate()) return;
      setState(() => currentStep += 1);
      saveProgress();
    } else if (currentStep == 2) {
      if (!_formKeyStep3.currentState!.validate()) return;
      if (!agreeTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.agreeTerms)),
        );
        return;
      }
      saveProgress();
      submitForm();
    }
  }

  void goToPreviousStep() {
    if (currentStep == 0) return;
    setState(() {
      currentStep -= 1;
    });
  }

  void submitForm() {
    clearProgress();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Driver Sign Up Submitted Successfully')),
    );
  }

  List<Step> getSteps() {
    return [
      Step(
        title: Text(AppLocalizations.of(context)!.personalInformation),
        isActive: currentStep >= 0,
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        content: Form(
          key: _formKeyStep1,
          child: Column(
            children: [
              CustomTextfiled(
                controller: fullNameController,
                labelText: AppLocalizations.of(context)!.fullName,
                hintText: 'A’laa Mohammad Ghannam',
                prefixIcon: const Icon(
                  Icons.person_outline,
                  size: 18,
                  color: AppColors.languagecolor,
                ),
                validator: (value) =>
                    AppValidators.validateFullName(context, value),
              ),
              const SizedBox(height: 16),
              CustomTextfiled(
                controller: emailController,
                labelText: AppLocalizations.of(context)!.emailAddress,
                hintText: 'a.m.ghannam@student.ptuk.edu.ps',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(
                  Icons.email_sharp,
                  size: 18,
                  color: AppColors.languagecolor,
                ),
                validator: (value) =>
                    AppValidators.validateEmail(context, value),
              ),
              const SizedBox(height: 16),
              CustomTextfiled(
                controller: phoneController,
                labelText: AppLocalizations.of(context)!.phoneNumber,
                hintText: '059XXXXXXX',
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(
                  Icons.phone_outlined,
                  size: 18,
                  color: AppColors.languagecolor,
                ),
                validator: (value) =>
                    AppValidators.validatePhone(context, value),
              ),
              const SizedBox(height: 16),
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
              const SizedBox(height: 6),
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  AppLocalizations.of(context)!.minimum8Chars,
                  style: AppStyle.hintstyle.copyWith(fontSize: 9),
                ),
              ),
              const SizedBox(height: 16),
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
                validator: (value) => AppValidators.validateConfirmPassword(
                  context,
                  value,
                  passwordController.text,
                ),
              ),
            ],
          ),
        ),
      ),

      Step(
        title: Text(AppLocalizations.of(context)!.carDetails),
        isActive: currentStep >= 1,
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        content: Form(
          key: _formKeyStep2,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                value: selectedCarType,
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.carType,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  prefixIcon: const Icon(
                    Icons.directions_car,
                    size: 20,
                    color: AppColors.languagecolor,
                  ),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'car',
                    child: Text(AppLocalizations.of(context)!.car),
                  ),
                  DropdownMenuItem(
                    value: 'service',
                    child: Text(AppLocalizations.of(context)!.service),
                  ),
                  DropdownMenuItem(
                    value: 'bus',
                    child: Text(AppLocalizations.of(context)!.bus),
                  ),
                ],

                onChanged: (value) {
                  setState(() {
                    selectedCarType = value;
                    if (value == 'car') {
                      carSeatsController.text = '4';
                    } else if (value == 'service') {
                      carSeatsController.text = '7';
                    } else if (value == 'bus') {
                      carSeatsController.text = '20';
                    }
                  });
                },
                validator: (value) =>
                    AppValidators.validateCarType(context, value),
              ),

              const SizedBox(height: 16),

              CustomTextfiled(
                hintText: 'Toyota / Hyundai / Kia / BMW',
                labelText: AppLocalizations.of(context)!.carModel,
                controller: carModelController,
                keyboardType: TextInputType.text,
                prefixIcon: const Icon(
                  Icons.directions_car_filled,
                  size: 18,
                  color: AppColors.languagecolor,
                ),
                validator: (value) =>
                    AppValidators.validateCarModel(context, value),
              ),

              const SizedBox(height: 16),

              CustomTextfiled(
                hintText: AppLocalizations.of(context)!.numberOfSeats,
                labelText: AppLocalizations.of(context)!.numberOfSeats,
                controller: carSeatsController,
                keyboardType: TextInputType.number,
                prefixIcon: const Icon(
                  Icons.event_seat,
                  size: 18,
                  color: AppColors.languagecolor,
                ),
                validator: (value) =>
                    AppValidators.validateNumberOfSeats(context, value),
              ),
            ],
          ),
        ),
      ),

      Step(
        title: Text(AppLocalizations.of(context)!.driverDocuments),
        isActive: currentStep >= 2,
        state: StepState.indexed,
        content: Form(
          key: _formKeyStep3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.driverInformation,
                style: AppStyle.lablestyle.copyWith(
                  color: AppColors.orangeprimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              CustomTextfiled(
                hintText: '123456789',
                labelText: AppLocalizations.of(context)!.licenseNumber,
                controller: licenseNumberController,
                prefixIcon: const Icon(Icons.badge_outlined),
                validator: (value) =>
                    AppValidators.validateLicenseNumber(context, value),
              ),
              const SizedBox(height: 16),

              const SizedBox(height: 16),
              CustomTextfiled(
                hintText: '123456778',
                labelText: AppLocalizations.of(context)!.plateNumber,
                controller: plateNumberController,
                validator: (value) =>
                    AppValidators.validatePlateNumber(context, value),
              ),
              const SizedBox(height: 16),
              CustomTextfiled(
                hintText: '4',
                labelText: AppLocalizations.of(context)!.numberOfSeats,
                controller: driverSeatsController,
                keyboardType: TextInputType.number,
                validator: (value) =>
                    AppValidators.validateNumberOfSeats(context, value),
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.uploadDriverLicense,
                style: AppStyle.lablestyle.copyWith(fontSize: 12),
              ),
              const SizedBox(height: 8),
              _buildUploadBox(
                title: AppLocalizations.of(context)!.uploadDocument,
                onTap: () {},
              ),
              const SizedBox(height: 16),
              Text(
                AppLocalizations.of(context)!.uploadVehicleLicense,
                style: AppStyle.lablestyle.copyWith(fontSize: 12),
              ),
              const SizedBox(height: 8),
              _buildUploadBox(
                title: AppLocalizations.of(context)!.uploadDocument,
                onTap: () {},
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: agreeTerms,
                    activeColor: AppColors.orangeprimary,
                    onChanged: (value) {
                      setState(() {
                        agreeTerms = value ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.agreeTerms,
                      style: AppStyle.lablestyle.copyWith(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ];
  }

  Widget _buildUploadBox({required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFD9D9D9), width: 1),
          borderRadius: BorderRadius.circular(14),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.upload_file_outlined, color: Colors.grey),
            const SizedBox(width: 8),
            Text(
              title,
              style: AppStyle.lablestyle.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastStep = currentStep == 2;
    final bool isFirstStep = currentStep == 0;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),

              child: TobbarRegestrationWidget(
                title: AppLocalizations.of(context)!.signUpDriver,
                showLoginButton: true,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    CustomCardContainer(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 5,
                      ),
                      child: Column(
                        children: [
                          RoleToggleWidget(
                            isStudDocSelected: isStudDocSelected,
                            onStudentTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SignupUniScreen(),
                                ),
                              );
                            },
                            onDriverTap: () {
                              setState(() {
                                isStudDocSelected = false;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          if (!isStudDocSelected)
                            Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: Theme.of(context).colorScheme
                                    .copyWith(primary: AppColors.orangeprimary),
                              ),
                              child: Stepper(
                                type: StepperType.vertical,
                                currentStep: currentStep,
                                physics: const ClampingScrollPhysics(),
                                margin: EdgeInsets.zero,
                                onStepContinue: goToNextStep,
                                onStepCancel: goToPreviousStep,
                                controlsBuilder: (context, details) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: CustomButton(
                                            text: isLastStep
                                                ? AppLocalizations.of(
                                                    context,
                                                  )!.signUp
                                                : AppLocalizations.of(
                                                    context,
                                                  )!.continu,
                                            backgroundColor:
                                                AppColors.orangeprimary,
                                            textColor: Colors.white,
                                            onPressed: details.onStepContinue!,
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: OutlinedButton(
                                            onPressed: isFirstStep
                                                ? null
                                                : details.onStepCancel,
                                            style: OutlinedButton.styleFrom(
                                              minimumSize:
                                                  const Size.fromHeight(56),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                              side: const BorderSide(
                                                color: AppColors.orangeprimary,
                                              ),
                                            ),
                                            child: Text(
                                              AppLocalizations.of(
                                                context,
                                              )!.cancel,
                                              style: AppStyle.loginNowStyle
                                                  .copyWith(
                                                    color: isFirstStep
                                                        ? Colors.grey
                                                        : AppColors
                                                              .orangeprimary,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                steps: getSteps(),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
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
