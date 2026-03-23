import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/widgets/custom_button.dart';
import 'package:uni_ride_application/core/widgets/custom_textfiled.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/screens/signup_uni_screen.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/custom_card_container.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/powered_by_widget.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/role_toggle_widget.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/tobBar_regestration_widget.dart';

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

  final carTypeController = TextEditingController();
  final carSeatsController = TextEditingController();

  final licenseNumberController = TextEditingController();
  final vehicleTypeController = TextEditingController();
  final plateNumberController = TextEditingController();
  final driverSeatsController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    carTypeController.dispose();
    carSeatsController.dispose();
    licenseNumberController.dispose();
    vehicleTypeController.dispose();
    plateNumberController.dispose();
    driverSeatsController.dispose();
    super.dispose();
  }

  void goToNextStep() {
    if (currentStep == 0) {
      setState(() {
        currentStep += 1;
      });
    } else if (currentStep == 1) {
      setState(() {
        currentStep += 1;
      });
    } else if (currentStep == 2) {
      if (!agreeTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please agree to the Terms and Privacy Policy'),
          ),
        );
        return;
      }

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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Driver Sign Up Submitted Successfully')),
    );
  }

  List<Step> getSteps() {
    return [
      Step(
        title: const Text('Personal Information'),
        isActive: currentStep >= 0,
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        content: Form(
          key: _formKeyStep1,
          child: Column(
            children: [
              CustomTextfiled(
                controller: fullNameController,
                labelText: 'Full Name',
                hintText: 'A’laa Mohammad Ghannam',
                prefixIcon: const Icon(
                  Icons.person_outline,
                  size: 18,
                  color: AppColors.languagecolor,
                ),
              ),
              const SizedBox(height: 16),
              CustomTextfiled(
                controller: emailController,
                labelText: 'Email Address',
                hintText: 'a.m.ghannam@student.ptuk.edu.ps',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(
                  Icons.email_sharp,
                  size: 18,
                  color: AppColors.languagecolor,
                ),
              ),
              const SizedBox(height: 16),
              CustomTextfiled(
                controller: phoneController,
                labelText: 'Phone Number',
                hintText: '059XXXXXXX',
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(
                  Icons.phone_outlined,
                  size: 18,
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
              const SizedBox(height: 6),
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  'Minimum 8 characters',
                  style: AppStyle.hintstyle.copyWith(fontSize: 9),
                ),
              ),
              const SizedBox(height: 16),
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
            ],
          ),
        ),
      ),
      Step(
        title: const Text('Car Details'),
        isActive: currentStep >= 1,
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        content: Form(
          key: _formKeyStep2,
          child: Column(
            children: [
              CustomTextfiled(
                hintText: 'BMW / Kia / Hyundai',
                labelText: 'Car Type',
                controller: carTypeController,
              ),
              const SizedBox(height: 16),
              CustomTextfiled(
                hintText: '4',
                labelText: 'Number of Car’s Seats',
                controller: carSeatsController,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
      Step(
        title: const Text('Driver Documents'),
        isActive: currentStep >= 2,
        state: StepState.indexed,
        content: Form(
          key: _formKeyStep3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Driver Information',
                style: AppStyle.lablestyle.copyWith(
                  color: AppColors.orangeprimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              CustomTextfiled(
                hintText: '123456789',
                labelText: 'License Number',
                controller: licenseNumberController,
                prefixIcon: const Icon(Icons.badge_outlined),
              ),
              const SizedBox(height: 16),
              CustomTextfiled(
                hintText: 'Bus',
                labelText: 'Vehicle Type',
                controller: vehicleTypeController,
              ),
              const SizedBox(height: 16),
              CustomTextfiled(
                hintText: '123456778',
                labelText: 'Plate Number',
                controller: plateNumberController,
              ),
              const SizedBox(height: 16),
              CustomTextfiled(
                hintText: '4',
                labelText: 'Number of Seats',
                controller: driverSeatsController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              Text(
                "Upload a copy of your valid driver's license.",
                style: AppStyle.lablestyle.copyWith(fontSize: 12),
              ),
              const SizedBox(height: 8),
              _buildUploadBox(title: 'Upload Document', onTap: () {}),
              const SizedBox(height: 16),
              Text(
                'Upload a copy of your vehicle license.',
                style: AppStyle.lablestyle.copyWith(fontSize: 12),
              ),
              const SizedBox(height: 8),
              _buildUploadBox(title: 'Upload Document', onTap: () {}),
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
                      'I agree to the Terms and Privacy Policy',
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
            const TobbarRegestrationWidget(title: 'Sign Up Driver'),
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
                                physics:
                                    const ClampingScrollPhysics(), // تعديل 1
                                margin: EdgeInsets.zero, // تعديل 2

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
                                                ? 'Sign Up'
                                                : 'Continue',
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
                                              'Cancel',
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
                          if (isStudDocSelected)
                            Column(
                              children: [
                                const SizedBox(height: 20),
                                Text(
                                  'Student/Doctor form goes here',
                                  style: AppStyle.lablestyle,
                                ),
                              ],
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
