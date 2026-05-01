import 'package:flutter/material.dart';
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableH = constraints.maxHeight;
        final availableW = constraints.maxWidth;
        // الصورة تأخذ 45% من الارتفاع المتاح بحد أقصى 320px
        final imgH = (availableH * 0.45).clamp(0.0, 320.0);
        final imgW = (imgH * (366 / 194.785)).clamp(0.0, availableW * 0.9);

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: imgW,
              height: imgH,
              child: Image.asset(image, fit: BoxFit.contain),
            ),
            SizedBox(height: availableH * 0.05),
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
              width: availableW * 0.75,
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: AppStyle.descriptionstyle,
              ),
            ),
          ],
        );
      },
    );
  }
}
