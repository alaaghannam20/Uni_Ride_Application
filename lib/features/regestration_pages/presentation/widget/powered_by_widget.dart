import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class PoweredByWidget extends StatelessWidget {
  const PoweredByWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Text(
          AppLocalizations.of(context)!.poweredBy,
          style: AppStyle.lablestyle.copyWith(
            fontWeight: FontWeight.w400,
            color: AppColors.languagecolor,
          ),
        ),

        const SizedBox(width: 7),

        Text(
          AppLocalizations.of(context)!.ptukEngineering,
          style: AppStyle.lablestyle.copyWith(
            color: AppColors.orangeprimary,
          ),
        ),

      ],
    );
  }
}