import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';

class TobbarRegestrationWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;

  const TobbarRegestrationWidget({
    super.key,
    required this.title,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 81,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: Color(0x85E0E0E0), width: 1)),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 16,
            left: 16,
            child: GestureDetector(
              onTap: onBackPressed ?? () => Navigator.pop(context),
              child: Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                color: Colors.transparent,
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                  color: AppColors.languagecolor,
                ),
              ),
            ),
          ),

          Positioned(
            top: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: AppStyle.regestrationstyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
