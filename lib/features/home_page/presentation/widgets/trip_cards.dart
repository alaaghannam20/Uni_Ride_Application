import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/trip_provider.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';
import 'package:uni_ride_application/features/home_page/data/models/available_trip_model.dart';
import 'package:uni_ride_application/features/home_page/data/models/my_trip_model.dart';
import 'package:uni_ride_application/features/home_page/data/models/trip_model.dart';
import 'package:uni_ride_application/features/trip_details/presentation/screens/trip_details_screen.dart';

class TripCard extends StatelessWidget {
  final TripModel trip;
  const TripCard({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const TripDetailsScreen()),
      ),
      child: Container(
        width: 398,
        height: 193.6,
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.all(21),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE5E5E5), width: 0.62),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 2, offset: const Offset(0, 1), spreadRadius: -1),
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 3, offset: const Offset(0, 1)),
          ],
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
                      Expanded(
                        child: Text(trip.from, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 15, color: AppColors.greyDark)),
                      ),
                      Container(
                        width: 44, height: 44,
                        decoration: const BoxDecoration(color: AppColors.greyBackground, shape: BoxShape.circle),
                        child: const Icon(Icons.near_me_outlined, size: 20, color: AppColors.orangeprimary),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(width: 1, height: 4, color: Colors.grey[300]),
                              const SizedBox(height: 2),
                              Container(width: 1, height: 4, color: Colors.grey[300]),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text('In ${trip.duration} min', style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 11, color: AppColors.greyHint)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 8, child: Icon(Icons.circle, size: 8, color: AppColors.dashedLineColor)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(trip.to, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 15, color: AppColors.greyDark)),
                      ),
                      const SizedBox(width: 44),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              height: 46.61,
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.greyLight, width: 0.62)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.people_outline, size: 16, color: AppColors.adminTextSecondary),
                      const SizedBox(width: 4),
                      Text('${trip.seats} seats', style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 13, color: AppColors.adminTextSecondary)),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      const Text('₪', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.orangeprimary)),
                      const SizedBox(width: 2),
                      Text('${trip.price}', style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 20, color: AppColors.orangeprimary)),
                    ],
                  ),
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
    Color statusColor;
    Color statusBg;
    String statusLabel;
    IconData statusIcon;

    switch (trip.status) {
      case TripStatus.upcoming:
        statusColor = AppColors.orangeprimary;
        statusBg = const Color(0xFFFFFAEE);
        statusLabel = l.upcoming;
        statusIcon = Icons.access_time;
        break;
      case TripStatus.completed:
        statusColor = const Color(0xFF00A63E);
        statusBg = const Color(0xFFEFFBF3);
        statusLabel = l.completed;
        statusIcon = Icons.check_circle_outline;
        break;
      case TripStatus.cancelled:
        statusColor = const Color(0xFFE7000B);
        statusBg = const Color(0xFFFFF2F2);
        statusLabel = l.cancelled;
        statusIcon = Icons.cancel_outlined;
        break;
    }

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const TripDetailsScreen()),
      ),
      child: Container(
        width: 398,
        height: 253.08,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(21),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 2, offset: const Offset(0, 1)),
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 3, offset: const Offset(0, 1)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusIcon, size: 12, color: statusColor),
                      const SizedBox(width: 4),
                      Text(statusLabel, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: statusColor)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, size: 18, color: AppColors.greyCCC),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Column(
                  children: [
                    const Icon(Icons.circle, size: 7, color: AppColors.orangeprimary),
                    const SizedBox(height: 2),
                    Container(width: 1, height: 3, color: Colors.grey[200]),
                    const SizedBox(height: 2),
                    Container(width: 1, height: 3, color: Colors.grey[200]),
                    const SizedBox(height: 2),
                    Container(width: 1, height: 3, color: Colors.grey[200]),
                    const SizedBox(height: 2),
                    Icon(Icons.circle, size: 7, color: Colors.grey[300]),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(trip.from, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                      const SizedBox(height: 2),
                      Text('15 min', style: const TextStyle(color: AppColors.greyHint, fontSize: 11)),
                      const SizedBox(height: 2),
                      Text(trip.to, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Divider(height: 1, color: Color(0xFFF2F4F7)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 13, color: AppColors.greyHint),
                        const SizedBox(width: 6),
                        Text(trip.date, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.greySecondary)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.people_outline, size: 14, color: AppColors.greyHint),
                        const SizedBox(width: 6),
                        Text('${trip.driver} · ${trip.seats} seat', style: const TextStyle(fontSize: 12, color: AppColors.greySecondary)),
                      ],
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    const Text('₪', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.orangeprimary)),
                    const SizedBox(width: 2),
                    Text('${trip.price}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.orangeprimary)),
                  ],
                ),
              ],
            ),
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
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const TripDetailsScreen()),
      ),
      child: Container(
        width: 398,
        height: 256.57,
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(21),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 2, offset: const Offset(0, 1)),
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 3, offset: const Offset(0, 1)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48, height: 48,
                  decoration: const BoxDecoration(color: AppColors.primaryGradientEnd, shape: BoxShape.circle),
                  child: Center(child: Text(trip.driverInitial, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16))),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(trip.driver, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.greyDark)),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 14, color: Colors.orange),
                          const SizedBox(width: 4),
                          Text('${trip.driverRating}', style: const TextStyle(fontSize: 12, color: AppColors.greySecondary)),
                        ],
                      ),
                    ],
                  ),
                ),
                if (trip.isRecurring)
                   Container(
                     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                     decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(8)),
                     child: Text(l.recurring, style: const TextStyle(color: Color(0xFF2563EB), fontSize: 10, fontWeight: FontWeight.w600)),
                   ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Column(
                  children: [
                    const Icon(Icons.circle, size: 6, color: AppColors.orangeprimary),
                    const SizedBox(height: 6),
                    Container(width: 1, height: 6, color: Colors.grey[300]),
                    const SizedBox(height: 6),
                    Container(width: 1, height: 6, color: Colors.grey[300]),
                    const SizedBox(height: 6),
                    Container(width: 1, height: 6, color: Colors.grey[300]),
                    const SizedBox(height: 6),
                    Icon(Icons.circle, size: 6, color: Colors.grey[300]),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(trip.from, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                      const SizedBox(height: 24),
                      Text(trip.to, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Divider(height: 1, color: Color(0xFFF2F4F7)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 12, color: AppColors.greyHint),
                        const SizedBox(width: 6),
                        Text('Today - ${trip.time}', style: const TextStyle(fontSize: 11, color: AppColors.greySecondary, fontWeight: FontWeight.w500)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.people_outline, size: 14, color: AppColors.greyHint),
                        const SizedBox(width: 6),
                        Text('${trip.seats}/${trip.totalSeats} seats', style: const TextStyle(fontSize: 11, color: AppColors.greySecondary)),
                        const SizedBox(width: 12),
                        const Icon(Icons.directions_car_outlined, size: 14, color: AppColors.greyHint),
                        const SizedBox(width: 6),
                        Text(trip.carModel, style: const TextStyle(fontSize: 11, color: AppColors.greySecondary)),
                      ],
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    const Text('₪', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.orangeprimary)),
                    const SizedBox(width: 2),
                    Text('${trip.price}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.orangeprimary)),
                    const Text(' /seats', style: TextStyle(fontSize: 12, color: AppColors.greyHint, fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── API-backed cards ─────────────────────────────────────────────────────────

class AvailableTripApiCard extends StatelessWidget {
  final AvailableTripModel trip;
  const AvailableTripApiCard({super.key, required this.trip});

  String _formatTime(String iso) {
    try {
      final dt = DateTime.parse(iso);
      final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
      final period = dt.hour < 12 ? 'AM' : 'PM';
      return '$hour:${dt.minute.toString().padLeft(2, '0')} $period';
    } catch (_) {
      return iso;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<TripProvider>().fetchTripDetails(trip.tripId);
        Navigator.pushNamed(context, Routes.tripDetails);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.all(21),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE5E5E5), width: 0.62),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 2, offset: const Offset(0, 1), spreadRadius: -1),
            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 3, offset: const Offset(0, 1)),
          ],
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
                      Expanded(
                        child: Text(trip.pickupLocation, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 15, color: AppColors.greyDark)),
                      ),
                      Container(
                        width: 44, height: 44,
                        decoration: const BoxDecoration(color: AppColors.greyBackground, shape: BoxShape.circle),
                        child: const Icon(Icons.near_me_outlined, size: 20, color: AppColors.orangeprimary),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(width: 1, height: 4, color: Colors.grey[300]),
                              const SizedBox(height: 2),
                              Container(width: 1, height: 4, color: Colors.grey[300]),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          trip.estimatedDurationMinutes > 0
                              ? 'In ${trip.estimatedDurationMinutes} min'
                              : _formatTime(trip.departureTime),
                          style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 11, color: AppColors.greyHint),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 8, child: Icon(Icons.circle, size: 8, color: Colors.grey[300])),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(trip.dropoffLocation, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 15, color: AppColors.greyDark)),
                      ),
                      const SizedBox(width: 44),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              height: 46.61,
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.greyLight, width: 0.62)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.people_outline, size: 16, color: AppColors.adminTextSecondary),
                      const SizedBox(width: 4),
                      Text('${trip.availableSeats} seats', style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 13, color: AppColors.adminTextSecondary)),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      const Text('₪', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.orangeprimary)),
                      const SizedBox(width: 2),
                      Text('${trip.pricePerSeat}', style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 20, color: AppColors.orangeprimary)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyTripApiCard extends StatelessWidget {
  final MyTripModel trip;
  const MyTripApiCard({super.key, required this.trip});

  String _formatDate(String iso) {
    try {
      final dt = DateTime.parse(iso);
      const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return '${dt.day} ${months[dt.month - 1]}, ${dt.year}';
    } catch (_) {
      return iso;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final statusLower = trip.status.toLowerCase();
    final Color statusColor;
    final Color statusBg;
    final String statusLabel;
    final IconData statusIcon;

    if (statusLower == 'completed') {
      statusColor = const Color(0xFF00A63E);
      statusBg = const Color(0xFFEFFBF3);
      statusLabel = l.completed;
      statusIcon = Icons.check_circle_outline;
    } else if (statusLower == 'cancelled') {
      statusColor = const Color(0xFFE7000B);
      statusBg = const Color(0xFFFFF2F2);
      statusLabel = l.cancelled;
      statusIcon = Icons.cancel_outlined;
    } else {
      statusColor = AppColors.orangeprimary;
      statusBg = const Color(0xFFFFFAEE);
      statusLabel = l.upcoming;
      statusIcon = Icons.access_time;
    }

    return GestureDetector(
      onTap: () {
        context.read<TripProvider>().fetchTripDetails(trip.tripId);
        Navigator.pushNamed(context, Routes.tripDetails);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(21),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 2, offset: const Offset(0, 1)),
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 3, offset: const Offset(0, 1)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(statusIcon, size: 12, color: statusColor),
                      const SizedBox(width: 4),
                      Text(statusLabel, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: statusColor)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, size: 18, color: AppColors.greyCCC),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Column(
                  children: [
                    const Icon(Icons.circle, size: 7, color: AppColors.orangeprimary),
                    const SizedBox(height: 2),
                    Container(width: 1, height: 3, color: Colors.grey[200]),
                    const SizedBox(height: 2),
                    Container(width: 1, height: 3, color: Colors.grey[200]),
                    const SizedBox(height: 2),
                    Container(width: 1, height: 3, color: Colors.grey[200]),
                    const SizedBox(height: 2),
                    Icon(Icons.circle, size: 7, color: Colors.grey[300]),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(trip.pickupLocation, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                      const SizedBox(height: 4),
                      Text(trip.dropoffLocation, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: Color(0xFFF2F4F7)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, size: 13, color: AppColors.greyHint),
                        const SizedBox(width: 6),
                        Text(_formatDate(trip.departureTime), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.greySecondary)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.person_outline, size: 14, color: AppColors.greyHint),
                        const SizedBox(width: 6),
                        Text(trip.driverName, style: const TextStyle(fontSize: 12, color: AppColors.greySecondary)),
                      ],
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    const Text('₪', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.orangeprimary)),
                    const SizedBox(width: 2),
                    Text('${trip.pricePerSeat}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.orangeprimary)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Mock-based cards ──────────────────────────────────────────────────────────

class DetailedTripCard extends StatelessWidget {
  final TripModel trip;
  const DetailedTripCard({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const TripDetailsScreen()),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFF3F4F6), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Top Section: Driver Info
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: AppColors.orangeprimary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      trip.driverInitial,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trip.driver,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.greyDark,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 14, color: Color(0xFFF59E0B)),
                          const SizedBox(width: 4),
                          Text(
                            '${trip.driverRating}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.grey667,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            child: Text('·', style: TextStyle(color: AppColors.grey667)),
                          ),
                          Text(
                            trip.carModel,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.grey667,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: AppColors.greyBackground,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.near_me_outlined,
                    color: AppColors.orangeprimary,
                    size: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Middle Section: Path
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const Icon(Icons.circle, size: 8, color: AppColors.orangeprimary),
                    const SizedBox(height: 4),
                    Column(
                      children: List.generate(4, (index) => Container(
                        width: 1.5,
                        height: 4,
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        color: const Color(0xFFE5E7EB),
                      )),
                    ),
                    const SizedBox(height: 4),
                    const Icon(Icons.circle, size: 8, color: AppColors.dashedLineColor),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trip.from,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.greyDark,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'In ${trip.duration} min',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.greyHint,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        trip.to,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.greyDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Footer Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: AppColors.grey667),
                    const SizedBox(width: 4),
                    Text(
                      '${trip.duration} min',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.grey667,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.people_outline, size: 16, color: AppColors.grey667),
                    const SizedBox(width: 4),
                    Text(
                      '${trip.seats} seats',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.grey667,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      '₪',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.orangeprimary,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '${trip.price}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.orangeprimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
