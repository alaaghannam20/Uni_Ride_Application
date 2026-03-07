import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';

class TobbarRegestrationWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;

  const TobbarRegestrationWidget({super.key, required this.title, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 401,
      height: 81,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0x80E0E0E0),
            width: 1,
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: GestureDetector(
              onTap: onBackPressed ?? () => Navigator.pop(context),
              child: const SizedBox(
                width: 28,
                height: 28,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 18,
                  color: AppColors.languagecolor,
                ),
              ),
            ),
          ),

          Center(
            child: Text(
              title,
              style: AppStyle.regestrationstyle,
            ),
          ),
        ],
      ),
    );
  }
}
