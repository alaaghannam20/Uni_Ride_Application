import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/features/payment/widgets/trip_summary_card.dart';
import 'package:uni_ride_application/features/payment/widgets/payment_method_tile.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int _selectedMethod = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: AppColors.greyBackground,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.greyDark),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        title: Text(
          l10n.payment,
          style: AppStyle.paymentTitleStyle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TripSummaryCard(
                route: "PTUK University → City Center",
                dateTime: "Today, March 2, 2:30 PM",
                seats: 3,
                pricePerSeat: 8,
                totalAmount: 24,
              ),
              const SizedBox(height: 32),
              Text(
                l10n.paymentMethod,
                style: AppStyle.lablestyle.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 16),
              PaymentMethodTile(
                title: "Credit / Debit Card",
                subtitle: "Pay securely with your card",
                icon: Icons.credit_card,
                isSelected: _selectedMethod == 0,
                onTap: () => setState(() => _selectedMethod = 0),
              ),
              const SizedBox(height: 12),
              PaymentMethodTile(
                title: l10n.ptukWallet,
                subtitle: "Balance: ${l10n.ils}45.00",
                icon: Icons.account_balance_wallet_outlined,
                isSelected: _selectedMethod == 1,
                onTap: () => setState(() => _selectedMethod = 1),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(
          top: 16.6,
          left: 24,
          right: 24,
          bottom: 32,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: AppColors.greyLight, width: 0.62),
          ),
        ),
        child: InkWell(
          onTap: () {
            // Handle Payment
          },
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.orangeprimary,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                "${l10n.confirmPayment} · ${l10n.ils}24",
                style: AppStyle.paymentButtonStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
