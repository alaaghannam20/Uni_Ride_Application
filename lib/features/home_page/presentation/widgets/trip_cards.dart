import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/constants/app_fee.dart';
import 'package:uni_ride_application/core/provider/trip_provider.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';
import 'package:uni_ride_application/features/home_page/data/models/available_trip_model.dart';
import 'package:uni_ride_application/features/home_page/data/models/my_trip_model.dart';
import 'package:uni_ride_application/features/home_page/data/models/trip_model.dart';

// ─── Mock-based cards ──────────────────────────────────────────────────────────

class TripCard extends StatelessWidget {
  final TripModel trip;
  const TripCard({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.tripDetails, arguments: 0),
      child: Container(
        width: 398,
        height: 193.6,
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.all(21),
        decoration: BoxDecoration(
          color: context.bgCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: context.borderColor, width: 0.62),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          children: [
            SizedBox(
              height: 88.99,
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 8, child: Icon(Icons.circle, size: 8, color: AppColors.orangeprimary)),
                      const SizedBox(width: 12),
                      Expanded(child: Text(trip.from, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 15, color: context.textPrimary))),
                      Container(
                        width: 44, height: 44,
                        decoration: BoxDecoration(color: context.bgSubtle, shape: BoxShape.circle),
                        child: const Icon(Icons.near_me_outlined, size: 20, color: AppColors.orangeprimary),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 8, child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Container(width: 1, height: 4, color: context.borderColor),
                          const SizedBox(height: 2),
                          Container(width: 1, height: 4, color: context.borderColor),
                        ]))),
                        const SizedBox(width: 12),
                        Text('In ${trip.duration} min', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 11, color: context.textHint)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 8, child: Icon(Icons.circle, size: 8, color: context.textHint)),
                      const SizedBox(width: 12),
                      Expanded(child: Text(trip.to, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 15, color: context.textPrimary))),
                      const SizedBox(width: 44),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              height: 46.61,
              decoration: BoxDecoration(border: Border(top: BorderSide(color: context.borderColor, width: 0.62))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Icon(Icons.people_outline, size: 16, color: context.textSecondary),
                    const SizedBox(width: 4),
                    Text('${trip.seats} seats', style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 13, color: context.textSecondary)),
                  ]),
                  Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
                    const Text('₪', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.orangeprimary)),
                    const SizedBox(width: 2),
                    Text('${trip.price + kAppFee}', style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 20, color: AppColors.orangeprimary)),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyTripCard extends StatelessWidget {
  final TripModel trip;
  const MyTripCard({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    Color statusColor; Color statusBg; String statusLabel; IconData statusIcon;
    switch (trip.status) {
      case TripStatus.upcoming:
        statusColor = AppColors.orangeprimary; statusBg = context.isDark ? AppColors.orangeprimary.withValues(alpha: 0.15) : const Color(0xFFFFFAEE); statusLabel = l.upcoming; statusIcon = Icons.access_time; break;
      case TripStatus.completed:
        statusColor = const Color(0xFF00A63E); statusBg = context.isDark ? const Color(0xFF00A63E).withValues(alpha: 0.15) : const Color(0xFFEFFBF3); statusLabel = l.completed; statusIcon = Icons.check_circle_outline; break;
      case TripStatus.cancelled:
        statusColor = const Color(0xFFE7000B); statusBg = context.isDark ? const Color(0xFFE7000B).withValues(alpha: 0.15) : const Color(0xFFFFF2F2); statusLabel = l.cancelled; statusIcon = Icons.cancel_outlined; break;
    }

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.tripDetails, arguments: 0),
      child: Container(
        width: 398, height: 253.08,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(21),
        decoration: BoxDecoration(
          color: context.bgCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: context.borderColor),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(12)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(statusIcon, size: 12, color: statusColor),
                  const SizedBox(width: 4),
                  Text(statusLabel, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: statusColor)),
                ]),
              ),
              Icon(Icons.chevron_right, size: 18, color: context.textHint),
            ]),
            const SizedBox(height: 16),
            Row(children: [
              Column(children: [
                const Icon(Icons.circle, size: 7, color: AppColors.orangeprimary),
                const SizedBox(height: 2),
                Container(width: 1, height: 3, color: context.borderColor),
                const SizedBox(height: 2),
                Container(width: 1, height: 3, color: context.borderColor),
                const SizedBox(height: 2),
                Container(width: 1, height: 3, color: context.borderColor),
                const SizedBox(height: 2),
                Icon(Icons.circle, size: 7, color: context.textHint),
              ]),
              const SizedBox(width: 12),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(trip.from, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: context.textPrimary)),
                const SizedBox(height: 2),
                Text('15 min', style: TextStyle(color: context.textHint, fontSize: 11)),
                const SizedBox(height: 2),
                Text(trip.to, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: context.textPrimary)),
              ])),
            ]),
            const Spacer(),
            Divider(height: 1, color: context.borderColor),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Icon(Icons.calendar_today, size: 13, color: context.textHint),
                  const SizedBox(width: 6),
                  Text(trip.date, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: context.textSecondary)),
                ]),
                const SizedBox(height: 6),
                Row(children: [
                  Icon(Icons.people_outline, size: 14, color: context.textHint),
                  const SizedBox(width: 6),
                  Text('${trip.driver} · ${trip.seats} seat', style: TextStyle(fontSize: 12, color: context.textSecondary)),
                ]),
              ]),
              Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
                const Text('₪', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.orangeprimary)),
                const SizedBox(width: 2),
                Text('${trip.price + kAppFee}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.orangeprimary)),
              ]),
            ]),
          ],
        ),
      ),
    );
  }
}

class CarpoolTripCard extends StatelessWidget {
  final TripModel trip;
  const CarpoolTripCard({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.tripDetails, arguments: 0),
      child: Container(
        width: 398, height: 256.57,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(21),
        decoration: BoxDecoration(
          color: context.bgCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: context.borderColor),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(
              width: 48, height: 48,
              decoration: const BoxDecoration(color: AppColors.primaryGradientEnd, shape: BoxShape.circle),
              child: Center(child: Text(trip.driverInitial, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(trip.driver, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: context.textPrimary)),
              Row(children: [
                const Icon(Icons.star, size: 14, color: Colors.orange),
                const SizedBox(width: 4),
                Text('${trip.driverRating}', style: TextStyle(fontSize: 12, color: context.textSecondary)),
              ]),
            ])),
            if (trip.isRecurring)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: context.isDark ? context.bgSubtle : AppColors.infoBlueBg, borderRadius: BorderRadius.circular(8)),
                child: Text(l.recurring, style: TextStyle(color: context.isDark ? AppColors.lightBlueAccent : AppColors.infoBlue, fontSize: 10, fontWeight: FontWeight.w600)),
              ),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Column(children: [
              const Icon(Icons.circle, size: 6, color: AppColors.orangeprimary),
              const SizedBox(height: 6),
              Container(width: 1, height: 6, color: context.borderColor),
              const SizedBox(height: 6),
              Container(width: 1, height: 6, color: context.borderColor),
              const SizedBox(height: 6),
              Container(width: 1, height: 6, color: context.borderColor),
              const SizedBox(height: 6),
              Icon(Icons.circle, size: 6, color: context.textHint),
            ]),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(trip.from, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: context.textPrimary)),
              const SizedBox(height: 24),
              Text(trip.to, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: context.textPrimary)),
            ])),
          ]),
          const Spacer(),
          Divider(height: 1, color: context.borderColor),
          const SizedBox(height: 12),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Icon(Icons.calendar_today, size: 12, color: context.textHint),
                const SizedBox(width: 6),
                Text('Today - ${trip.time}', style: TextStyle(fontSize: 11, color: context.textSecondary, fontWeight: FontWeight.w500)),
              ]),
              const SizedBox(height: 6),
              Row(children: [
                Icon(Icons.people_outline, size: 14, color: context.textHint),
                const SizedBox(width: 6),
                Text('${trip.seats}/${trip.totalSeats} seats', style: TextStyle(fontSize: 11, color: context.textSecondary)),
                const SizedBox(width: 12),
                Icon(Icons.directions_car_outlined, size: 14, color: context.textHint),
                const SizedBox(width: 6),
                Text(trip.carModel, style: TextStyle(fontSize: 11, color: context.textSecondary)),
              ]),
            ]),
            Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
              const Text('₪', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.orangeprimary)),
              const SizedBox(width: 2),
              Text('${trip.price + kAppFee}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.orangeprimary)),
              Text(' /seats', style: TextStyle(fontSize: 12, color: context.textHint, fontWeight: FontWeight.w500)),
            ]),
          ]),
        ]),
      ),
    );
  }
}

// ─── API-backed cards ─────────────────────────────────────────────────────────

class AvailableTripApiCard extends StatelessWidget {
  final AvailableTripModel trip;
  const AvailableTripApiCard({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    final initial  = trip.driverName.isNotEmpty ? trip.driverName[0].toUpperCase() : '?';
    final duration = trip.estimatedDurationMinutes > 0 ? '${trip.estimatedDurationMinutes} min' : '';

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.tripDetails, arguments: trip.tripId),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.bgCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: context.borderColor, width: 0.62),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // ── Driver row ───────────────────────────────────────
          Row(children: [
            Container(
              width: 40, height: 40,
              decoration: const BoxDecoration(color: AppColors.orangeprimary, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: trip.profilePicturePath != null
                  ? ClipOval(child: Image.network('http://uniride.runasp.net/${trip.profilePicturePath}', fit: BoxFit.cover, errorBuilder: (ctx, e, s) => Text(initial, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))))
                  : Text(initial, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            const SizedBox(width: 10),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(trip.driverName, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 14, color: context.textPrimary)),
              Row(children: [
                if (trip.driverRating > 0) ...[
                  const Icon(Icons.star, size: 13, color: Color(0xFFF5A623)),
                  const SizedBox(width: 3),
                  Text(trip.driverRating.toStringAsFixed(1), style: const TextStyle(fontFamily: 'Inter', fontSize: 12, color: AppColors.greySecondary)),
                  const SizedBox(width: 6),
                  Container(width: 1, height: 10, color: AppColors.greySecondary),
                  const SizedBox(width: 6),
                ],
                if (trip.totalDriverTrips > 0) ...[
                  Icon(Icons.directions_car_outlined, size: 12, color: AppColors.orangeprimary),
                  const SizedBox(width: 3),
                  Text('${trip.totalDriverTrips} trips', style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: context.textSecondary)),
                ],
              ]),
              const SizedBox(height: 2),
              Text(trip.vehicleModel, style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: context.textSecondary)),
            ])),
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(color: context.bgSubtle, shape: BoxShape.circle),
              child: const Icon(Icons.near_me_outlined, size: 18, color: AppColors.orangeprimary),
            ),
          ]),
          const SizedBox(height: 14),

          // ── Route ────────────────────────────────────────────
          Row(children: [
            const Icon(Icons.circle, size: 10, color: AppColors.orangeprimary),
            const SizedBox(width: 10),
            Expanded(child: Text(trip.pickupLocation, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 14, color: context.textPrimary))),
          ]),
          Row(children: [
            SizedBox(width: 10, child: Center(child: Column(children: List.generate(4, (_) => Container(
              width: 1.5, height: 4,
              margin: const EdgeInsets.symmetric(vertical: 2),
              color: context.textSecondary,
            ))))),
            const SizedBox(width: 10),
            if (duration.isNotEmpty) Text(duration, style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: context.textHint)),
          ]),
          Row(children: [
            Icon(Icons.circle, size: 10, color: context.textHint),
            const SizedBox(width: 10),
            Expanded(child: Text(trip.dropoffLocation, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 14, color: context.textPrimary))),
          ]),
          const SizedBox(height: 14),

          // ── Footer ───────────────────────────────────────────
          Divider(height: 1, color: context.borderColor),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Icon(Icons.people_outline, size: 15, color: context.textSecondary),
              const SizedBox(width: 4),
              Text('${trip.availableSeats} seats', style: TextStyle(fontFamily: 'Inter', fontSize: 12, color: context.textSecondary)),
            ]),
            Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
              const Text('₪', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.orangeprimary)),
              const SizedBox(width: 2),
              Text('${trip.pricePerSeat + kAppFee}', style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.orangeprimary)),
            ]),
          ]),
        ]),
      ),
    );
  }
}

class MyTripApiCard extends StatefulWidget {
  final MyTripModel trip;
  const MyTripApiCard({super.key, required this.trip});

  @override
  State<MyTripApiCard> createState() => _MyTripApiCardState();
}

class _MyTripApiCardState extends State<MyTripApiCard> {
  bool _completing = false;

  String _formatDate(String iso) {
    try {
      final dt = DateTime.parse(iso);
      const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
      return '${dt.day} ${months[dt.month - 1]}, ${dt.year}';
    } catch (_) { return iso; }
  }

  Future<void> _onComplete() async {
    final l = AppLocalizations.of(context)!;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Complete Trip', style: TextStyle(color: context.textPrimary)),
        content: const Text('Are you sure you want to mark this trip as completed?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l.cancel, style: TextStyle(color: context.textSecondary)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00A63E)),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Complete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
    if (confirm != true || !mounted) return;
    setState(() => _completing = true);
    final success = await context.read<TripProvider>().completeTrip(widget.trip.tripId);
    if (!mounted) return;
    setState(() => _completing = false);
    if (success) {
      context.read<TripProvider>().fetchDriverScheduled();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.read<TripProvider>().errorMessage), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final trip = widget.trip;
    final l = AppLocalizations.of(context)!;
    final statusLower = trip.status.toLowerCase();
    final Color statusColor;
    final Color statusBg;
    final String statusLabel;
    final IconData statusIcon;

    if (statusLower == 'completed') {
      statusColor = const Color(0xFF00A63E); statusBg = context.isDark ? const Color(0xFF00A63E).withValues(alpha: 0.15) : const Color(0xFFEFFBF3); statusLabel = l.completed; statusIcon = Icons.check_circle_outline;
    } else if (statusLower == 'cancelled') {
      statusColor = const Color(0xFFE7000B); statusBg = context.isDark ? const Color(0xFFE7000B).withValues(alpha: 0.15) : const Color(0xFFFFF2F2); statusLabel = l.cancelled; statusIcon = Icons.cancel_outlined;
    } else {
      statusColor = AppColors.orangeprimary; statusBg = context.isDark ? AppColors.orangeprimary.withValues(alpha: 0.15) : const Color(0xFFFFFAEE); statusLabel = l.upcoming; statusIcon = Icons.access_time;
    }

    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.tripDetails, arguments: trip.tripId),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(21),
        decoration: BoxDecoration(
          color: context.bgCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: context.borderColor),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(12)),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(statusIcon, size: 12, color: statusColor),
                const SizedBox(width: 4),
                Text(statusLabel, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: statusColor)),
              ]),
            ),
            Icon(Icons.chevron_right, size: 18, color: context.textHint),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Column(children: [
              const Icon(Icons.circle, size: 7, color: AppColors.orangeprimary),
              const SizedBox(height: 2),
              Container(width: 1, height: 3, color: context.borderColor),
              const SizedBox(height: 2),
              Container(width: 1, height: 3, color: context.borderColor),
              const SizedBox(height: 2),
              Container(width: 1, height: 3, color: context.borderColor),
              const SizedBox(height: 2),
              Icon(Icons.circle, size: 7, color: context.textHint),
            ]),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(trip.pickupLocation, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: context.textPrimary)),
              const SizedBox(height: 4),
              Text(trip.dropoffLocation, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: context.textPrimary)),
            ])),
          ]),
          const SizedBox(height: 16),
          Divider(height: 1, color: context.borderColor),
          const SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Icon(Icons.calendar_today, size: 13, color: context.textHint),
                const SizedBox(width: 6),
                Text(_formatDate(trip.departureTime), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: context.textSecondary)),
              ]),
              const SizedBox(height: 6),
              Row(children: [
                Icon(Icons.person_outline, size: 14, color: context.textHint),
                const SizedBox(width: 6),
                Text(trip.driverName, style: TextStyle(fontSize: 12, color: context.textSecondary)),
              ]),
            ]),
            Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
              const Text('₪', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.orangeprimary)),
              const SizedBox(width: 2),
              Text('${trip.pricePerSeat + kAppFee}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.orangeprimary)),
            ]),
          ]),
          if (statusLower != 'completed' && statusLower != 'cancelled') ...[
            const SizedBox(height: 12),
            Row(children: [
              // ── Cancel ──
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(l.cancel, style: TextStyle(color: context.textPrimary)),
                        content: Text(l.cancel_trip_confirmation),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: Text(l.cancel, style: TextStyle(color: context.textSecondary)),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: AppColors.errorRed),
                            onPressed: () => Navigator.pop(context, true),
                            child: Text(l.cancel_trip, style: const TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true && context.mounted) {
                      await context.read<TripProvider>().cancelTrip(trip.tripId);
                      if (context.mounted) {
                        context.read<TripProvider>().fetchDriverScheduled();
                        context.read<TripProvider>().fetchMyTrips();
                        context.read<TripProvider>().fetchAvailableTrips();
                      }
                    }
                  },
                  icon: const Icon(Icons.cancel_outlined, size: 16, color: AppColors.errorRed),
                  label: Text(l.cancel_trip, style: const TextStyle(fontSize: 13, color: AppColors.errorRed)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.errorRed),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // ── Complete ──
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _completing ? null : _onComplete,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: context.isDark
                        ? const Color(0xFF00A63E).withValues(alpha: 0.15)
                        : const Color(0xFFEFFBF3),
                    foregroundColor: const Color(0xFF00A63E),
                    side: BorderSide(
                      color: context.isDark
                          ? const Color(0xFF00A63E).withValues(alpha: 0.5)
                          : const Color(0xFF00A63E),
                      width: 1.2,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  icon: _completing
                      ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF00A63E)))
                      : const Icon(Icons.check_circle_outline, size: 16, color: Color(0xFF00A63E)),
                  label: const Text('Complete', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Color(0xFF00A63E))),
                ),
              ),
            ]),
          ],
        ]),
      ),
    );
  }
}

class DetailedTripCard extends StatelessWidget {
  final TripModel trip;
  const DetailedTripCard({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.tripDetails, arguments: 0),
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: context.bgCard,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: context.borderColor),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(children: [
          Row(children: [
            Container(
              width: 44, height: 44,
              decoration: const BoxDecoration(color: AppColors.orangeprimary, shape: BoxShape.circle),
              child: Center(child: Text(trip.driverInitial, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(trip.driver, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: context.textPrimary)),
              Row(children: [
                const Icon(Icons.star, size: 14, color: Color(0xFFF59E0B)),
                const SizedBox(width: 4),
                Text('${trip.driverRating}', style: TextStyle(fontSize: 12, color: context.textSecondary, fontWeight: FontWeight.w500)),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: Text('·', style: TextStyle(color: context.textSecondary))),
                Text(trip.carModel, style: TextStyle(fontSize: 12, color: context.textSecondary)),
              ]),
            ])),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: context.bgSubtle, shape: BoxShape.circle),
              child: const Icon(Icons.near_me_outlined, color: AppColors.orangeprimary, size: 18),
            ),
          ]),
          const SizedBox(height: 20),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Column(children: [
              const Icon(Icons.circle, size: 8, color: AppColors.orangeprimary),
              const SizedBox(height: 4),
              ...List.generate(4, (_) => Container(width: 1.5, height: 4, margin: const EdgeInsets.symmetric(vertical: 2), color: context.borderColor)),
              const SizedBox(height: 4),
              Icon(Icons.circle, size: 8, color: context.textHint),
            ]),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(trip.from, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: context.textPrimary)),
              const SizedBox(height: 12),
              Text('In ${trip.duration} min', style: TextStyle(fontSize: 11, color: context.textHint)),
              const SizedBox(height: 12),
              Text(trip.to, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: context.textPrimary)),
            ])),
          ]),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Icon(Icons.access_time, size: 16, color: context.textSecondary),
              const SizedBox(width: 4),
              Text('${trip.duration} min', style: TextStyle(fontSize: 12, color: context.textSecondary, fontWeight: FontWeight.w500)),
              const SizedBox(width: 16),
              Icon(Icons.people_outline, size: 16, color: context.textSecondary),
              const SizedBox(width: 4),
              Text('${trip.seats} seats', style: TextStyle(fontSize: 12, color: context.textSecondary, fontWeight: FontWeight.w500)),
            ]),
            Row(children: [
              const Text('₪', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.orangeprimary)),
              const SizedBox(width: 2),
              Text('${trip.price + kAppFee}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.orangeprimary)),
            ]),
          ]),
        ]),
      ),
    );
  }
}
