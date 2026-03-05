import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.backgroundcontainerlanguage,
        border: Border.all(color: AppColors.bordercontainerlanguage, width: 1),
        borderRadius: BorderRadius.circular(30),

        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),

            blurRadius: 3,

            offset: Offset(0, 1),
          ),
        ],
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,

        children: [
          Text('عربي', style: AppStyle.languagestyle),

          SizedBox(width: 4),

          Icon(Icons.language, size: 16, color: AppColors.splashcolor),
        ],
      ),
    );
  }
}
