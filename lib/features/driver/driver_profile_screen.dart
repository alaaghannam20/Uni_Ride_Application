import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/app_language_provider.dart';
import 'package:uni_ride_application/core/provider/app_theme_provider.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/provider/profile_provider.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/storage/app_prefs.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class DriverProfileScreen extends StatefulWidget {
  const DriverProfileScreen({super.key});

  @override
  State<DriverProfileScreen> createState() => _DriverProfileScreenState();
}

class _DriverProfileScreenState extends State<DriverProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().fetchDriverProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l              = AppLocalizations.of(context)!;
    final languageProvider = context.watch<AppLanguageProvider>();
    final isArabic         = languageProvider.isArabic;
    final themeProvider    = context.watch<AppThemeProvider>();
    final isLightMode      = themeProvider.isLightMode;
    final profile          = context.watch<ProfileProvider>().driverProfile;

    final name    = profile?.fullName ?? '...';
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    final phone   = profile?.phoneNumber ?? '...';
    final email   = profile?.email ?? '...';
    final vehicle = profile?.vehicleModel ?? '...';
    final plate   = profile?.plateNumber ?? '...';
    final rating  = profile?.rating.toStringAsFixed(1) ?? '0.0';
    final trips   = '${profile?.totalTrips ?? 0}';
    final earned  = '₪${profile?.earned ?? 0}';

    return Scaffold(
      backgroundColor: context.bgColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ────────────────────────────────────────────────────
            _HeaderCard(
              name:        name,
              initial:     initial,
              statusLabel: l.driverActiveStatus,
              ratingLabel: l.rating,
              tripsLabel:  l.totalTrips,
              earnedLabel: l.earned,
              ratingValue: rating,
              tripsValue:  trips,
              earnedValue: earned,
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Personal Information ─────────────────────────────
                  _SectionLabel(text: l.personalInformation),
                  const SizedBox(height: 8),
                  _CardGroup(items: [
                    _InfoItem(icon: Icons.person_outline,  title: l.fullName,    subtitle: name),
                    _InfoItem(icon: Icons.phone_outlined,  title: l.phoneNumber, subtitle: phone),
                    _InfoItem(icon: Icons.email_outlined,  title: l.emailAddress, subtitle: email),
                  ]),

                  const SizedBox(height: 24),

                  // ── Vehicle Information ──────────────────────────────
                  _SectionLabel(text: l.vehicleInformation),
                  const SizedBox(height: 8),
                  _CardGroup(items: [
                    _InfoItem(icon: Icons.directions_car_outlined, title: l.vehicleDetails, subtitle: vehicle),
                    _InfoItem(icon: Icons.location_on_outlined,    title: l.plateNumber,    subtitle: plate),
                  ]),

                  const SizedBox(height: 24),

                  // ── App Settings ─────────────────────────────────────
                  _SectionLabel(text: l.appSettings),
                  const SizedBox(height: 8),
                  _CardGroup(items: [
                    _InfoItem(
                      icon:     Icons.notifications_outlined,
                      title:    l.notifications,
                      subtitle: l.manageYourAlerts,
                    ),
                    _InfoItem(
                      icon:     Icons.shield_outlined,
                      title:    l.privacySecurity,
                      subtitle: l.controlYourData,
                    ),
                    _InfoItem(
                      icon:     Icons.credit_card_outlined,
                      title:    l.paymentMethods,
                      subtitle: l.manageWithdrawals,
                    ),
                    _InfoItem(
                      icon:     Icons.language,
                      title:    l.languageLabel,
                      subtitle: isArabic ? l.ar : l.en,
                      trailing: _buildLanguageToggle(context, isArabic),
                    ),
                    _InfoItem(
                      icon:     isLightMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                      title:    l.theme,
                      subtitle: isLightMode ? l.lightMode : l.darkMode,
                      trailing: Switch(
                        value:              isLightMode,
                        onChanged:          (val) => themeProvider.setLightMode(val),
                        activeThumbColor:   Colors.white,
                        activeTrackColor:   AppColors.orangeprimary,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: AppColors.borderadmincolor,
                      ),
                    ),
                  ]),

                  const SizedBox(height: 24),

                  // ── Support ──────────────────────────────────────────
                  _SectionLabel(text: l.support),
                  const SizedBox(height: 8),
                  _CardGroup(items: [
                    _InfoItem(
                      icon:     Icons.help_outline,
                      title:    l.helpSupport,
                      subtitle: l.faqsAndContactUs,
                    ),
                  ]),

                  const SizedBox(height: 24),

                  // ── Log Out ──────────────────────────────────────────
                  _LogOutButton(label: l.logOut),

                  const SizedBox(height: 24),

                  // ── Version ──────────────────────────────────────────
                  Center(
                    child: Text(
                      l.version,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: AppColors.greySecondary,
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageToggle(BuildContext context, bool isArabic) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.greyLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => context.read<AppLanguageProvider>().setLocale('en'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: !isArabic ? AppColors.orangeprimary : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'EN',
                style: TextStyle(
                  color:      !isArabic ? Colors.white : AppColors.greySecondary,
                  fontWeight: FontWeight.w600,
                  fontSize:   10,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => context.read<AppLanguageProvider>().setLocale('ar'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isArabic ? AppColors.orangeprimary : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'AR',
                style: TextStyle(
                  color:      isArabic ? Colors.white : AppColors.greySecondary,
                  fontWeight: FontWeight.w600,
                  fontSize:   10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Header Card  (spec: 430 × 224.48 | padding 24 | gap 24)
// ─────────────────────────────────────────────────────────────────────────────
class _HeaderCard extends StatelessWidget {
  final String name;
  final String initial;
  final String statusLabel;
  final String ratingLabel;
  final String tripsLabel;
  final String earnedLabel;
  final String ratingValue;
  final String tripsValue;
  final String earnedValue;

  const _HeaderCard({
    required this.name,
    required this.initial,
    required this.statusLabel,
    required this.ratingLabel,
    required this.tripsLabel,
    required this.earnedLabel,
    required this.ratingValue,
    required this.tripsValue,
    required this.earnedValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.greyLight, width: 0.62),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 56, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back arrow + Avatar + Name/Status
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: AppColors.greyBackground,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back, size: 20, color: AppColors.greyDark),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.orangeprimary, AppColors.primaryGradientEnd],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.orangeprimary.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  initial,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name — Bold 22px #101828
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      height: 1.5,
                      color: AppColors.greyDark,
                    ),
                  ),
                  // Status — Regular 14px #6A7282
                  Text(
                    statusLabel,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.5,
                      color: AppColors.greySecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Stats row
          Row(
            children: [
              _StatCell(value: ratingValue, label: ratingLabel),
              const SizedBox(width: 12),
              _StatCell(value: tripsValue,  label: tripsLabel),
              const SizedBox(width: 12),
              _StatCell(value: earnedValue, label: earnedLabel),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  final String value;
  final String label;
  const _StatCell({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.greyBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Value — Bold 20px #101828
            Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 18,
                height: 1.5,
                color: AppColors.greyDark,
              ),
            ),
            const SizedBox(height: 4),
            // Label — Regular 11px #6A7282
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                height: 1.5,
                color: AppColors.greySecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section Label — Regular 13px uppercase letter-spacing 0.32 #6A7282
// ─────────────────────────────────────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        fontSize: 13,
        height: 19.5 / 13,
        letterSpacing: 0.32,
        color: AppColors.greySecondary,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Card group — App Settings spec: border-radius 16, border 0.62, box-shadow
// ─────────────────────────────────────────────────────────────────────────────
class _CardGroup extends StatelessWidget {
  final List<_InfoItem> items;
  const _CardGroup({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.greyLight, width: 0.62),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            _InfoRow(item: items[i]),
            if (i < items.length - 1)
              const Divider(indent: 68, height: 1, thickness: 0.62, color: AppColors.greyLight),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Data model + row widget
// ─────────────────────────────────────────────────────────────────────────────
class _InfoItem {
  final IconData  icon;
  final String    title;
  final String    subtitle;
  final Widget?   trailing;
  const _InfoItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
  });
}

class _InfoRow extends StatelessWidget {
  final _InfoItem item;
  const _InfoRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.greyBackground,
              shape: BoxShape.circle,
            ),
            child: Icon(item.icon, size: 20, color: AppColors.grey364),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title — Medium 14px #101828
                Text(
                  item.title,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    height: 1.5,
                    color: AppColors.greyDark,
                  ),
                ),
                const SizedBox(height: 2),
                // Subtitle — Regular 13px #6A7282
                Text(
                  item.subtitle,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    height: 1.5,
                    color: AppColors.greySecondary,
                  ),
                ),
              ],
            ),
          ),
          item.trailing ?? const Icon(Icons.chevron_right, size: 20, color: AppColors.adminTextMuted),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Log Out — spec: border-radius 16, border #FFE2E2, box-shadow
// ─────────────────────────────────────────────────────────────────────────────
class _LogOutButton extends StatelessWidget {
  final String label;
  const _LogOutButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightRedBorder, width: 0.62),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () async {
        await AppPrefs.logout();
        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(context, Routes.signIn, (route) => false);
        }
      },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: AppColors.adminErrorBG,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.logout, color: AppColors.errorRed, size: 20),
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  height: 1.5,
                  color: AppColors.errorRed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}