import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';
import 'package:uni_ride_application/features/home_page/presentation/widgets/reward_cards.dart';

class RewardsTab extends StatelessWidget {
  const RewardsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // 1. Points Summary Card (Orange Gradient)
        Container(
          width: double.infinity,
          height: 180,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFCF8307), Color(0xFFE09520)],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFCF8307).withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l.your_points,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text(
                        '1250',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(Icons.star, color: Colors.white.withOpacity(0.8), size: 32),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      _buildInfoBox(l.level, l.gold_member),
                      const SizedBox(width: 12),
                      _buildInfoBox(l.rank, '#42'),
                    ],
                  ),
                ],
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.emoji_events_outlined, color: Colors.white, size: 28),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // 2. Refer a Friend Card (White)
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFF3F4F6), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.people_outline, color: Color(0xFF2563EB), size: 20),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l.refer_a_friend,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF101828),
                        ),
                      ),
                      Text(
                        l.refer_sub,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF667085),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'AHMED2024',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            color: Color(0xFF344054),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.orangeprimary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.copy, color: Colors.white, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.trending_up, color: Color(0xFF12B76A), size: 14),
                    const SizedBox(width: 8),
                    Text(
                      l.friends_joined,
                      style: const TextStyle(
                        color: Color(0xFF027A48),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // 3. Achievements Section
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.achievements,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF101828))),
            const SizedBox(height: 16),
            AchievementCard(
              title: l.ach_first_ride_title,
              subtitle: l.ach_first_ride_sub,
              progress: 0.0,
              progressLabel: '0 / 1',
              points: '+50',
              icon: Icons.bolt,
              isCompleted: false,
            ),
            const SizedBox(height: 12),
            // ✅ التعديل هون
            AchievementCard(
              title: l.ach_top_rider_title,
              subtitle: l.ach_top_rider_sub,
              progress: 0 / 20,
              progressLabel: '0 / 20',
              points: '+300',
              icon: Icons.emoji_events_outlined,
              isCompleted: false,
            ),
          ],
        ),
        const SizedBox(height: 32),

        // 4. Redeem Rewards Section
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.redeem_rewards,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF101828))),
            const SizedBox(height: 16),
            RedeemCard(
                title: l.rew_free_ride_title,
                subtitle: l.rew_free_ride_sub,
                points: '500',
                percentage: '100% OFF'),
            const SizedBox(height: 12),
            RedeemCard(
                title: l.rew_half_off_title,
                subtitle: l.rew_half_off_sub,
                points: '250',
                percentage: '50% OFF'),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}