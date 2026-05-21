import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uni_ride_application/core/provider/payment_provider.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
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
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final tripId = args?['tripId'] as int? ?? 0;
    final route = args?['route'] as String? ?? "PTUK University → City Center";
    final dateTime = args?['dateTime'] as String? ?? "Today, March 2, 2:30 PM";
    final seats = args?['seats'] as int? ?? 1;
    final pricePerSeat = args?['pricePerSeat'] as double? ?? 0.0;
    final totalAmount = args?['totalAmount'] as double? ?? (seats * pricePerSeat);

    final paymentState = context.watch<PaymentProvider>().checkoutState;
    final isLoading = paymentState == PaymentState.loading;

    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        backgroundColor: context.appBarBg,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: context.bgSubtle,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: context.textPrimary),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        title: Text(
          l10n.payment,
          style: AppStyle.paymentTitle(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TripSummaryCard(
                route: route,
                dateTime: dateTime,
                seats: seats,
                pricePerSeat: pricePerSeat,
                totalAmount: totalAmount,
              ),
              const SizedBox(height: 32),
              Text(
                l10n.paymentMethod,
                style: AppStyle.profileSectionTitle(context).copyWith(fontSize: 18),
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
                subtitle: "Balance: ${l10n.ils}${context.watch<PaymentProvider>().wallet?.balance.toStringAsFixed(2) ?? '45.00'}",
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
        decoration: BoxDecoration(
          color: context.bgCard,
          border: Border(
            top: BorderSide(color: context.borderColor, width: 0.62),
          ),
        ),
        child: InkWell(
          onTap: isLoading ? null : () async {
            if (_selectedMethod == 0) {
              // Stripe Payment
              final session = await context.read<PaymentProvider>().startBookTrip(
                tripId: tripId,
                seatCount: seats,
              );
              if (!context.mounted) return;
              if (session == null) {
                final error = context.read<PaymentProvider>().errorMessage;
                final isNoSeats = error.toLowerCase().contains('seat') ||
                    error.toLowerCase().contains('available') ||
                    error.toLowerCase().contains('full');
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Booking Failed'),
                    content: Text(
                      isNoSeats
                          ? 'Sorry, this seat was just booked by another student. Please go back and check available seats.'
                          : error,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('Go Back'),
                      ),
                    ],
                  ),
                );
                return;
              }
              final uri = Uri.parse(session.checkoutUrl);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
                if (context.mounted) {
                  Navigator.pushNamed(context, Routes.bookingConfirmed, arguments: session.sessionId);
                }
              }
            } else {
              // Wallet Payment - Not fully implemented in provider yet
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Wallet payment coming soon!")),
              );
            }
          },
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.orangeprimary,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: isLoading 
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                  "${l10n.confirmPayment} · ${l10n.ils}${totalAmount.toStringAsFixed(0)}",
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
            ),
          ),
        ),
      ),
    );
  }
}
