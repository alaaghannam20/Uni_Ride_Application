import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';

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
    color: AppColors.greyDark,
  );

  static TextStyle adminHeaderDateStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 21 / 14,
    letterSpacing: 0,
    color: AppColors.greySecondary,
  );

  static TextStyle adminSearchInputStyle = const TextStyle(
    fontFamily: 'Inter',
    fontSize: 14,
    color: AppColors.greyDark,
  );

  static TextStyle adminSearchHintStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.greyHint,
    height: 1,
  );

  static TextStyle adminFilterTextStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 21 / 14,
    color: AppColors.adminTextSecondary,
  );

  static TextStyle adminSidebarLogoTitleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: AppColors.greyDark,
  );

  static TextStyle adminSidebarLogoSubtitleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.greySecondary,
  );

  static TextStyle adminSidebarMenuItemStyle(bool isActive) => TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 21 / 14,
    color: isActive ? AppColors.orangeprimary : AppColors.adminTextSecondary,
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
    color: AppColors.greyDark,
  );

  static TextStyle adminSidebarUserEmailStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 18 / 12,
    color: AppColors.greySecondary,
  );

  static TextStyle adminSidebarLogoutStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 13,
    height: 19.5 / 13,
    color: AppColors.adminTextSecondary,
  );

  // ── Admin Card Styles (Approvals, Drivers, etc.) ──
  static TextStyle adminCardNameStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: AppColors.greyDark,
  );

  static TextStyle adminCardTimeStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.greyHint,
  );

  static TextStyle adminCardContactStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.greySecondary,
  );

  static TextStyle adminCardSectionTitleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: AppColors.greySecondary,
  );

  static TextStyle adminCardInfoLabelStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.greySecondary,
  );

  static TextStyle adminCardInfoValueStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: AppColors.greyDark,
  );

  static TextStyle adminCardActionButtonStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );

  // ── Context-aware Admin Styles (Dark / Light Mode) ──────────────────────
  static TextStyle adminHeaderTitle(BuildContext ctx, {double fontSize = 28}) =>
      TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: fontSize, color: ctx.textPrimary);

  static TextStyle adminHeaderDate(BuildContext ctx, {double fontSize = 14}) =>
      TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: fontSize, color: ctx.textSecondary);

  static TextStyle adminCardName(BuildContext ctx, {double fontSize = 14}) =>
      TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: fontSize, color: ctx.textPrimary);

  static TextStyle adminCardContact(BuildContext ctx) =>
      TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 12, color: ctx.textSecondary);

  static TextStyle adminCardSection(BuildContext ctx) =>
      TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 12, letterSpacing: 0.5, color: ctx.textSecondary);

  static TextStyle adminCardValue(BuildContext ctx, {double fontSize = 14}) =>
      TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: fontSize, color: ctx.textPrimary);

  static TextStyle adminSidebarTitle(BuildContext ctx) =>
      TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 16, color: ctx.textPrimary);

  static TextStyle adminSidebarSubtitle(BuildContext ctx) =>
      TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 12, color: ctx.textSecondary);

  static TextStyle adminSidebarMenuItem(BuildContext ctx, bool isActive) => TextStyle(
      fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 14,
      color: isActive ? AppColors.orangeprimary : ctx.textSecondary);

  static TextStyle adminSidebarUsername(BuildContext ctx) =>
      TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 14, color: ctx.textPrimary);

  static TextStyle adminSidebarEmail(BuildContext ctx) =>
      TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 12, color: ctx.textSecondary);

  static TextStyle adminSettingsSectionTitle(BuildContext ctx) =>
      TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 18, color: ctx.textPrimary);

  static TextStyle adminSettingsItemTitle(BuildContext ctx) =>
      TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 14, color: ctx.textPrimary);

  static TextStyle adminSettingsItemDesc(BuildContext ctx) =>
      TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 13, color: ctx.textSecondary);

  static TextStyle paymentTitleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 24,
    height: 30 / 24,
    color: AppColors.greyDark,
  );

  static TextStyle paymentTitle(BuildContext ctx) =>
      TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 24, height: 30 / 24, color: ctx.textPrimary);

  static TextStyle paymentSubtitleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 21 / 14,
    color: AppColors.greySecondary,
  );

  static TextStyle paymentSubtitle(BuildContext ctx) =>
      TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 14, height: 21 / 14, color: ctx.textSecondary);

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
    color: AppColors.adminTextSecondary,
    height: 19.5 / 13,
  );

  static TextStyle tripSummaryValueStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 13,
    color: AppColors.greyDark,
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
    color: AppColors.greyDark,
    height: 22.5 / 15,
  );

  static TextStyle paymentMethodTitle(BuildContext ctx) =>
      TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 15, color: ctx.textPrimary, height: 22.5 / 15);

  static TextStyle paymentMethodSubtitleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.greySecondary,
    height: 18 / 12,
  );

  static TextStyle paymentMethodSubtitle(BuildContext ctx) =>
      TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 12, color: ctx.textSecondary, height: 18 / 12);

  // ── Transaction Tile Styles ──
  static TextStyle transactionTitleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 15,
    height: 1.5,
    color: AppColors.greyDark,
  );

  static TextStyle transactionTitle(BuildContext ctx) =>
      TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 15, height: 1.5, color: ctx.textPrimary);

  static TextStyle transactionAmountStyle = const TextStyle(
    // Note: can be updated to accept color if dynamic
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 1.5,
    color: AppColors.errorRed,
  );

  static TextStyle transactionAmount(BuildContext ctx, Color color) =>
      TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 16, height: 1.5, color: color);

  static TextStyle transactionSubtitleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 13,
    height: 1.5,
    color: AppColors.greySecondary,
  );

  static TextStyle transactionSubtitle(BuildContext ctx) =>
      TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 13, height: 1.5, color: ctx.textSecondary);

  static TextStyle transactionDateStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1.5,
    color: AppColors.greyHint,
  );

  static TextStyle transactionDate(BuildContext ctx) =>
      TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 12, height: 1.5, color: ctx.textHint);

  static TextStyle transactionStatusStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 11,
    height: 1.5,
    color: AppColors.successSolid,
  );

  static TextStyle transactionStatus(BuildContext ctx, Color color) =>
      TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 11, height: 1.5, color: color);

  // ── Rating Screen Styles ──
  static TextStyle ratingTitleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: AppColors.greyDark,
    height: 30 / 20,
  );

  static TextStyle ratingSubtitleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.greySecondary,
    height: 21 / 14,
  );

  static TextStyle ratingDriverNameStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color: AppColors.greyDark,
  );

  static TextStyle ratingDriverRoleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.greySecondary,
  );

  static TextStyle ratingSectionTitleStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: AppColors.greyDark,
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
    color: AppColors.greyHint,
  );

  static TextStyle ratingCharacterCountStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.greyHint,
  );

  static TextStyle ratingChipTextStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: AppColors.successSolid,
  );

  static TextStyle ratingChipUnselectedTextStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: AppColors.greySecondary,
  );
  
  static TextStyle ratingFooterTextStyle = const TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 10,
    color: AppColors.greyHint,
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

  // ── Context-aware Profile Styles ──
  static TextStyle profileSectionTitle(BuildContext ctx) =>
      TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 14, color: ctx.textPrimary);

  static TextStyle profileItemLabel(BuildContext ctx) =>
      TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 11, color: ctx.textSecondary);

  static TextStyle profileItemValue(BuildContext ctx) =>
      TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 13, color: ctx.textPrimary);

  static TextStyle profileLogout(BuildContext ctx) =>
      const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.redColor);

  static TextStyle ratingTitle(BuildContext ctx) =>
      TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 20, color: ctx.textPrimary);

  static TextStyle ratingSubtitle(BuildContext ctx) =>
      TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 14, color: ctx.textSecondary);

  // ── Common Body Styles ──
  static const TextStyle headingLarge = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 28,
    color: AppColors.greyDark,
  );

  static const TextStyle headingMedium = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: AppColors.greyDark,
  );

  static const TextStyle headingSmall = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    fontSize: 15,
    color: AppColors.greyDark,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 15,
    color: AppColors.greyDark,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: AppColors.greyDark,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 13,
    color: AppColors.greySecondary,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: AppColors.greyHint,
  );

  static const TextStyle captionMedium = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: AppColors.greySecondary,
  );

  static const TextStyle priceStyle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 20,
    color: AppColors.orangeprimary,
  );

  static const TextStyle priceLarge = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 24,
    color: AppColors.greyDark,
  );

  static const TextStyle labelStyle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: AppColors.greyDark,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    fontSize: 15,
    color: AppColors.greyDark,
  );

  static const TextStyle errorStyle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: Colors.red,
  );

  static const TextStyle emptyStateStyle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: AppColors.greyHint,
  );
}
