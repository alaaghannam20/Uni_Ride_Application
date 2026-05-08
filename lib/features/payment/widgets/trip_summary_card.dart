import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
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
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.bgSubtle,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.tripSummary,
            style: AppStyle.lablestyle.copyWith(color: context.textPrimary),
          ),
          const SizedBox(height: 16),
          _buildRow(context, l10n.route, route),
          const SizedBox(height: 12),
          _buildRow(context, l10n.dateTime, dateTime),
          const SizedBox(height: 12),
          _buildRow(context, l10n.numberOfSeats, '$seats ${l10n.students}'), // Using students as unit for now
          const SizedBox(height: 12),
          _buildRow(context, l10n.pricePerSeat, '${l10n.ils}$pricePerSeat'),
          Divider(height: 24, color: context.borderColor),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.totalAmount,
                style: AppStyle.lablestyle.copyWith(fontSize: 16, color: context.textPrimary),
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

  Widget _buildRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppStyle.tripSummaryLabelStyle.copyWith(color: context.textSecondary),
        ),
        Text(
          value,
          style: AppStyle.tripSummaryValueStyle.copyWith(color: context.textPrimary),
        ),
      ],
    );
  }
}
