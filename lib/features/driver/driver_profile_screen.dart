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
    final l               = AppLocalizations.of(context)!;
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
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.bgCard,
                border: Border(bottom: BorderSide(color: context.borderColor, width: 0.62)),
              ),
              padding: const EdgeInsets.fromLTRB(24, 56, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 40, height: 40,
                          decoration: BoxDecoration(color: context.bgSubtle, shape: BoxShape.circle),
                          child: Icon(Icons.arrow_back, size: 20, color: context.textPrimary),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        width: 56, height: 56,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [AppColors.orangeprimary, AppColors.primaryGradientEnd],
                          ),
                          boxShadow: [BoxShadow(color: AppColors.orangeprimary.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))],
                        ),
                        alignment: Alignment.center,
                        child: profile?.profilePicturePath != null
                            ? Image.network(
                                'http://uniride.runasp.net/${profile!.profilePicturePath}',
                                fit: BoxFit.cover,
                                width: 56,
                                height: 56,
                                errorBuilder: (_, _, _) => Text(initial, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 22, color: Colors.white)),
                              )
                            : Text(initial, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 22, color: Colors.white)),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 20, height: 1.5, color: context.textPrimary)),
                          Text(l.driverActiveStatus, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 14, height: 1.5, color: context.textSecondary)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      _StatCell(value: rating, label: l.rating),
                      const SizedBox(width: 12),
                      _StatCell(value: trips,  label: l.totalTrips),
                      const SizedBox(width: 12),
                      _StatCell(value: earned, label: l.earned),
                    ],
                  ),
                ],
              ),
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
                    _InfoItem(icon: Icons.person_outline,  title: l.fullName,     subtitle: name),
                    _InfoItem(icon: Icons.phone_outlined,  title: l.phoneNumber,  subtitle: phone),
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
                    _InfoItem(icon: Icons.notifications_outlined, title: l.notifications, subtitle: l.manageYourAlerts),
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
                    _InfoItem(icon: Icons.credit_card_outlined,   title: l.paymentMethods,  subtitle: l.manageWithdrawals),
                    _InfoItem(icon: Icons.shield_outlined,        title: l.privacySecurity, subtitle: l.controlYourData),
                  ]),

                  const SizedBox(height: 24),

                  // ── Support ──────────────────────────────────────────
                  _SectionLabel(text: l.support),
                  const SizedBox(height: 8),
                  _CardGroup(items: [
                    _InfoItem(icon: Icons.help_outline, title: l.helpSupport, subtitle: l.faqsAndContactUs),
                  ]),

                  const SizedBox(height: 24),

                  // ── Log Out ──────────────────────────────────────────
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: context.bgCard,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.lightRedBorder, width: 0.62),
                    ),
                    child: InkWell(
                      onTap: () async {
                        await AppPrefs.logout();
                        if (context.mounted) Navigator.pushNamedAndRemoveUntil(context, Routes.signIn, (r) => false);
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        child: Row(
                          children: [
                            Container(
                              width: 40, height: 40,
                              decoration: const BoxDecoration(color: AppColors.adminErrorBG, shape: BoxShape.circle),
                              child: const Icon(Icons.logout, color: AppColors.errorRed, size: 20),
                            ),
                            const SizedBox(width: 16),
                            Text(l.logOut, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.errorRed)),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

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
      decoration: BoxDecoration(color: context.bgSubtle, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () => context.read<AppLanguageProvider>().setLocale('en'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: !isArabic ? AppColors.orangeprimary : Colors.transparent, borderRadius: BorderRadius.circular(20)),
              child: Text('EN', style: TextStyle(color: !isArabic ? Colors.white : context.textSecondary, fontWeight: FontWeight.w600, fontSize: 10)),
            ),
          ),
          GestureDetector(
            onTap: () => context.read<AppLanguageProvider>().setLocale('ar'),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: isArabic ? AppColors.orangeprimary : Colors.transparent, borderRadius: BorderRadius.circular(20)),
              child: Text('AR', style: TextStyle(color: isArabic ? Colors.white : context.textSecondary, fontWeight: FontWeight.w600, fontSize: 10)),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Stat Cell ─────────────────────────────────────────────────────────────────

class _StatCell extends StatelessWidget {
  final String value;
  final String label;
  const _StatCell({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(color: context.bgSubtle, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Text(value, textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 18, color: context.textPrimary)),
            const SizedBox(height: 4),
            Text(label, textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 12, color: context.textSecondary)),
          ],
        ),
      ),
    );
  }
}

// ── Section Label ─────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 13, letterSpacing: 0.32, color: context.textSecondary),
    );
  }
}

// ── Card Group ────────────────────────────────────────────────────────────────

class _CardGroup extends StatelessWidget {
  final List<_InfoItem> items;
  const _CardGroup({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.borderColor, width: 0.62),
      ),
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            _InfoRow(item: items[i]),
            if (i < items.length - 1) Divider(indent: 68, height: 1, thickness: 0.62, color: context.borderColor),
          ],
        ],
      ),
    );
  }
}

// ── Info Item + Row ───────────────────────────────────────────────────────────

class _InfoItem {
  final IconData icon;
  final String   title;
  final String   subtitle;
  final Widget?  trailing;
  const _InfoItem({required this.icon, required this.title, required this.subtitle, this.trailing});
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
            width: 40, height: 40,
            decoration: BoxDecoration(color: context.bgSubtle, shape: BoxShape.circle),
            child: Icon(item.icon, size: 20, color: context.textSecondary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title,    style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 14, color: context.textPrimary)),
                const SizedBox(height: 2),
                Text(item.subtitle, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 13, color: context.textSecondary)),
              ],
            ),
          ),
          item.trailing ?? Icon(Icons.chevron_right, size: 20, color: context.textHint),
        ],
      ),
    );
  }
}
