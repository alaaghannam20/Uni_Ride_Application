
import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/widgets/language_button.dart';

class TobBarWidget extends StatelessWidget {
  final bool showSkip;
  

  const TobBarWidget({
    super.key,
     this.showSkip = true,
   
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 30,
        left: 30,
        right: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'skip',
            style: AppStyle.skipstyle,
          ),
          LanguageButton(),
        ],
      ),
    );
  }
}