import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/app_language_provider.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class LanguageButton extends StatelessWidget {
  final bool showText;
  const LanguageButton({super.key, this.showText = true});

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<AppLanguageProvider>();

    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () async {
        await context.read<AppLanguageProvider>().toggleLocale();
      },

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
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

        child: Row(
          mainAxisSize: MainAxisSize.min,

          children: [
            if (showText)
              Text(
                languageProvider.isArabic
                    ? AppLocalizations.of(context)!.en
                    : AppLocalizations.of(context)!.ar,
                style: AppStyle.languagestyle,
              ),

            if (showText) const SizedBox(width: 4),

            const Icon(Icons.language, size: 16, color: AppColors.splashcolor),
          ],
        ),
      ),
    );
  }
}
