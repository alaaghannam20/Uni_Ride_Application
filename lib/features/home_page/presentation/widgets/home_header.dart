import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/auth_provider.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/features/home_page/presentation/widgets/user_drawer_sheet.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final user = context.watch<AuthProvider>().user;

    final fullName = user?.fullName ?? '';
    final firstName = fullName.split(' ').first;
    final initial = fullName.isNotEmpty ? fullName[0].toUpperCase() : '?';
    final imageUrl = user?.profileImage != null
        ? 'http://uniride.runasp.net/${user!.profileImage}'
        : null;

    return Container(
      width: double.infinity,
      height: 105.98,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${l.hello_user}$firstName 👋',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 21 / 14,
                    color: Color(0xFF6A7282),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l.where_to_today,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                    height: 35 / 28,
                    color: Color(0xFF101828),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 14, color: AppColors.orangeprimary),
                    const SizedBox(width: 4),
                    const Text(
                      'Tulkarm, Kadori St',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        height: 18 / 12,
                        color: Color(0xFF364153),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => showUserDrawer(context),
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: AppColors.orangeprimary,
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.antiAlias,
              child: imageUrl != null
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Center(
                        child: Text(
                          initial,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Text(
                        initial,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
