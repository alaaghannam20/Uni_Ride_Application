import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/booking_provider.dart';
import 'package:uni_ride_application/core/provider/trip_provider.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class TripDetailsScreen extends StatefulWidget {
  final int tripId;
  const TripDetailsScreen({super.key, required this.tripId});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  int _selectedSeats = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TripProvider>().fetchTripDetails(widget.tripId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l    = AppLocalizations.of(context)!;
    final trip = context.watch<TripProvider>().tripDetails;
    final state = context.watch<TripProvider>().tripDetailsState;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Center(
            child: InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 40, height: 40,
                decoration: const BoxDecoration(color: Color(0xFFF3F4F6), shape: BoxShape.circle),
                child: const Icon(Icons.arrow_back, color: AppColors.greyDark, size: 20),
              ),
            ),
          ),
        ),
        title: Text(l.tripDetails, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 20, color: AppColors.greyDark)),
        centerTitle: false,
        titleSpacing: 5,
      ),
      body: state == TripState.loading || trip == null
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFCF8307)))
          : state == TripState.error
              ? Center(child: Text(context.read<TripProvider>().errorMessage, style: const TextStyle(color: AppColors.errorRed)))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildGoldenCard(trip.pickupLocation, trip.dropoffLocation, trip.departureTime),
                      const SizedBox(height: 16),
                      _buildDriverInfo(context, l, trip.driverName, trip.profilePicturePath, trip.driverRating, trip.totalDriverTrips, trip.vehicleModel, trip.vehicleType),
                      if (trip.stops.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        _buildPickupPoints(l, trip.stops),
                      ],
                      const SizedBox(height: 16),
                      _buildAvailableSeats(l, trip.availableSeats, trip.totalSeats),
                      const SizedBox(height: 16),
                      _buildSelectSeats(l, trip.availableSeats, trip.pricePerSeat.toDouble()),
                    ],
                  ),
                ),
      bottomNavigationBar: trip == null ? null : _buildBottomBar(context, l, trip.tripId, trip.pricePerSeat.toDouble()),
    );
  }

  Widget _buildGoldenCard(String pickup, String dropoff, String departureTime) {
    String dateStr = '';
    String timeStr = '';
    try {
      final dt = DateTime.parse(departureTime);
      const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
      final now = DateTime.now();
      final isToday = dt.year == now.year && dt.month == now.month && dt.day == now.day;
      dateStr = isToday ? 'Today' : '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
      final h = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
      final m = dt.minute.toString().padLeft(2, '0');
      timeStr = '$h:$m ${dt.hour < 12 ? 'AM' : 'PM'}';
    } catch (_) {
      dateStr = departureTime;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFFCF8307), borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Route ────────────────────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dots column
              Column(
                children: [
                  const SizedBox(height: 4),
                  Container(width: 10, height: 10, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                  ...List.generate(6, (_) => Container(width: 1.5, height: 4, color: Colors.white60, margin: const EdgeInsets.symmetric(vertical: 2))),
                  Container(width: 10, height: 10, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                ],
              ),
              const SizedBox(width: 16),
              // Locations
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pickup, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                    const SizedBox(height: 32),
                    Text(dropoff, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white24, height: 1),
          const SizedBox(height: 12),
          // ── Date + Time ───────────────────────────────────────────
          Row(
            children: [
              const Icon(Icons.calendar_today_outlined, color: Colors.white, size: 15),
              const SizedBox(width: 8),
              Text('$dateStr  •', style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
              const SizedBox(width: 6),
              const Icon(Icons.access_time, color: Colors.white, size: 15),
              const SizedBox(width: 6),
              Text(timeStr, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDriverInfo(BuildContext context, AppLocalizations l, String name, String? photo, double rating, int trips, String vehicleModel, String vehicleType) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    return _CardContainer(
      title: l.driverInfo,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48, height: 48,
                decoration: const BoxDecoration(color: Color(0xFFCF8307), shape: BoxShape.circle),
                alignment: Alignment.center,
                child: photo != null
                    ? ClipOval(child: Image.network('http://uniride.runasp.net/$photo', fit: BoxFit.cover, errorBuilder: (ctx, err, st) => Text(initial, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18))))
                    : Text(initial, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.greyDark)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Color(0xFFF5A623), size: 14),
                        const SizedBox(width: 4),
                        Text('${rating.toStringAsFixed(1)} • $trips trips', style: const TextStyle(color: AppColors.greySecondary, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                const Icon(Icons.directions_car_outlined, color: AppColors.greySecondary, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('$vehicleModel • $vehicleType', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.greyDark)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPickupPoints(AppLocalizations l, List<dynamic> stops) {
    return _CardContainer(
      title: l.pickup_points,
      child: Column(
        children: [
          for (int i = 0; i < stops.length; i++) ...[
            if (i > 0) const SizedBox(height: 16),
            _PickupRow(
              number: '${i + 1}',
              title: stops[i].stopName as String,
              time: _formatStopTime(stops[i].estimatedArrivalTime as String),
            ),
          ],
        ],
      ),
    );
  }

  String _formatStopTime(String iso) {
    try {
      final dt = DateTime.parse(iso);
      final h = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
      final m = dt.minute.toString().padLeft(2, '0');
      return '$h:$m ${dt.hour < 12 ? 'AM' : 'PM'}';
    } catch (_) {
      return iso;
    }
  }

  Widget _buildAvailableSeats(AppLocalizations l, int available, int total) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF3F4F6), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l.availableSeats, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.greyDark)),
              const SizedBox(height: 4),
              Text('$available of $total ${l.seats_remaining}', style: const TextStyle(color: AppColors.greySecondary, fontSize: 12)),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.people_outline, color: Color(0xFFCF8307), size: 20),
              const SizedBox(width: 8),
              Text('$available', style: const TextStyle(color: Color(0xFFCF8307), fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSelectSeats(AppLocalizations l, int maxSeats, double pricePerSeat) {
    final total = _selectedSeats * pricePerSeat;
    return _CardContainer(
      title: l.select_seats,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l.how_many_seats, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.greyDark)),
                  const SizedBox(height: 4),
                  Text('$maxSeats ${l.seats_available}', style: const TextStyle(color: AppColors.greySecondary, fontSize: 11)),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () { if (_selectedSeats > 1) setState(() => _selectedSeats--); },
                    child: Container(
                      width: 36, height: 36,
                      decoration: const BoxDecoration(color: Color(0xFFFEF3DF), shape: BoxShape.circle),
                      child: const Icon(Icons.remove, color: Color(0xFFCF8307), size: 18),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 36, height: 40,
                    decoration: BoxDecoration(color: const Color(0xFFCF8307), borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: Text('$_selectedSeats', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () { if (_selectedSeats < maxSeats) setState(() => _selectedSeats++); },
                    child: Container(
                      width: 36, height: 36,
                      decoration: const BoxDecoration(color: Color(0xFFF3F4F6), shape: BoxShape.circle),
                      child: const Icon(Icons.add, color: Color(0xFF9CA3AF), size: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(12)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(l.pricePerSeat, style: const TextStyle(color: AppColors.greySecondary, fontSize: 12)),
                    Text('₪ ${pricePerSeat.toStringAsFixed(0)}', style: const TextStyle(color: AppColors.greyDark, fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(l.numberOfSeats, style: const TextStyle(color: AppColors.greySecondary, fontSize: 12)),
                    Text('× $_selectedSeats', style: const TextStyle(color: AppColors.greyDark, fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(color: Color(0xFFE5E7EB), height: 1),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(l.total, style: const TextStyle(color: AppColors.greyDark, fontSize: 14, fontWeight: FontWeight.bold)),
                    RichText(
                      text: TextSpan(children: [
                        const TextSpan(text: '₪ ', style: TextStyle(color: Color(0xFFCF8307), fontSize: 12, fontWeight: FontWeight.bold)),
                        TextSpan(text: total.toStringAsFixed(0), style: const TextStyle(color: Color(0xFFCF8307), fontSize: 16, fontWeight: FontWeight.bold)),
                      ]),
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

  Widget _buildBottomBar(BuildContext context, AppLocalizations l, int tripId, double pricePerSeat) {
    final total = _selectedSeats * pricePerSeat;
    final bookingState = context.watch<BookingProvider>().createState;
    final isLoading = bookingState == BookingState.loading;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -4))],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(l.total_price, style: const TextStyle(color: AppColors.greySecondary, fontSize: 11)),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(text: '₪ ', style: TextStyle(color: Color(0xFFCF8307), fontSize: 14, fontWeight: FontWeight.bold)),
                    TextSpan(text: total.toStringAsFixed(0), style: const TextStyle(color: Color(0xFFCF8307), fontSize: 24, fontWeight: FontWeight.bold)),
                  ]),
                ),
              ],
            ),
            const SizedBox(width: 90),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : () => _onBookNow(context, l, tripId),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFCF8307),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                      ),
                      child: isLoading
                          ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : Text(l.book_now, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE7000B),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        elevation: 0,
                      ),
                      child: Text(l.cancel_the_trip, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onBookNow(BuildContext context, AppLocalizations l, int tripId) async {
    final provider = context.read<BookingProvider>();
    provider.reset();
    final booking = await provider.createBooking(tripId: tripId, seatCount: _selectedSeats);
    if (!mounted) return;
    if (booking != null) {
      Navigator.pushNamed(this.context, Routes.bookingConfirmed, arguments: booking);
    } else {
      ScaffoldMessenger.of(this.context).showSnackBar(
        SnackBar(content: Text(provider.errorMessage), backgroundColor: AppColors.errorRed),
      );
    }
  }
}

// ── Shared Widgets ────────────────────────────────────────────────────────────

class _CardContainer extends StatelessWidget {
  final String title;
  final Widget child;
  const _CardContainer({required this.title, required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF3F4F6), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.greyDark)),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _PickupRow extends StatelessWidget {
  final String number, title, time;
  const _PickupRow({required this.number, required this.title, required this.time});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24, height: 24,
          decoration: const BoxDecoration(color: Color(0xFFFEF3DF), shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Text(number, style: const TextStyle(color: Color(0xFFCF8307), fontWeight: FontWeight.bold, fontSize: 11)),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.greyDark))),
        if (time.isNotEmpty) Text(time, style: const TextStyle(color: AppColors.greySecondary, fontSize: 12)),
      ],
    );
  }
}
