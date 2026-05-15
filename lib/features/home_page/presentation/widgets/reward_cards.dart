import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';

class AchievementCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress;
  final String progressLabel;
  final String points;
  final IconData icon;
  final bool isCompleted;

  const AchievementCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.progressLabel,
    required this.points,
    required this.icon,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.bgSubtle,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.borderColor, width: 0.62),
        boxShadow: context.isDark ? [] : [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(
                  color: isCompleted ? AppColors.orangeprimary : context.bgSubtle,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: isCompleted ? Colors.white : context.textHint, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: context.textPrimary)),
                    const SizedBox(height: 2),
                    Text(subtitle, style: TextStyle(color: context.textSecondary, fontSize: 11)),
                  ],
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star, size: 16, color: AppColors.orangeprimary),
                  const SizedBox(width: 4),
                  Text(points, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.orangeprimary)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(progressLabel, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: context.textSecondary)),
              Text('${(progress * 100).toInt()}%', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: context.textPrimary)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.0, end: progress),
              duration: const Duration(milliseconds: 1200),
              curve: Curves.easeOutCubic,
              builder: (context, val, _) => LinearProgressIndicator(
                value: val,
                backgroundColor: context.borderColor,
                color: AppColors.orangeprimary,
                minHeight: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RedeemCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String points;
  final String percentage;

  const RedeemCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.points,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.bgSubtle,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.borderColor),
        boxShadow: context.isDark ? [] : [BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: context.textPrimary)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: TextStyle(color: context.textSecondary, fontSize: 12)),
                  ],
                ),
              ),
              Container(
                width: 44, height: 44,
                decoration: const BoxDecoration(color: AppColors.orangeprimary, shape: BoxShape.circle),
                child: const Icon(Icons.redeem, color: Colors.white, size: 24),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: AppColors.orangeprimary, size: 16),
                  const SizedBox(width: 4),
                  Text('$points points', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: context.textPrimary)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: context.isDark ? AppColors.successDarkGreen.withValues(alpha: 0.2) : AppColors.successSolid.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(percentage, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: context.isDark ? AppColors.successLightGreen : AppColors.successDarkText)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
