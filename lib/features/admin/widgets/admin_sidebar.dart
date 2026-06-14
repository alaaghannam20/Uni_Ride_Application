import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/admin_provider.dart';
import 'package:uni_ride_application/core/provider/auth_provider.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/storage/app_prefs.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class AdminSidebar extends StatefulWidget {
  final String activeRoute;

  const AdminSidebar({super.key, required this.activeRoute});

  @override
  State<AdminSidebar> createState() => _AdminSidebarState();
}

class _AdminSidebarState extends State<AdminSidebar> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<AdminProvider>();
      if (provider.pendingApprovals.isEmpty && provider.state == AdminState.idle) {
        provider.fetchPendingApprovals();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale   = AppLocalizations.of(context)!;
    final user     = context.watch<AuthProvider>().user;
    final fullName = user?.fullName ?? locale.adminUser;
    final email    = user?.email    ?? locale.adminEmail;
    final initial  = fullName.isNotEmpty ? fullName[0].toUpperCase() : 'A';

    return Container(
      width: 287,
      decoration: BoxDecoration(
        color: context.bgCard,
        border: Border(
          right: BorderSide(color: context.borderColor, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 97,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: context.borderColor, width: 1),
              ),
            ),
            padding: const EdgeInsets.only(top: 24, right: 24, bottom: 1, left: 24),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.orangeprimary,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.shield_outlined, color: Colors.white),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      locale.ptukAdmin,
                      style: AppStyle.adminSidebarTitle(context),
                    ),
                    Text(
                      locale.ptukTransport,
                      style: AppStyle.adminSidebarSubtitle(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<AdminProvider>(
              builder: (context, provider, child) {
                return ListView(
                  padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
                  children: [
                    _buildMenuItem(
                      context,
                      title: locale.overview,
                      icon: Icons.show_chart_rounded,
                      route: '/AdminOverview',
                      isActive: widget.activeRoute == '/AdminOverview',
                    ),
                    const SizedBox(height: 4),
                    _buildMenuItem(
                      context,
                      title: locale.pendingApprovals,
                      icon: Icons.check_circle_outline,
                      route: '/AdminPendingApprovals',
                      isActive: widget.activeRoute == '/AdminPendingApprovals',
                      badge: provider.pendingApprovals.isNotEmpty
                          ? provider.pendingApprovals.length.toString()
                          : null,
                    ),
                    const SizedBox(height: 4),
                    _buildMenuItem(
                      context,
                      title: locale.drivers,
                      icon: Icons.directions_car_outlined,
                      route: '/AdminDrivers',
                      isActive: widget.activeRoute == '/AdminDrivers',
                    ),
                    const SizedBox(height: 4),
                    _buildMenuItem(
                      context,
                      title: locale.universityMembers,
                      icon: Icons.people_outline,
                      route: '/AdminStudents',
                      isActive: widget.activeRoute == '/AdminStudents',
                    ),
                    const SizedBox(height: 4),
                    _buildMenuItem(
                      context,
                      title: locale.trips,
                      icon: Icons.trending_up,
                      route: '/AdminTrips',
                      isActive: widget.activeRoute == '/AdminTrips',
                    ),
                    const SizedBox(height: 4),
                    _buildMenuItem(
                      context,
                      title: locale.settings,
                      icon: Icons.settings_outlined,
                      route: '/AdminSettings',
                      isActive: widget.activeRoute == '/AdminSettings',
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            height: 124.5,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: context.borderColor, width: 1),
              ),
            ),
            padding: const EdgeInsets.only(top: 17, right: 16, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [AppColors.orangeprimary, AppColors.adminGradientEnd],
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(initial, style: AppStyle.adminSidebarAvatarInitialStyle),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(fullName, style: AppStyle.adminSidebarUsername(context)),
                          Text(email,    style: AppStyle.adminSidebarEmail(context)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 39.5,
                  child: OutlinedButton(
                    onPressed: () async {
                      await AppPrefs.logout();
                      if (context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(context, Routes.signIn, (route) => false);
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      side: const BorderSide(color: Colors.transparent),
                      backgroundColor: context.isDark ? AppColors.errorRed.withValues(alpha: 0.15) : AppColors.lightRedBg,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.logout, size: 16, color: AppColors.errorRed),
                        const SizedBox(width: 8),
                        Text(
                          locale.logOut,
                          style: AppStyle.adminSidebarLogoutStyle.copyWith(color: AppColors.errorRed),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required String title,
    required IconData icon,
    required String route,
    required bool isActive,
    String? badge,
  }) {
    final textColor = isActive ? AppColors.orangeprimary : AppColors.adminTextSecondary;
    final bgColor = isActive ? AppColors.adminActiveBG : Colors.transparent;

    return Container(
      width: 255,
      height: 45,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            if (!isActive) {
              Navigator.pushNamed(context, route);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(icon, color: textColor, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: AppStyle.adminSidebarMenuItem(context, isActive),
                  ),
                ),
                if (badge != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.redColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      badge,
                      style: AppStyle.adminSidebarBadgeStyle,
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
