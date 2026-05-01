import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/models/booking_model.dart';
import 'package:uni_ride_application/core/provider/booking_provider.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class MyTripsTab extends StatefulWidget {
  const MyTripsTab({super.key});

  @override
  State<MyTripsTab> createState() => _MyTripsTabState();
}

class _MyTripsTabState extends State<MyTripsTab> {
  int _filterIndex = 0; // 0: All, 1: Upcoming, 2: Completed, 3: Cancelled

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookingProvider>().fetchMyBookings();
    });
  }

  void _onFilterChanged(int index) => setState(() => _filterIndex = index);

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Consumer<BookingProvider>(
      builder: (context, provider, _) {
        final bookings = provider.myBookings;
        final upcoming  = bookings.where((b) => b.status == 'Confirmed' || b.status == 'Upcoming').toList();
        final completed = bookings.where((b) => b.status == 'Completed').toList();
        final cancelled = bookings.where((b) => b.status == 'Cancelled').toList();

        final List<BookingModel> filtered = switch (_filterIndex) {
          1 => upcoming,
          2 => completed,
          3 => cancelled,
          _ => bookings,
        };

        return Column(
          children: [
            Container(
              height: 50.5,
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _filterTab(l.all,       bookings.length,  _filterIndex == 0, () => _onFilterChanged(0)),
                    const SizedBox(width: 20),
                    _filterTab(l.upcoming,  upcoming.length,  _filterIndex == 1, () => _onFilterChanged(1)),
                    const SizedBox(width: 20),
                    _filterTab(l.completed, completed.length, _filterIndex == 2, () => _onFilterChanged(2)),
                    const SizedBox(width: 20),
                    _filterTab(l.cancelled, cancelled.length, _filterIndex == 3, () => _onFilterChanged(3)),
                  ],
                ),
              ),
            ),
            const Divider(height: 1, color: AppColors.greyE5E),
            Expanded(child: _buildBody(provider, filtered, l)),
          ],
        );
      },
    );
  }

  Widget _buildBody(BookingProvider provider, List<BookingModel> bookings, AppLocalizations l) {
    if (provider.listState == BookingState.loading) {
      return const Center(child: CircularProgressIndicator(color: AppColors.orangeprimary));
    }
    if (provider.listState == BookingState.error) {
      return Center(child: Text(provider.errorMessage, style: const TextStyle(color: Colors.red, fontSize: 14), textAlign: TextAlign.center));
    }
    if (bookings.isEmpty) {
      return Center(child: Text(l.noTripsFound, style: const TextStyle(color: AppColors.greyHint)));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bookings.length,
      itemBuilder: (context, index) => _MyBookingCard(booking: bookings[index]),
    );
  }

  Widget _filterTab(String label, int count, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: isActive ? AppColors.orangeprimary : AppColors.greySecondary,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.orangeprimary : AppColors.greyE5E,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('$count', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isActive ? Colors.white : AppColors.greySecondary)),
              ),
            ],
          ),
          const Spacer(),
          if (isActive) Container(height: 2, width: 40, color: AppColors.orangeprimary),
        ],
      ),
    );
  }
}

// ── Booking Card ──────────────────────────────────────────────────────────────

class _MyBookingCard extends StatefulWidget {
  final BookingModel booking;
  const _MyBookingCard({required this.booking});

  @override
  State<_MyBookingCard> createState() => _MyBookingCardState();
}

class _MyBookingCardState extends State<_MyBookingCard> {
  bool _cancelling = false;

  Future<void> _onCancel(AppLocalizations l) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.cancel_the_trip),
        content: Text(l.booking_confirmed_sub),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l.back_to_home)),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l.cancel_the_trip, style: const TextStyle(color: AppColors.errorRed)),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() => _cancelling = true);
    final ok = await context.read<BookingProvider>().cancelBooking(widget.booking.bookingId);
    if (!mounted) return;
    setState(() => _cancelling = false);
    if (ok) {
      context.read<BookingProvider>().fetchMyBookings();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.read<BookingProvider>().errorMessage), backgroundColor: AppColors.errorRed),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l       = AppLocalizations.of(context)!;
    final booking = widget.booking;
    final isActive = booking.status == 'Confirmed' || booking.status == 'Upcoming';

    Color statusColor;
    Color statusBg;
    IconData statusIcon;
    String statusLabel;

    switch (booking.status) {
      case 'Completed':
        statusColor = const Color(0xFF00A63E);
        statusBg    = const Color(0xFFEFFBF3);
        statusIcon  = Icons.check_circle_outline;
        statusLabel = l.completed;
        break;
      case 'Cancelled':
        statusColor = const Color(0xFFE7000B);
        statusBg    = const Color(0xFFFFF2F2);
        statusIcon  = Icons.cancel_outlined;
        statusLabel = l.cancelled;
        break;
      default:
        statusColor = AppColors.orangeprimary;
        statusBg    = const Color(0xFFFFFAEE);
        statusIcon  = Icons.access_time;
        statusLabel = l.upcoming;
    }

    String formattedDate = booking.departureTime;
    try {
      final dt = DateTime.parse(booking.departureTime);
      const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      formattedDate = '${dt.day} ${months[dt.month - 1]}, ${dt.year}  •  ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (_) {}

    final duration = booking.estimatedDurationMinutes > 0
        ? '${booking.estimatedDurationMinutes} min'
        : '';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF3F4F6), width: 1),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Status + chevron ──────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(12)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(statusIcon, size: 12, color: statusColor),
                  const SizedBox(width: 4),
                  Text(statusLabel, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: statusColor)),
                ]),
              ),
              const Icon(Icons.chevron_right, size: 18, color: AppColors.greySecondary),
            ],
          ),
          const SizedBox(height: 14),

          // ── Route ─────────────────────────────────────────────────
          Row(children: [
            const Icon(Icons.circle, size: 10, color: AppColors.orangeprimary),
            const SizedBox(width: 10),
            Expanded(child: Text(booking.pickupLocation, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 14, color: AppColors.greyDark))),
          ]),
          Row(children: [
            SizedBox(width: 10, child: Center(child: Column(
              children: List.generate(4, (_) => Container(
                width: 1.5, height: 4,
                margin: const EdgeInsets.symmetric(vertical: 2),
                color: AppColors.greySecondary,
              )),
            ))),
            const SizedBox(width: 10),
            if (duration.isNotEmpty) Text(duration, style: const TextStyle(fontFamily: 'Inter', fontSize: 11, color: AppColors.greyHint)),
          ]),
          Row(children: [
            Icon(Icons.circle, size: 10, color: Colors.grey[400]),
            const SizedBox(width: 10),
            Expanded(child: Text(booking.dropoffLocation, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 14, color: AppColors.greyDark))),
          ]),
          const SizedBox(height: 14),
          const Divider(height: 1, color: AppColors.greyE5E),
          const SizedBox(height: 10),

          // ── Date row ──────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                const Icon(Icons.calendar_today_outlined, size: 13, color: AppColors.greySecondary),
                const SizedBox(width: 6),
                Text(formattedDate, style: const TextStyle(fontFamily: 'Inter', fontSize: 12, color: AppColors.greySecondary)),
              ]),
              RichText(text: TextSpan(children: [
                const TextSpan(text: '₪ ', style: TextStyle(color: AppColors.orangeprimary, fontSize: 12, fontWeight: FontWeight.bold)),
                TextSpan(text: booking.totalAmount.toStringAsFixed(0), style: const TextStyle(color: AppColors.orangeprimary, fontSize: 16, fontWeight: FontWeight.bold)),
              ])),
            ],
          ),
          const SizedBox(height: 6),

          // ── Driver + seats row ────────────────────────────────────
          Row(children: [
            const Icon(Icons.people_outline, size: 14, color: AppColors.greySecondary),
            const SizedBox(width: 6),
            Text('${booking.driverName} · ${booking.seatCount} seat', style: const TextStyle(fontFamily: 'Inter', fontSize: 12, color: AppColors.greySecondary)),
          ]),

          // ── Cancel Button ─────────────────────────────────────────
          if (isActive) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: _cancelling ? null : () => _onCancel(l),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.errorRed,
                  side: const BorderSide(color: AppColors.errorRed),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: _cancelling
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: AppColors.errorRed, strokeWidth: 2))
                    : Text(l.cancel_the_trip, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
