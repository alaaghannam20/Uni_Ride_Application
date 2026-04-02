import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/widgets/language_button.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class TobbarRegestrationWidget extends StatelessWidget {
  final String? title;
  final bool showLoginButton;

  const TobbarRegestrationWidget({
    super.key,
    this.title,
    this.showLoginButton = false,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      automaticallyImplyLeading: false,

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

      leading: showLoginButton
          ? GestureDetector(
              onTap: () => Navigator.pushNamed(context, Routes.signIn),
              child: Container(
                margin: const EdgeInsets.all(9),
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.backgroundcontainerlanguage,
                  border: Border.all(
                    color: AppColors.bordercontainerlanguage,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 3,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.account_circle_sharp,
                  size: 18,
                  color: AppColors.splashcolor,
                ),
              ),
            )
          : null,
    );
  }
}
