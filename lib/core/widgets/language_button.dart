import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/app_language_provider.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class LanguageButton extends StatelessWidget {
  final bool showText;
  const LanguageButton({super.key, this.showText = true});

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<AppLanguageProvider>();
    final screenWidth = MediaQuery.of(context).size.width;
    final isLarge = screenWidth >= 600;

    final hPad   = isLarge ? 16.0 : 10.0;
    final vPad   = isLarge ? 10.0 :  7.0;
    final iconSz = isLarge ? 20.0 : 16.0;
    final textStyle = isLarge
        ? AppStyle.languagestyle.copyWith(fontSize: 14)
        : AppStyle.languagestyle;

    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () async {
        await context.read<AppLanguageProvider>().toggleLocale();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
        decoration: BoxDecoration(
          color: context.bgCard,
          border: Border.all(color: context.borderColor, width: 1),
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(color: Color(0x19000000), blurRadius: 3, offset: Offset(0, 1)),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showText)
              Text(
                languageProvider.isArabic
                    ? AppLocalizations.of(context)!.en
                    : AppLocalizations.of(context)!.ar,
                style: textStyle,
              ),
            if (showText) const SizedBox(width: 6),
            Icon(Icons.language, size: iconSz, color: AppColors.splashcolor),
          ],
        ),
      ),
    );
  }
}
