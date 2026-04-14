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
    color: AppColors.orangeprimary,
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

  // ── Payment & Wallet Styles ──
  static TextStyle paymentTitleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 24,
    height: 30 / 24,
    color: AppColors.greyDark,
  );

  static TextStyle paymentSubtitleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 21 / 14,
    color: AppColors.greySecondary,
  );

  static TextStyle walletBalanceStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 48,
    color: Colors.white,
  );

  static TextStyle paymentButtonStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 24 / 16,
    color: Colors.white,
  );

  static TextStyle tripSummaryLabelStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 13,
    color: Color(0xFF4A5565),
    height: 19.5 / 13,
  );

  static TextStyle tripSummaryValueStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 13,
    color: Color(0xFF101828),
    height: 19.5 / 13,
  );

  static TextStyle tripSummaryCurrencyStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.orangeprimary,
    height: 21 / 14,
  );

  static TextStyle tripSummaryTotalStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w900,
    fontSize: 20,
    color: AppColors.orangeprimary,
    height: 30 / 20,
  );

  static TextStyle paymentMethodTitleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 15,
    color: Color(0xFF101828),
    height: 22.5 / 15,
  );

  static TextStyle paymentMethodSubtitleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: Color(0xFF6A7282),
    height: 18 / 12,
  );

  // ── Transaction Tile Styles ──
  static TextStyle transactionTitleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 15,
    height: 1.5,
    color: Color(0xFF101828),
  );

  static TextStyle transactionAmountStyle = const TextStyle(
    // Note: can be updated to accept color if dynamic
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 1.5,
    color: Color(0xFFE7000B),
  );

  static TextStyle transactionSubtitleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 13,
    height: 1.5,
    color: Color(0xFF6A7282),
  );

  static TextStyle transactionDateStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1.5,
    color: Color(0xFF99A1AF),
  );

  static TextStyle transactionStatusStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 11,
    height: 1.5,
    color: Color(0xFF00A63E),
  );

  // ── Rating Screen Styles ──
  static TextStyle ratingTitleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: Color(0xFF101828),
    height: 30 / 20,
  );

  static TextStyle ratingSubtitleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: Color(0xFF6A7282),
    height: 21 / 14,
  );

  static TextStyle ratingDriverNameStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: Color(0xFF101828),
  );

  static TextStyle ratingDriverRoleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: Color(0xFF6A7282),
  );

  static TextStyle ratingSectionTitleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: Color(0xFF101828),
  );
  
  static TextStyle ratingResultTextStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: AppColors.orangeprimary,
  );

  static TextStyle ratingCommentHintStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: Color(0xFF99A1AF),
  );

  static TextStyle ratingCharacterCountStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: Color(0xFF99A1AF),
  );

  static TextStyle ratingChipTextStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: Color(0xFF00A63E),
  );

  static TextStyle ratingChipUnselectedTextStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: Color(0xFF6A7282),
  );
  
  static TextStyle ratingFooterTextStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 10,
    color: Color(0xFF99A1AF),
  );

  // ── Profile Screen Styles ──
  static TextStyle profileNameStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 18,
    color: Colors.white,
  );

  static TextStyle profileMemberSinceStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: Color(0xCCFFFFFF),
  );

  static TextStyle profileStatStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: Colors.white,
  );

  static TextStyle profileSectionTitleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 14,
    color: AppColors.greyDark,
  );

  static TextStyle profileItemLabelStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 11,
    color: AppColors.greySecondary,
  );

  static TextStyle profileItemValueStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 13,
    color: AppColors.greyDark,
  );

  static TextStyle profileLogoutStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 15,
    color: AppColors.redColor,
  );
}
