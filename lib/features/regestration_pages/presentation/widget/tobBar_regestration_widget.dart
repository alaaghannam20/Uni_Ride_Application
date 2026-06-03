import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/widgets/language_button.dart';

class TobbarRegestrationWidget extends StatelessWidget {
  final String? title;

  const TobbarRegestrationWidget({
    super.key,
    this.title,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      automaticallyImplyLeading: false,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,

      title: title != null
          ? Text(
              title!,
              textAlign: TextAlign.center,
              style: AppStyle.regestrationstyle,
            )
          : null,
      centerTitle: true,

      elevation: 0,

      actions: const [LanguageButton(showText: false)],

  
    );
  }
}
