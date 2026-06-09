import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/app_language_provider.dart';
import 'package:uni_ride_application/core/provider/app_theme_provider.dart';
import 'package:uni_ride_application/core/provider/profile_provider.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/storage/app_prefs.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';
import 'package:uni_ride_application/features/carpool/carpool_reviews_screen.dart';
import 'package:uni_ride_application/core/provider/one_signal_service.dart';

class CarpoolProfileScreen extends StatefulWidget {
  const CarpoolProfileScreen({super.key});

  @override
  State<CarpoolProfileScreen> createState() => _CarpoolProfileScreenState();
}

class _CarpoolProfileScreenState extends State<CarpoolProfileScreen> {
  final _oneSignal = OneSignalService();
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _notificationsEnabled = _oneSignal.isSubscribed;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().fetchCarpoolProfile();
    });
  }

  Future<void> _toggleNotifications(bool val) async {
    await _oneSignal.setSubscribed(val);
    if (mounted) setState(() => _notificationsEnabled = val);
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
      backgroundColor: context.bgColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ────────────────────────────────────────────────
            _CarpoolHeader(
              name:             name,
              initial:          initial,
              profileImagePath: profile?.profilePicturePath,
              statusLabel:      l.carpoolActiveStatus,
              ratingLabel:      l.rating,
              tripsLabel:       l.totalTrips,
              earnedLabel:      l.earned,
              ratingValue:      rating,
              tripsValue:       trips,
              earnedValue:      earned,
            ),

            const SizedBox(height: 16),

            // ── My Reviews Row ────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CarpoolReviewsScreen()),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: context.bgCard,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: context.borderColor, width: 0.62),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40, height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.orangeprimary.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.star_rounded, size: 20, color: AppColors.orangeprimary),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'My Reviews',
                              style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 14, color: context.textPrimary),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                const Icon(Icons.star_rounded, size: 13, color: AppColors.orangeprimary),
                                const SizedBox(width: 4),
                                Text(
                                  rating,
                                  style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.orangeprimary),
                                ),
                                Text(
                                  '  •  See all feedback',
                                  style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: context.textSecondary),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.chevron_right, size: 20, color: context.textHint),
                    ],
                  ),
                ),
              ),
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
                    _IItem(
                      icon:     Icons.notifications_outlined,
                      title:    l.notifications,
                      subtitle: l.manageYourAlerts,
                      trailing: Switch(
                        value:              _notificationsEnabled,
                        onChanged:          _toggleNotifications,
                        activeThumbColor:   Colors.white,
                        activeTrackColor:   AppColors.orangeprimary,
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: AppColors.borderadmincolor,
                      ),
                    ),
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
                        inactiveTrackColor: context.borderColor,
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
                    child: Text(l.version, style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: context.textSecondary)),
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
      decoration: BoxDecoration(color: context.bgSubtle, borderRadius: BorderRadius.circular(20)),
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
        child: Text(label, style: TextStyle(color: active ? Colors.white : context.textSecondary, fontWeight: FontWeight.w600, fontSize: 10)),
      ),
    );
  }
}

// ── Header Card ───────────────────────────────────────────────────────────────
class _CarpoolHeader extends StatelessWidget {
  final String  name, initial, statusLabel;
  final String  ratingLabel, tripsLabel, earnedLabel;
  final String  ratingValue, tripsValue, earnedValue;
  final String? profileImagePath;

  const _CarpoolHeader({
    required this.name, required this.initial, required this.statusLabel,
    required this.ratingLabel, required this.tripsLabel, required this.earnedLabel,
    required this.ratingValue, required this.tripsValue, required this.earnedValue,
    this.profileImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    colors: [AppColors.orangeprimary, AppColors.primaryGradientEnd],
                  ),
                  boxShadow: [BoxShadow(color: AppColors.orangeprimary.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))],
                ),
                alignment: Alignment.center,
                child: profileImagePath != null
                    ? Image.network(
                        'http://uniride.runasp.net/$profileImagePath',
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
                  Text(name,        style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 20, height: 1.5, color: context.textPrimary)),
                  Text(statusLabel, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 14, height: 1.5, color: context.textSecondary)),
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
class _SLabel extends StatelessWidget {
  final String text;
  const _SLabel({required this.text});
  @override
  Widget build(BuildContext context) => Text(
    text.toUpperCase(),
    style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 13, letterSpacing: 0.32, color: context.textSecondary),
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
        color: context.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.borderColor, width: 0.62),
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
                    decoration: BoxDecoration(color: context.bgSubtle, shape: BoxShape.circle),
                    child: Icon(items[i].icon, size: 20, color: context.textSecondary),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(items[i].title, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 14, height: 1.5, color: context.textPrimary)),
                        const SizedBox(height: 2),
                        Text(items[i].subtitle, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 13, height: 1.5, color: context.textSecondary)),
                      ],
                    ),
                  ),
                  items[i].trailing ?? Icon(Icons.chevron_right, size: 20, color: context.textHint),
                ],
              ),
            ),
            if (i < items.length - 1)
              Divider(indent: 68, height: 1, thickness: 0.62, color: context.borderColor),
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
        color: context.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightRedBorder, width: 0.62),
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
