import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/auth_provider.dart';
import 'package:uni_ride_application/core/storage/app_prefs.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/validators/app_validators.dart';
import 'package:uni_ride_application/core/widgets/custom_button.dart';
import 'package:uni_ride_application/core/widgets/custom_textfiled.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/custom_card_container.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/powered_by_widget.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/widget/tobBar_regestration_widget.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class SignUpDriverScreen extends StatefulWidget {
  final bool isCarpoole;

  const SignUpDriverScreen({super.key, this.isCarpoole = false});
  const SignUpDriverScreen.carpoolRigestration({super.key}) : isCarpoole = true;

  @override
  State<SignUpDriverScreen> createState() => _SignUpDriverScreenState();
}

class _SignUpDriverScreenState extends State<SignUpDriverScreen> {
  int currentStep = 0;
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

  String? _profileImagePath;
  String? _driverLicensePath;
  String? _vehicleLicensePath;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadProgress();
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
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    carSeatsController.dispose();
    carModelController.dispose();
    licenseNumberController.dispose();
    plateNumberController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(String type) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        if (type == 'driverLicense') {
          _driverLicensePath = image.path;
        } else if (type == 'vehicleLicense') {
          _vehicleLicensePath = image.path;
        } else if (type == 'profile') {
          _profileImagePath = image.path;
        }
      });
    }
  }

  void goToNextStep() {
    if (currentStep == 0) {
      if (_profileImagePath == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.uploadDocument),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
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
      if (_driverLicensePath == null || _vehicleLicensePath == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.upload_both_licenses),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      saveProgress();
      submitForm();
    }
  }

  void goToPreviousStep() {
    if (currentStep == 0) return;
    setState(() => currentStep -= 1);
  }

  Future<void> submitForm() async {
    final provider = context.read<AuthProvider>();

    final success = widget.isCarpoole
        ? await provider.registerCarpool(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            phoneNumber: phoneController.text.trim(),
            vehicleType: selectedCarType ?? '',
            vehicleModel: carModelController.text.trim(),
            plateNumber: plateNumberController.text.trim(),
            seatCapacity: int.tryParse(carSeatsController.text.trim()) ?? 0,
            licenseNumber: licenseNumberController.text.trim(),
            driverLicensePath: _driverLicensePath!,
            vehicleLicensePath: _vehicleLicensePath!,
            profileImagePath: _profileImagePath!,
          )
        : await provider.registerDriver(
            fullName: fullNameController.text.trim(),
            email: emailController.text.trim(),
            phoneNumber: phoneController.text.trim(),
            password: passwordController.text.trim(),
            licenseNumber: licenseNumberController.text.trim(),
            vehicleType: selectedCarType ?? '',
            vehicleModel: carModelController.text.trim(),
            plateNumber: plateNumberController.text.trim(),
            seatCapacity: int.tryParse(carSeatsController.text.trim()) ?? 0,
            driverLicensePath: _driverLicensePath!,
            vehicleLicensePath: _vehicleLicensePath!,
            profileImagePath: _profileImagePath!,
          );

    if (success) {
      await clearProgress();
      if (!mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(AppLocalizations.of(context)!.registration_submitted),
          content: Text(AppLocalizations.of(context)!.under_review_message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/signIn',
                  (route) => false,
                );
              },
              child: Text(AppLocalizations.of(context)!.oK),
            ),
          ],
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
    final l = AppLocalizations.of(context)!;
    final isLoading = context.watch<AuthProvider>().state == AuthState.loading;

    // ✅ التعديل هون
    final String title = widget.isCarpoole ? l.signUpCarpool : l.signUpDriver;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TobbarRegestrationWidget(title: title),
            ),
            _buildProgressIndicator(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  children: [
                    CustomCardContainer(
                      padding: const EdgeInsets.all(24),
                      child: _buildCurrentStepContent(l),
                    ),
                    const SizedBox(height: 32),
                    _buildNavigationButtons(isLoading, l),
                    const SizedBox(height: 24),
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

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
      child: Row(
        children: [
          _buildStepCircle(0, Icons.person_outline),
          _buildStepLine(0),
          _buildStepCircle(1, Icons.directions_car_outlined),
          _buildStepLine(1),
          _buildStepCircle(2, Icons.document_scanner_outlined),
        ],
      ),
    );
  }

  Widget _buildStepCircle(int step, IconData icon) {
    bool isCompleted = currentStep > step;
    bool isActive = currentStep == step;

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isCompleted || isActive ? AppColors.orangeprimary : const Color(0xFFF2F4F7),
        shape: BoxShape.circle,
        border: isActive
            ? Border.all(color: AppColors.orangeprimary.withValues(alpha: 0.2), width: 4)
            : null,
      ),
      child: Icon(
        isCompleted ? Icons.check : icon,
        color: isCompleted || isActive ? Colors.white : const Color(0xFF667085),
        size: 20,
      ),
    );
  }

  Widget _buildStepLine(int step) {
    bool isCompleted = currentStep > step;
    return Expanded(
      child: Container(
        height: 2,
        color: isCompleted ? AppColors.orangeprimary : const Color(0xFFF2F4F7),
      ),
    );
  }

  Widget _buildCurrentStepContent(AppLocalizations l) {
    switch (currentStep) {
      case 0:
        return _buildStep1(l);
      case 1:
        return _buildStep2(l);
      case 2:
        return _buildStep3(l);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildStep1(AppLocalizations l) {
    return Form(
      key: _formKeyStep1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l.personalInformation,
              style: AppStyle.lablestyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Center(
            child: GestureDetector(
              onTap: () => _pickImage('profile'),
              child: Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.orangeprimary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      image: _profileImagePath != null
                          ? DecorationImage(
                              image: FileImage(File(_profileImagePath!)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _profileImagePath == null
                        ? const Icon(Icons.person, size: 50, color: AppColors.orangeprimary)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.orangeprimary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          if (!widget.isCarpoole) ...[
            CustomTextfiled(
              controller: fullNameController,
              labelText: l.fullName,
              hintText: 'John Doe',
              prefixIcon: const Icon(Icons.person_outline, color: AppColors.languagecolor),
              validator: (value) => AppValidators.validateFullName(context, value),
            ),
            const SizedBox(height: 16),
          ],
          CustomTextfiled(
            controller: emailController,
            labelText: l.emailAddress,
            hintText: 'email@example.com',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.email_outlined, color: AppColors.languagecolor),
            validator: (value) => AppValidators.validateEmail(context, value),
          ),
          const SizedBox(height: 16),
          CustomTextfiled(
            controller: phoneController,
            labelText: l.phoneNumber,
            hintText: '059XXXXXXX',
            keyboardType: TextInputType.phone,
            prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.languagecolor),
            validator: (value) => AppValidators.validatePhone(context, value),
          ),
          const SizedBox(height: 16),
          CustomTextfiled(
            controller: passwordController,
            labelText: l.password,
            hintText: '••••••••',
            isPassword: true,
            prefixIcon: const Icon(Icons.lock_outline, color: AppColors.languagecolor),
            validator: (value) => AppValidators.validatePassword(context, value),
          ),
          const SizedBox(height: 8),
          Text(l.minimum8Chars, style: AppStyle.hintstyle.copyWith(fontSize: 11)),
          const SizedBox(height: 16),
          CustomTextfiled(
            controller: confirmPasswordController,
            labelText: l.confirmPassword,
            hintText: '••••••••',
            isPassword: true,
            prefixIcon: const Icon(Icons.lock_reset, color: AppColors.languagecolor),
            validator: (value) =>
                AppValidators.validateConfirmPassword(context, value, passwordController.text),
          ),
        ],
      ),
    );
  }

  Widget _buildStep2(AppLocalizations l) {
    return Form(
      key: _formKeyStep2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l.vehicleDetails,
              style: AppStyle.lablestyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          DropdownButtonFormField<String>(
            value: selectedCarType,
            decoration: InputDecoration(
              labelText: l.vehicleType,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              prefixIcon: const Icon(Icons.directions_car, color: AppColors.languagecolor),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
            items: [
              DropdownMenuItem(value: 'car', child: Text(l.car)),
              DropdownMenuItem(value: 'service', child: Text(l.service)),
              DropdownMenuItem(value: 'bus', child: Text(l.bus)),
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
            validator: (value) => AppValidators.validateCarType(context, value),
          ),
          const SizedBox(height: 16),
          CustomTextfiled(
            controller: carModelController,
            labelText: l.vehicleModel,
            hintText: 'Toyota / Hyundai',
            prefixIcon: const Icon(Icons.info_outline, color: AppColors.languagecolor),
            validator: (value) => AppValidators.validateCarModel(context, value),
          ),
          const SizedBox(height: 16),
          CustomTextfiled(
            controller: carSeatsController,
            labelText: l.numberOfSeats,
            hintText: '4',
            keyboardType: TextInputType.number,
            prefixIcon: const Icon(Icons.event_seat_outlined, color: AppColors.languagecolor),
            validator: (value) => AppValidators.validateNumberOfSeats(context, value),
          ),
        ],
      ),
    );
  }

  Widget _buildStep3(AppLocalizations l) {
    return Form(
      key: _formKeyStep3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l.driverDocuments,
              style: AppStyle.lablestyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          CustomTextfiled(
            controller: licenseNumberController,
            labelText: l.licenseNumber,
            hintText: '123456789',
            prefixIcon: const Icon(Icons.badge_outlined, color: AppColors.languagecolor),
            validator: (value) => AppValidators.validateLicenseNumber(context, value),
          ),
          const SizedBox(height: 16),
          CustomTextfiled(
            controller: plateNumberController,
            labelText: l.plateNumber,
            hintText: '7-1234-99',
            prefixIcon: const Icon(Icons.confirmation_number_outlined, color: AppColors.languagecolor),
            validator: (value) => AppValidators.validatePlateNumber(context, value),
          ),
          const SizedBox(height: 24),
          _buildDocumentPicker(
              l.uploadDriverLicense, _driverLicensePath, () => _pickImage('driverLicense')),
          const SizedBox(height: 16),
          _buildDocumentPicker(
              l.uploadVehicleLicense, _vehicleLicensePath, () => _pickImage('vehicleLicense')),
          const SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                value: agreeTerms,
                activeColor: AppColors.orangeprimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                onChanged: (value) => setState(() => agreeTerms = value ?? false),
              ),
              Expanded(
                  child: Text(l.agreeTerms,
                      style: const TextStyle(fontSize: 13, color: Color(0xFF667085)))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentPicker(String label, String? path, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF344054))),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(
                  color: path != null ? AppColors.orangeprimary : const Color(0xFFD0D5DD)),
              borderRadius: BorderRadius.circular(12),
              color: path != null ? AppColors.orangeprimary.withValues(alpha: 0.05) : Colors.white,
            ),
            child: Row(
              children: [
                Icon(
                  path != null ? Icons.check_circle : Icons.cloud_upload_outlined,
                  color: path != null ? AppColors.orangeprimary : const Color(0xFF667085),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    path != null ? path.split('/').last : AppLocalizations.of(context)!.uploadDocument,
                    style: TextStyle(
                      color: path != null ? AppColors.orangeprimary : const Color(0xFF667085),
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButtons(bool isLoading, AppLocalizations l) {
    final bool isLastStep = currentStep == 2;
    return Row(
      children: [
        Expanded(
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: AppColors.orangeprimary))
              : CustomButton(
                  text: isLastStep ? l.signUp : l.continu,
                  onPressed: goToNextStep,
                  backgroundColor: AppColors.orangeprimary,
                  textColor: Colors.white,
                ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              if (currentStep == 0) {
                Navigator.pop(context);
              } else {
                goToPreviousStep();
              }
            },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: Color(0xFFE5E7EB)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              l.cancel,
              style: const TextStyle(color: Color(0xFF4B5563), fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}