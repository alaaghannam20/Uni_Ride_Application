import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';

class PoweredByWidget extends StatelessWidget {
  const PoweredByWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Text(
          'Powered by ',
          style: AppStyle.lablestyle.copyWith(
            fontWeight: FontWeight.w400,
            color: AppColors.languagecolor,
          ),
        ),

        const SizedBox(width: 7),

        Text(
          'PTUK Engineering',
          style: AppStyle.lablestyle.copyWith(
            color: AppColors.orangeprimary,
          ),
        ),

      ],
    );
  }
}