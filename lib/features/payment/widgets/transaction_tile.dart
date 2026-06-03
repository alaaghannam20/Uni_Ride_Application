import 'package:flutter/material.dart';
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

    switch (type) {
      case TransactionType.payment:
        iconBackgroundColor = const Color(0xFFFEF2F2);
        iconColor = const Color(0xFFEF4444);
        iconData = Icons.arrow_outward;
        amountColor = const Color(0xFFEF4444);
        break;
      case TransactionType.topUp:
        iconBackgroundColor = const Color(0xFFEFF6FF);
        iconColor = const Color(0xFF3B82F6);
        iconData = Icons.add;
        amountColor = const Color(0xFF12B76A);
        break;
      case TransactionType.refund:
        iconBackgroundColor = const Color(0xFFECFDF3);
        iconColor = const Color(0xFF12B76A);
        iconData = Icons.call_received;
        amountColor = const Color(0xFF12B76A);
        break;
    }

    return Container(
      width: 345,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.greyLight, width: 0.61),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
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
                        style: AppStyle.transactionTitleStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      amount,
                      style: AppStyle.transactionAmountStyle.copyWith(
                        color: amountColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: AppStyle.transactionSubtitleStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(dateTime, style: AppStyle.transactionDateStyle),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        status,
                        style: AppStyle.transactionStatusStyle,
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
