import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/models/user_model.dart';
import 'package:uni_ride_application/core/provider/auth_provider.dart';
import 'package:uni_ride_application/core/provider/profile_provider.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/storage/app_prefs.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

void showUserDrawer(BuildContext context) {
  context.read<ProfileProvider>().fetchMemberProfile();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => SizedBox(
      height: MediaQuery.of(context).size.height * 0.88,
      child: const UserDrawerSheet(),
    ),
  );
}

class UserDrawerSheet extends StatelessWidget {
  const UserDrawerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l        = AppLocalizations.of(context)!;
    final auth     = context.watch<AuthProvider>();
    final profile  = context.watch<ProfileProvider>().memberProfile;
    final isCarpool = auth.userType == UserType.carpool;
    final profileRoute = isCarpool ? Routes.carpoolProfile : Routes.profile;

    final String fullName = profile?.fullName ?? auth.user?.fullName ?? '...';
    final String email = profile?.email ?? auth.user?.email ?? '...';
    final String initial = fullName.isNotEmpty ? fullName[0].toUpperCase() : 'U';
    final int totalTrips = profile?.totalTrips ?? 0;
    final int rewardPoints = profile?.rewardPoints ?? 0;

    return Container(
      decoration: BoxDecoration(
        color: context.bgWhite,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.orangeprimary, AppColors.primaryGradientEnd],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    // أفاتار المستخدم
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, profileRoute);
                      },
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(color: context.bgWhite, shape: BoxShape.circle),
                        clipBehavior: Clip.antiAlias,
                        child: (profile?.profilePicturePath ?? auth.user?.profileImage) != null
                            ? Image.network(
                                'http://uniride.runasp.net/${profile?.profilePicturePath ?? auth.user!.profileImage}',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stack) => Center(
                                  child: Text(initial, style: const TextStyle(color: AppColors.orangeprimary, fontWeight: FontWeight.bold, fontSize: 22)),
                                ),
                              )
                            : Center(
                                child: Text(initial, style: const TextStyle(color: AppColors.orangeprimary, fontWeight: FontWeight.bold, fontSize: 22)),
                              ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fullName,
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            email,
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              _chip('★ $rewardPoints pts'),
                              const SizedBox(width: 8),
                              _chip('$totalTrips trips'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // زر الإغلاق
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
                    child: const Icon(Icons.close, color: Colors.white, size: 16),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ─── Wallet Balance ────────────────────────────────────────
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, Routes.myWallet);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: context.isDark ? context.bgSubtle : AppColors.walletCardBg,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: context.isDark ? context.borderColor : AppColors.walletCardBorder),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.orangeprimary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.account_balance_wallet_outlined, color: AppColors.orangeprimary, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text(l.walletBalance, style: TextStyle(fontSize: 12, color: context.textSecondary)),
                        const SizedBox(height: 2),
                        Text('₪${profile?.walletBalance.toStringAsFixed(2) ?? '0.00'}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: context.textPrimary)),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: context.textHint),
                ],
              ),
            ),
          ),

          const SizedBox(height: 8),

          // ─── Menu Items ────────────────────────────────────────────
          _menuItem(
            context,
            icon: Icons.person_outline,
            iconColor: AppColors.adminInfoText,
            iconBg: context.isDark ? context.bgSubtle : AppColors.adminInfoBG,
            title: l.myProfile,
            subtitle: l.viewAndEditProfile,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, profileRoute);
            },
          ),
          _menuItem(
            context,
            icon: Icons.access_time,
            iconColor: AppColors.emeraldGreen,
            iconBg: context.isDark ? context.bgSubtle : AppColors.emeraldGreenBg,
            title: l.my_trips,
            subtitle: l.viewTripHistory,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, Routes.home, arguments: {'tabIndex': 1});
            },
          ),
          _menuItem(
            context,
            icon: Icons.card_giftcard_outlined,
            iconColor: AppColors.amberWarning,
            iconBg: context.isDark ? context.bgSubtle : AppColors.amberWarningBg,
            title: l.rewardsAndPoints,
            subtitle: l.rewards,
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, Routes.home, arguments: {'tabIndex': 3});
            },
          ),

          Divider(height: 24, color: context.borderColor),

          // ─── Log Out ───────────────────────────────────────────────
          GestureDetector(
            onTap: () async {
              await AppPrefs.logout();
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(context, Routes.signIn, (route) => false);
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.logout, color: AppColors.errorRed, size: 20),
                const SizedBox(width: 8),
                Text(l.logOut, style: const TextStyle(color: AppColors.errorRed, fontWeight: FontWeight.w600, fontSize: 15)),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ─── Footer ────────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 16, height: 16,
                decoration: const BoxDecoration(color: AppColors.orangeprimary, shape: BoxShape.circle),
                child: const Center(child: Text('P', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold))),
              ),
              const SizedBox(width: 6),
              Text('Powered by PTUK Engineering', style: TextStyle(fontSize: 11, color: context.textSecondary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }

  Widget _menuItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: context.textPrimary)),
                  Text(subtitle, style: TextStyle(fontSize: 12, color: context.textSecondary)),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: context.textHint, size: 20),
          ],
        ),
      ),
    );
  }
}
