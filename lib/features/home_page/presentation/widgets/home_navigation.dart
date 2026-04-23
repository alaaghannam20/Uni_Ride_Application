import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class HomeNavigation extends StatelessWidget {
  final int activeIndex;
  final Function(int) onTabChanged;

  const HomeNavigation({
    super.key,
    required this.activeIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Container(
      height: 67.99,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(top: 16),
      child: Row(
        children: [
          _navItem(0, l.find_trips, Icons.explore_outlined),
          const SizedBox(width: 12),
          _navItem(1, l.my_trips, Icons.access_time),
          const SizedBox(width: 12),
          _navItem(2, l.carpool, Icons.people_outline),
          const SizedBox(width: 12),
          _navItem(3, l.rewards, Icons.card_giftcard),
        ],
      ),
    );
  }

  Widget _navItem(int index, String label, IconData icon) {
    final isActive = activeIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTabChanged(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isActive ? AppColors.orangeprimary : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isActive ? AppColors.orangeprimary : const Color(0xFFE5E5E5)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20, color: isActive ? Colors.white : const Color(0xFF101828)),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: isActive ? Colors.white : const Color(0xFF101828),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
