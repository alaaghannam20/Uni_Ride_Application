import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/models/reward_model.dart';
import 'package:uni_ride_application/core/provider/reward_provider.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';
import 'package:uni_ride_application/features/home_page/presentation/widgets/reward_cards.dart';

class RewardsTab extends StatefulWidget {
  const RewardsTab({super.key});

  @override
  State<RewardsTab> createState() => _RewardsTabState();
}

class _RewardsTabState extends State<RewardsTab> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RewardProvider>().fetchMyRewards();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Consumer<RewardProvider>(
      builder: (context, provider, _) {
        if (provider.state == RewardState.loading && provider.rewardData == null) {
          return const Center(child: CircularProgressIndicator(color: AppColors.orangeprimary));
        }

        final data = provider.rewardData;

        return RefreshIndicator(
          onRefresh: () => provider.fetchMyRewards(),
          color: AppColors.orangeprimary,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // 1. Points Summary Card
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
                      color: const Color(0xFFCF8307).withValues(alpha:0.3),
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
                            color: Colors.white.withValues(alpha:0.9),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              '${data?.totalPoints ?? 0}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(Icons.star, color: Colors.white.withValues(alpha:0.8), size: 32),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(child: _buildInfoBox(l.level, data?.level ?? 'Member')),
                            const SizedBox(width: 12),
                            Expanded(child: _buildInfoBox(l.rank, '#${data?.rank ?? 0}')),
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
                          color: Colors.white.withValues(alpha:0.2),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.emoji_events_outlined, color: Colors.white, size: 28),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 2. Refer a Friend Card
              _buildReferCard(l, data),
              const SizedBox(height: 32),

              // 3. Achievements Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.achievements,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold, color: context.textPrimary)),
                  const SizedBox(height: 16),
                  if (data != null && data.achievements.isNotEmpty)
                    ...data.achievements.map((ach) {
                      double progress = ach.target > 0 ? ach.current / ach.target : 0.0;
                      IconData icon = ach.id == 'first_ride' ? Icons.bolt : Icons.emoji_events_outlined;
                      String title = ach.id == 'first_ride' ? l.ach_first_ride_title : (ach.id == 'top_rider' ? l.ach_top_rider_title : ach.id);
                      String subtitle = ach.id == 'first_ride' ? l.ach_first_ride_sub : (ach.id == 'top_rider' ? l.ach_top_rider_sub : '');
                      
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AchievementCard(
                          title: title,
                          subtitle: subtitle,
                          progress: progress,
                          progressLabel: '${ach.current} / ${ach.target}',
                          points: '+${ach.points}',
                          icon: icon,
                          isCompleted: ach.completed,
                        ),
                      );
                    }),
                  if (data == null || data.achievements.isEmpty)
                    Center(child: Text('No achievements found.', style: TextStyle(color: context.textHint))),
                ],
              ),
              const SizedBox(height: 32),

              // 4. Redeem Rewards Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.redeem_rewards,
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold, color: context.textPrimary)),
                  const SizedBox(height: 16),
                  _buildRedeemCard(
                    context,
                    title: l.rew_free_ride_title,
                    subtitle: l.rew_free_ride_sub,
                    points: '500',
                    percentage: '100% OFF',
                    type: 'FreeRide',
                  ),
                  const SizedBox(height: 12),
                  _buildRedeemCard(
                    context,
                    title: l.rew_half_off_title,
                    subtitle: l.rew_half_off_sub,
                    points: '250',
                    percentage: '50% OFF',
                    type: 'Discount50',
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildReferCard(AppLocalizations l, RewardModel? data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.bgSubtle,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.04),
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
                   color: context.isDark ? context.bgSubtle : AppColors.infoBlueBg,
                   borderRadius: BorderRadius.circular(10),
                 ),
                 child: Icon(
                   Icons.people_outline,
                   color: context.isDark ? AppColors.lightBlueAccent : AppColors.infoBlue,
                   size: 20,
                 ),
               ),
               const SizedBox(width: 12),
               Expanded(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text(
                       l.refer_a_friend,
                       style: TextStyle(
                         fontSize: 16,
                         fontWeight: FontWeight.bold,
                         color: context.textPrimary,
                       ),
                     ),
                     Text(
                       '${data?.referralCount ?? 0} friends joined • +${data?.referralPoints ?? 0} pts earned',
                       style: TextStyle(
                         fontSize: 12,
                         color: context.textSecondary,
                       ),
                     ),
                   ],
                 ),
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
                    color: context.bgSubtle,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      data?.referralCode ?? '---',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: context.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              InkWell(
                onTap: () {
                  final code = data?.referralCode;
                  if (code != null && code.isNotEmpty) {
                    Clipboard.setData(ClipboardData(text: code));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Referral code copied to clipboard!'),
                        backgroundColor: Colors.green,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.orangeprimary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.copy, color: Colors.white, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRedeemCard(BuildContext context, {
    required String title,
    required String subtitle,
    required String points,
    required String percentage,
    required String type,
  }) {
    return InkWell(
      onTap: () async {
        final success = await context.read<RewardProvider>().redeemReward(type);
        if (success && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Reward redeemed successfully!'), backgroundColor: Colors.green),
          );
        } else if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.read<RewardProvider>().errorMessage), backgroundColor: Colors.red),
          );
        }
      },
      child: RedeemCard(
        title: title,
        subtitle: subtitle,
        points: points,
        percentage: percentage,
      ),
    );
  }

  Widget _buildInfoBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
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