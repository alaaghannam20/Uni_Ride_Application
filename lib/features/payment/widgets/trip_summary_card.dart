import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class TripSummaryCard extends StatelessWidget {
  final String route;
  final String dateTime;
  final int seats;
  final double pricePerSeat;
  final double totalAmount;

  const TripSummaryCard({
    super.key,
    required this.route,
    required this.dateTime,
    required this.seats,
    required this.pricePerSeat,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: 382,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.greyBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.tripSummary,
            style: AppStyle.lablestyle.copyWith(color: (Color(0xFF101828))),
          ),
          const SizedBox(height: 16),
          _buildRow(l10n.route, route),
          const SizedBox(height: 12),
          _buildRow(l10n.dateTime, dateTime),
          const SizedBox(height: 12),
          _buildRow(l10n.numberOfSeats, '$seats ${l10n.students}'), // Using students as unit for now
          const SizedBox(height: 12),
          _buildRow(l10n.pricePerSeat, '${l10n.ils}$pricePerSeat'),
          const Divider(height: 24, color: AppColors.dividerColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.totalAmount,
                style: AppStyle.lablestyle.copyWith(fontSize: 16),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: l10n.ils,
                      style: AppStyle.tripSummaryCurrencyStyle,
                    ),
                    TextSpan(
                      text: totalAmount.toStringAsFixed(0),
                      style: AppStyle.tripSummaryTotalStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppStyle.tripSummaryLabelStyle,
        ),
        Text(
          value,
          style: AppStyle.tripSummaryValueStyle,
        ),
      ],
    );
  }
}
