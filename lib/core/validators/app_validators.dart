import 'package:uni_ride_application/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AppValidators {
  static String? validateEmail(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.enterEmail;
    }
    if (!value.contains('@')) {
      return AppLocalizations.of(context)!.invalidEmail;
    }
    return null;
  }

  static String? validatePassword(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.enterPassword;
    }
    if (value.length < 8) {
      return AppLocalizations.of(context)!.minimum8Chars;
    }
    return null;
  }

  static String? validateConfirmPassword(
    BuildContext context,
    String? value,
    String originalPassword,
  ) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.enterPassword;
    }
    if (value != originalPassword) {
      return AppLocalizations.of(context)!.passwordsDoNotMatch;
    }
    return null;
  }

  static String? validateFullName(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.enterFullName;
    }
    return null;
  }

  static String? validatePhone(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.enterPhone;
    }
    if (value.length < 10) {
      return AppLocalizations.of(context)!.invalidPhone;
    }
    return null;
  }

  static String? validateCarType(BuildContext context, String? value) {
    if (value == null) {
      return AppLocalizations.of(context)!.enterCarType;
    }
    return null;
  }

  static String? validateCarModel(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.enterCarModel;
    }
    return null;
  }

  static String? validateNumberOfSeats(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.enterNumberOfSeats;
    }
    return null;
  }

  static String? validateLicenseNumber(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.enterLicenseNumber;
    }
    return null;
  }

  static String? validatePlateNumber(BuildContext context, String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppLocalizations.of(context)!.enterPlateNumber;
    }
    return null;
  }


}