import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';

class OtpPinFieldWidget extends StatelessWidget {
  final ValueChanged<String> onCompleted; 
  final ValueChanged<String>? onChanged; 

  const OtpPinFieldWidget({
    super.key,
    required this.onCompleted, 
    this.onChanged, 
  });

  @override
  Widget build(BuildContext context) {
    return MaterialPinField( 
      length: 4,
      keyboardType: TextInputType.number,
      enableAutofill: true, 
      autofillHints: const [AutofillHints.oneTimeCode], 

      onChanged: (value) { 
        if (onChanged != null) {
          onChanged!(value);
        }
      },

      onCompleted: onCompleted, 

      theme: MaterialPinTheme( 
        shape: MaterialPinShape.outlined,
        cellSize: const Size(56, 56), 
        spacing: 8, 
        borderRadius: BorderRadius.circular(12),
        borderWidth: 1.2,
        focusedBorderWidth: 1.4,

        borderColor: context.borderColor,
        focusedBorderColor: AppColors.orangeprimary,
        filledBorderColor: context.borderColor,

        fillColor: context.bgCard,
        focusedFillColor: context.bgCard,
        filledFillColor: context.bgCard,

        textStyle: AppStyle.custombuttonstyle.copyWith(
          fontSize: 22,
          color: AppColors.skiptextcolor,
        ),

        cursorColor: AppColors.orangeprimary,
        showCursor: true,
        animateCursor: true,

        entryAnimation: MaterialPinAnimation.fade,
        animationDuration: const Duration(milliseconds: 200),
      ),
    );
  }
}