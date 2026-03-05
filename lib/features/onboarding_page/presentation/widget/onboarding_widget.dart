import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';

class OnboardingWidget extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingWidget({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imgW = screenWidth * (366 / 430);
    final imgH = imgW * (194.785 / 366);
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: imgW,
            height: imgH,
            child: Image.asset(image , fit: BoxFit.contain,)
            ),
          const SizedBox(height: 40),

          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppStyle.titlestyle,
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: screenWidth * 0.75,
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: AppStyle.descriptionstyle,
            ),
          ),
        ],
      ),
    );
  }
}
