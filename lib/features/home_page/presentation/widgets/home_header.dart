import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/auth_provider.dart';
import 'package:uni_ride_application/core/provider/notification_provider.dart';
import 'package:uni_ride_application/core/provider/profile_provider.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/features/home_page/presentation/widgets/user_drawer_sheet.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final user        = context.watch<AuthProvider>().user;
    final profile     = context.watch<ProfileProvider>().memberProfile;

    final fullName  = user?.fullName ?? '';
    final firstName = fullName.split(' ').first;
    final initial   = fullName.isNotEmpty ? fullName[0].toUpperCase() : '?';
    final imagePath = profile?.profilePicturePath ?? user?.profileImage;
    final imageUrl  = imagePath != null
        ? 'http://uniride.runasp.net/$imagePath'
        : null;

    return Container(
      width: double.infinity,
      height: 105.98,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: context.bgCard,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Greeting text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${l.hello_user}$firstName 👋',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 21 / 14,
                    color: context.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l.where_to_today,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                    height: 35 / 28,
                    color: context.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on,
                        size: 14, color: AppColors.orangeprimary),
                    const SizedBox(width: 4),
                    Text(
                      'Tulkarm, Kadori St',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        height: 18 / 12,
                        color: context.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Avatar + bell below
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () => showUserDrawer(context),
                child: Container(
                  width: 54,
                  height: 54,
                  decoration: const BoxDecoration(
                    color: AppColors.orangeprimary,
                    shape: BoxShape.circle,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: imageUrl != null
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) => Center(
                            child: Text(initial,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          ),
                        )
                      : Center(
                          child: Text(initial,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                        ),
                ),
              ),
              const SizedBox(height: 5),
              Consumer<NotificationProvider>(
                builder: (context, notifProvider, _) {
                  final count = notifProvider.unreadCount;
                  return GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, Routes.notifications),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: context.bgSubtle,
                            shape: BoxShape.circle,
                            border: Border.all(color: context.borderColor),
                          ),
                          child: Icon(
                            Icons.notifications_rounded,
                            size: 17,
                            color: context.textSecondary,
                          ),
                        ),
                        if (count > 0)
                          Positioned(
                            top: -4,
                            right: -4,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: AppColors.errorRed,
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(
                                  minWidth: 14, minHeight: 14),
                              child: Text(
                                count > 9 ? '9+' : '$count',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
