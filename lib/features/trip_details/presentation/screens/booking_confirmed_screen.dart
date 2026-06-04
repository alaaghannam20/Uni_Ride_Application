import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/models/booking_model.dart';
import 'package:uni_ride_application/core/provider/payment_provider.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';

import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class BookingConfirmedScreen extends StatefulWidget {
  final String? sessionId;
  final bool preConfirmed;
  const BookingConfirmedScreen({super.key, this.sessionId, this.preConfirmed = false});

  @override
  State<BookingConfirmedScreen> createState() => _BookingConfirmedScreenState();
}

class _BookingConfirmedScreenState extends State<BookingConfirmedScreen> {
  BookingModel? _confirmedBooking;
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _confirm();
  }

  Future<void> _confirm() async {
    final provider = context.read<PaymentProvider>();

    // Wallet payment — booking already confirmed
    if (widget.preConfirmed) {
      if (mounted) {
        setState(() {
          _confirmedBooking = provider.confirmedBooking;
          _isLoading = false;
        });
      }
      return;
    }

    // Stripe payment — confirm via session
    try {
      final success = await provider.confirmBooking(widget.sessionId ?? '');
      if (mounted) {
        setState(() {
          _confirmedBooking = success ? provider.confirmedBooking : null;
          _error     = success ? '' : provider.errorMessage;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error     = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(color: AppColors.orangeprimary),
              const SizedBox(height: 20),
              Text(l.booking_confirmed_sub, style: TextStyle(color: context.textSecondary)),
            ],
          ),
        ),
      );
    }

    if (_error.isNotEmpty || _confirmedBooking == null) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              Text(AppLocalizations.of(context)!.confirmationFailed, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(_error, textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocalizations.of(context)!.goBack),
              ),
            ],
          ),
        ),
      );
    }

    final booking = _confirmedBooking!;
    String formattedTime = booking.departureTime;
    try {
      final dt = DateTime.parse(booking.departureTime);
      formattedTime = '${dt.day}/${dt.month}/${dt.year}  •  ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (_) {}

    final initial = booking.driverName.isNotEmpty ? booking.driverName[0].toUpperCase() : '?';

    return Scaffold(
      backgroundColor: context.bgWhite,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          children: [
            // ── Success Icon ──────────────────────────────────────────
            Container(
              width: 80, height: 80,
              decoration: const BoxDecoration(color: AppColors.adminSuccessBG, shape: BoxShape.circle),
              child: const Icon(Icons.check_circle_outline, color: AppColors.adminSuccessText, size: 40),
            ),
            const SizedBox(height: 20),

            Text(l.booking_confirmed, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24, color: context.textPrimary)),
            const SizedBox(height: 8),
            Text(l.booking_confirmed_sub, style: TextStyle(color: context.textSecondary, fontSize: 14), textAlign: TextAlign.center),
            const SizedBox(height: 32),

            // ── Booking ID ────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: AppColors.walletCardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.amberWarningBg, width: 1.5),
              ),
              child: Column(
                children: [
                  Text(l.booking_id, style: TextStyle(color: context.textSecondary, fontSize: 12)),
                  const SizedBox(height: 6),
                  Text(booking.bookingCode, style: const TextStyle(color: AppColors.orangeprimary, fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Trip Details ──────────────────────────────────────────
            _CardContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.tripDetails, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: context.textPrimary)),
                  const SizedBox(height: 16),
                  _InfoRow(
                    icon: Icons.location_on_outlined,
                    label: l.route,
                    value: '${booking.pickupLocation} → ${booking.dropoffLocation}',
                  ),
                  const SizedBox(height: 16),
                  _InfoRow(
                    icon: Icons.calendar_today_outlined,
                    label: l.dateTime,
                    value: formattedTime,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Driver Details ────────────────────────────────────────
            _CardContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.driver_details, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: context.textPrimary)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        width: 44, height: 44,
                        decoration: const BoxDecoration(color: AppColors.orangeprimary, shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: booking.profilePicturePath != null
                            ? ClipOval(child: Image.network('http://uniride.runasp.net/${booking.profilePicturePath}', fit: BoxFit.cover, errorBuilder: (ctx, err, st) => Text(initial, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18))))
                            : Text(initial, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(booking.driverName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: context.textPrimary)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: context.bgSubtle, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Icon(Icons.directions_car_outlined, color: context.textSecondary, size: 18),
                        const SizedBox(width: 12),
                        Text(booking.vehicleModel, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: context.textPrimary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // ── Payment Status ────────────────────────────────────────
            _CardContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l.payment_status, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: context.textPrimary)),
                      const SizedBox(height: 4),
                      Text(booking.paymentStatus, style: TextStyle(color: context.textSecondary, fontSize: 12)),
                    ],
                  ),
                  RichText(
                    text: TextSpan(children: [
                      const TextSpan(text: '₪ ', style: TextStyle(color: AppColors.orangeprimary, fontSize: 14, fontWeight: FontWeight.bold)),
                      TextSpan(text: booking.totalAmount.toStringAsFixed(0), style: const TextStyle(color: AppColors.orangeprimary, fontSize: 22, fontWeight: FontWeight.bold)),
                    ]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: ElevatedButton(
            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, Routes.home, (r) => false),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.orangeprimary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            child: Text(l.back_to_home, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }
}

class _CardContainer extends StatelessWidget {
  final Widget child;
  const _CardContainer({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.borderColor, width: 1.5),
      ),
      child: child,
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label, value;
  const _InfoRow({required this.icon, required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(color: AppColors.amberWarningBg, shape: BoxShape.circle),
          child: Icon(icon, color: AppColors.orangeprimary, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(color: context.textSecondary, fontSize: 12)),
              const SizedBox(height: 2),
              Text(value, style: TextStyle(color: context.textPrimary, fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }
}
