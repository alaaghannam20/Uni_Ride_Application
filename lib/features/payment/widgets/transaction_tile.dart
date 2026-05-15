import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';

enum TransactionType { payment, topUp, refund }

class TransactionTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String dateTime;
  final String amount;
  final String status;
  final TransactionType type;

  const TransactionTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.dateTime,
    required this.amount,
    required this.status,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    Color iconBackgroundColor;
    Color iconColor;
    IconData iconData;
    Color amountColor;
    Color statusBgColor;
    Color statusTextColor;

    final isDark = context.isDark;

    switch (type) {
      case TransactionType.payment:
        iconColor = AppColors.adminErrorText;
        iconBackgroundColor = isDark ? iconColor.withValues(alpha: 0.15) : AppColors.adminErrorBG;
        iconData = Icons.arrow_outward;
        amountColor = AppColors.adminErrorText;
        statusBgColor = isDark ? iconColor.withValues(alpha: 0.15) : AppColors.adminErrorBG;
        statusTextColor = AppColors.adminErrorText;
        break;
      case TransactionType.topUp:
        iconColor = AppColors.adminInfoText;
        iconBackgroundColor = isDark ? iconColor.withValues(alpha: 0.15) : AppColors.adminInfoBG;
        iconData = Icons.add;
        amountColor = AppColors.adminSuccessText;
        statusTextColor = AppColors.adminSuccessText;
        statusBgColor = isDark ? statusTextColor.withValues(alpha: 0.15) : AppColors.adminSuccessBG;
        break;
      case TransactionType.refund:
        iconColor = AppColors.adminSuccessText;
        iconBackgroundColor = isDark ? iconColor.withValues(alpha: 0.15) : AppColors.adminSuccessBG;
        iconData = Icons.call_received;
        amountColor = AppColors.adminSuccessText;
        statusTextColor = AppColors.adminSuccessText;
        statusBgColor = isDark ? statusTextColor.withValues(alpha: 0.15) : AppColors.adminSuccessBG;
        break;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: context.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.borderColor, width: 0.61),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: AppStyle.transactionTitle(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      amount,
                      style: AppStyle.transactionAmount(context, amountColor),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppStyle.transactionSubtitle(context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(dateTime, style: AppStyle.transactionDate(context)),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: statusBgColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        status,
                        style: AppStyle.transactionStatus(context, statusTextColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
