import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/app_language_provider.dart';
import 'package:uni_ride_application/core/provider/app_theme_provider.dart';
import 'package:uni_ride_application/core/provider/profile_provider.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/storage/app_prefs.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class CarpoolProfileScreen extends StatefulWidget {
  const CarpoolProfileScreen({super.key});

  @override
  State<CarpoolProfileScreen> createState() => _CarpoolProfileScreenState();
}

class _CarpoolProfileScreenState extends State<CarpoolProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().fetchCarpoolProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l              = AppLocalizations.of(context)!;
    final langProvider   = context.watch<AppLanguageProvider>();
    final isArabic       = langProvider.isArabic;
    final themeProvider  = context.watch<AppThemeProvider>();
    final isLightMode    = themeProvider.isLightMode;
    final profile        = context.watch<ProfileProvider>().carpoolProfile;

    final name    = profile?.fullName ?? '...';
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    final phone   = profile?.phoneNumber ?? '...';
    final email   = profile?.email ?? '...';
    final vehicle = '${profile?.vehicleType ?? ''} ${profile?.vehicleModel ?? ''}'.trim();
    final plate   = profile?.plateNumber ?? '...';
    final seats   = '${profile?.seatCapacity ?? 0}';
    final rating  = profile?.rating.toStringAsFixed(1) ?? '0.0';
    final trips   = '${profile?.totalTrips ?? 0}';
    final earned  = '₪${profile?.earned ?? 0}';

    return Scaffold(
      backgroundColor: AppColors.greyBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ────────────────────────────────────────────────
            _CarpoolHeader(
              name:        name,
              initial:     initial,
              statusLabel: l.carpoolActiveStatus,
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
                  // ── Personal Information ─────────────────────────
                  _SLabel(text: l.personalInformation),
                  const SizedBox(height: 8),
                  _CGroup(items: [
                    _IItem(icon: Icons.person_outline,  title: l.fullName,    subtitle: name),
                    _IItem(icon: Icons.phone_outlined,  title: l.phoneNumber, subtitle: phone),
                    _IItem(icon: Icons.email_outlined,  title: l.emailAddress,subtitle: email),
                  ]),

                  const SizedBox(height: 24),

                  // ── Vehicle Information ──────────────────────────
                  _SLabel(text: l.vehicleInformation),
                  const SizedBox(height: 8),
                  _CGroup(items: [
                    _IItem(icon: Icons.directions_car_outlined, title: l.vehicleDetails, subtitle: vehicle.isEmpty ? '...' : vehicle),
                    _IItem(icon: Icons.pin_outlined,            title: l.plateNumber,    subtitle: plate),
                    _IItem(icon: Icons.event_seat_outlined,     title: l.numberOfSeats,  subtitle: seats),
                  ]),

                  const SizedBox(height: 24),

                  // ── App Settings ─────────────────────────────────
                  _SLabel(text: l.appSettings),
                  const SizedBox(height: 8),
                  _CGroup(items: [
                    _IItem(icon: Icons.notifications_outlined, title: l.notifications,   subtitle: l.manageYourAlerts),
                    _IItem(icon: Icons.shield_outlined,        title: l.privacySecurity, subtitle: l.controlYourData),
                    _IItem(
                      icon:     Icons.language,
                      title:    l.languageLabel,
                      subtitle: isArabic ? l.ar : l.en,
                      trailing: _langToggle(context, isArabic),
                    ),
                    _IItem(
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

                  // ── Support ──────────────────────────────────────
                  _SLabel(text: l.support),
                  const SizedBox(height: 8),
                  _CGroup(items: [
                    _IItem(icon: Icons.help_outline, title: l.helpSupport, subtitle: l.faqsAndContactUs),
                  ]),

                  const SizedBox(height: 24),

                  // ── Log Out ──────────────────────────────────────
                  _CLogOut(label: l.logOut),

                  const SizedBox(height: 24),

                  Center(
                    child: Text(l.version, style: const TextStyle(fontFamily: 'Inter', fontSize: 12, color: AppColors.greySecondary)),
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

  Widget _langToggle(BuildContext context, bool isArabic) {
    return Container(
      decoration: BoxDecoration(color: AppColors.greyLight, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _langBtn(context, 'EN', !isArabic, () => context.read<AppLanguageProvider>().setLocale('en')),
          _langBtn(context, 'AR', isArabic,  () => context.read<AppLanguageProvider>().setLocale('ar')),
        ],
      ),
    );
  }

  Widget _langBtn(BuildContext context, String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: active ? AppColors.orangeprimary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(label, style: TextStyle(color: active ? Colors.white : AppColors.greySecondary, fontWeight: FontWeight.w600, fontSize: 10)),
      ),
    );
  }
}

// ── Header Card ───────────────────────────────────────────────────────────────
class _CarpoolHeader extends StatelessWidget {
  final String name, initial, statusLabel;
  final String ratingLabel, tripsLabel, earnedLabel;
  final String ratingValue, tripsValue, earnedValue;

  const _CarpoolHeader({
    required this.name, required this.initial, required this.statusLabel,
    required this.ratingLabel, required this.tripsLabel, required this.earnedLabel,
    required this.ratingValue, required this.tripsValue, required this.earnedValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.greyLight, width: 0.62)),
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
                  decoration: const BoxDecoration(color: AppColors.greyBackground, shape: BoxShape.circle),
                  child: const Icon(Icons.arrow_back, size: 20, color: AppColors.greyDark),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 56, height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    colors: [AppColors.orangeprimary, AppColors.primaryGradientEnd],
                  ),
                  boxShadow: [BoxShadow(color: AppColors.orangeprimary.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))],
                ),
                alignment: Alignment.center,
                child: Text(initial, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 22, color: Colors.white)),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,        style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 20, height: 1.5, color: AppColors.greyDark)),
                  Text(statusLabel, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 14, height: 1.5, color: AppColors.greySecondary)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _Stat(value: ratingValue, label: ratingLabel),
              const SizedBox(width: 12),
              _Stat(value: tripsValue,  label: tripsLabel),
              const SizedBox(width: 12),
              _Stat(value: earnedValue, label: earnedLabel),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String value, label;
  const _Stat({required this.value, required this.label});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(color: AppColors.greyBackground, borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [
            Text(value, textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.greyDark)),
            const SizedBox(height: 4),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.greySecondary)),
          ],
        ),
      ),
    );
  }
}

// ── Section Label ─────────────────────────────────────────────────────────────
class _SLabel extends StatelessWidget {
  final String text;
  const _SLabel({required this.text});
  @override
  Widget build(BuildContext context) => Text(
    text.toUpperCase(),
    style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 13, letterSpacing: 0.32, color: AppColors.greySecondary),
  );
}

// ── Card Group ────────────────────────────────────────────────────────────────
class _IItem {
  final IconData icon;
  final String   title;
  final String   subtitle;
  final Widget?  trailing;
  const _IItem({required this.icon, required this.title, required this.subtitle, this.trailing});
}

class _CGroup extends StatelessWidget {
  final List<_IItem> items;
  const _CGroup({required this.items});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.greyLight, width: 0.62),
        boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                children: [
                  Container(
                    width: 40, height: 40,
                    decoration: const BoxDecoration(color: AppColors.greyBackground, shape: BoxShape.circle),
                    child: Icon(items[i].icon, size: 20, color: AppColors.grey364),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(items[i].title, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 14, height: 1.5, color: AppColors.greyDark)),
                        const SizedBox(height: 2),
                        Text(items[i].subtitle, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 13, height: 1.5, color: AppColors.greySecondary)),
                      ],
                    ),
                  ),
                  items[i].trailing ?? const Icon(Icons.chevron_right, size: 20, color: AppColors.adminTextMuted),
                ],
              ),
            ),
            if (i < items.length - 1)
              const Divider(indent: 68, height: 1, thickness: 0.62, color: AppColors.greyLight),
          ],
        ],
      ),
    );
  }
}

// ── Log Out Button ────────────────────────────────────────────────────────────
class _CLogOut extends StatelessWidget {
  final String label;
  const _CLogOut({required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightRedBorder, width: 0.62),
        boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 8, offset: Offset(0, 2))],
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
                width: 40, height: 40,
                decoration: const BoxDecoration(color: AppColors.adminErrorBG, shape: BoxShape.circle),
                child: const Icon(Icons.logout, color: AppColors.errorRed, size: 20),
              ),
              const SizedBox(width: 16),
              Text(label, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 14, height: 1.5, color: AppColors.errorRed)),
            ],
          ),
        ),
      ),
    );
  }
}
