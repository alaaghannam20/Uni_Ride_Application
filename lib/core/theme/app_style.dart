import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';

class AppStyle {
  static TextStyle skipstyle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0,
    color: AppColors.skiptextcolor,
  );

  static TextStyle languagestyle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 1.2,
    letterSpacing: 0,
    color: AppColors.languagecolor,
  );

  static TextStyle titlestyle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 24,
    height: 1.2,
    letterSpacing: 0,
    color: AppColors.titlecolor,
  );

  static TextStyle descriptionstyle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.5,
    letterSpacing: 0,
    color: AppColors.skiptextcolor,
  );

  static TextStyle custombuttonstyle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 18,
    height: 28 / 18,
    letterSpacing: 0,
    color: AppColors.white,
  );

  static TextStyle lablestyle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 1.33,
    letterSpacing: 0,
    color: AppColors.skiptextcolor,
  );

  static TextStyle hintstyle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.2,
    letterSpacing: 0,
    color: AppColors.languagecolor,
  );
  static TextStyle regestrationstyle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 18,
    height: 22.5 / 18,
    letterSpacing: 0,
    color: AppColors.languagecolor,
  );

  static TextStyle accountQuestionStyle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.43,
    letterSpacing: 0,
    color: AppColors.languagecolor,
  );

  static TextStyle loginNowStyle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 1.43,
    letterSpacing: 0,
    color: AppColors.orangeprimary,
  );

  static TextStyle passwordStyle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 11,
    height: 1.5,
    letterSpacing: 0,
    color: AppColors.orangeprimary
  );

  static TextStyle adminHeaderTitleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 28,
    height: 42 / 28,
    letterSpacing: 0,
    color: Color(0xFF101828),
  );

  static TextStyle adminHeaderDateStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 21 / 14,
    letterSpacing: 0,
    color: Color(0xFF6A7282),
  );

  static TextStyle adminSearchInputStyle = const TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    color: Color(0xFF101828),
  );

  static TextStyle adminSearchHintStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: Color(0xFF99A1AF),
    height: 1,
  );

  static TextStyle adminFilterTextStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 21 / 14,
    color: Color(0xFF4A5565),
  );


  static TextStyle adminSidebarLogoTitleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: Color(0xFF101828),
  );

  static TextStyle adminSidebarLogoSubtitleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: Color(0xFF6A7282),
  );

  static TextStyle adminSidebarMenuItemStyle(bool isActive) => TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 21 / 14,
    color: isActive ? const Color(0xFFCF8307) : const Color(0xFF4A5565),
  );

  static TextStyle adminSidebarBadgeStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    fontSize: 10,
    color: Colors.white,
  );

  static TextStyle adminSidebarAvatarInitialStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 14,
    color: Colors.white,
  );

  static TextStyle adminSidebarUserNameStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 21 / 14,
    color: Color(0xFF101828),
  );

  static TextStyle adminSidebarUserEmailStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 18 / 12,
    color: Color(0xFF6A7282),
  );

  static TextStyle adminSidebarLogoutStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 13,
    height: 19.5 / 13,
    color: Color(0xFF4A5565),
  );

  // ── Admin Card Styles (Approvals, Drivers, etc.) ──
  static TextStyle adminCardNameStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: Color(0xFF101828),
  );

  static TextStyle adminCardTimeStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: Color(0xFF99A1AF),
  );

  static TextStyle adminCardContactStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: Color(0xFF6A7282),
  );

  static TextStyle adminCardSectionTitleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: Color(0xFF6A7282),
  );

  static TextStyle adminCardInfoLabelStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: Color(0xFF6A7282),
  );

  static TextStyle adminCardInfoValueStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: Color(0xFF101828),
  );

  static TextStyle adminCardActionButtonStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
}

