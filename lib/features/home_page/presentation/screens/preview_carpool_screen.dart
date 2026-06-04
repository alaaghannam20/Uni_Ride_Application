import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/trip_provider.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class PreviewCarpoolScreen extends StatefulWidget {
  final String pickupLocation;
  final String dropoffLocation;
  final String date;
  final String time;
  final int availableSeats;
  final int pricePerSeat;
  final int duration;

  const PreviewCarpoolScreen({
    super.key,
    this.pickupLocation  = 'City Center',
    this.dropoffLocation = 'PTUK University',
    this.date            = 'Saturday, December 11, 2024',
    this.time            = '4:40 AM',
    this.availableSeats  = 1,
    this.pricePerSeat    = 8,
    this.duration        = 15,
    this.stops           = const [],
  });

  final List<Map<String, dynamic>> stops;

  @override
  State<PreviewCarpoolScreen> createState() => _PreviewCarpoolScreenState();
}

class _PreviewCarpoolScreenState extends State<PreviewCarpoolScreen> {
  int get _totalEarnings => widget.availableSeats * widget.pricePerSeat;

  String _buildDepartureTime() {
    try {
      // date format: "yyyy-MM-dd" or "Saturday, Dec 11"
      // time format: "08:30 AM" or "4:40 AM"
      final timeParts = widget.time.trim().split(RegExp(r'[\s:]'));
      int hour   = int.tryParse(timeParts[0]) ?? 8;
      int minute = int.tryParse(timeParts[1]) ?? 0;
      final isPM = widget.time.toUpperCase().contains('PM');
      if (isPM && hour != 12) hour += 12;
      if (!isPM && hour == 12) hour = 0;

      DateTime? dt;
      try { dt = DateTime.parse(widget.date); } catch (_) {}
      dt ??= DateTime.now();

      return '${dt.year}-${dt.month.toString().padLeft(2,'0')}-${dt.day.toString().padLeft(2,'0')}T${hour.toString().padLeft(2,'0')}:${minute.toString().padLeft(2,'0')}:00';
    } catch (_) {
      return '${widget.date}T${widget.time}';
    }
  }

  Future<void> _onConfirm() async {
    final provider = context.read<TripProvider>();

    // Step 1: Create trip
    final created = await provider.createTrip(
      pickupLocation:  widget.pickupLocation,
      dropoffLocation: widget.dropoffLocation,
      departureTime:   _buildDepartureTime(),
      pricePerSeat:    widget.pricePerSeat.toDouble(),
      totalSeats:      widget.availableSeats,
      description:              'estimatedDurationMinutes:${widget.duration}',
      estimatedDurationMinutes: widget.duration,
      stops:           [],
    );
    if (!mounted) return;

    if (created == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.errorMessage), backgroundColor: AppColors.errorRed),
      );
      return;
    }

    // Step 2: Get the real tripId - either from create response or from scheduled list
    int tripIdToPublish = created;
    if (tripIdToPublish == 0) {
      await provider.fetchDriverScheduled();
      if (!mounted) return;
      if (provider.driverScheduled.isNotEmpty) {
        tripIdToPublish = provider.driverScheduled.first.tripId;
      }
    }

    if (tripIdToPublish == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.failedToGetTripId), backgroundColor: Colors.red),
      );
      return;
    }

    // Step 3: Publish
    final published = await provider.publishTrip(tripIdToPublish);
    if (!mounted) return;

    if (!published) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(provider.errorMessage), backgroundColor: AppColors.errorRed),
      );
      return;
    }

    Navigator.pushReplacementNamed(
      context,
      Routes.offerConfirmation,
      arguments: {
        'pickupLocation':  widget.pickupLocation,
        'dropoffLocation': widget.dropoffLocation,
        'date':            widget.date,
        'time':            widget.time,
        'availableSeats':  widget.availableSeats,
        'pricePerSeat':    widget.pricePerSeat,
        'stops':           widget.stops,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: context.bgWhite,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Bar ──
            _buildHeader(context, l),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Route Orange Card ──
                    _buildRouteCard(l),

                    const SizedBox(height: 15.99), // Specified Gap

                    // ── Pricing Details ──
                    _sectionTitle(l.pricing_details),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20.61, 0, 20.61, 20.61),
                      decoration: BoxDecoration(
                        color: context.bgWhite,
                        borderRadius: BorderRadius.circular(20),
                        border: Border(
                          top: BorderSide(color: context.borderColor, width: 0.62),
                        ),
                        boxShadow: context.isDark ? [] : const [
                          BoxShadow(
                            color: Color(0x1A000000),
                            offset: Offset(0, 1),
                            blurRadius: 2,
                            spreadRadius: -1,
                          ),
                          BoxShadow(
                            color: Color(0x1A000000),
                            offset: Offset(0, 1),
                            blurRadius: 3,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // ── Date + Time (below top line, above seats) ──
                          _detailRow(Icons.calendar_today_outlined, l.date, widget.date),
                          Divider(height: 1, color: context.borderColor, indent: 72),
                          _detailRow(Icons.access_time_rounded, l.departure_time, widget.time),
                          Divider(height: 1, color: context.borderColor),
                          const SizedBox(height: 20.61),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Row(
                                  children: [
                                    _iconBox(Icons.people_outline),
                                    const SizedBox(width: 16),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(l.available_seats, style: TextStyle(fontSize: 12, color: context.textSecondary)),
                                        const SizedBox(height: 2),
                                        Text(
                                          l.localeName == 'ar'
                                              ? '${widget.availableSeats} ${widget.availableSeats > 1 ? 'مقاعد' : 'مقعد'}'
                                              : '${widget.availableSeats} seat${widget.availableSeats > 1 ? 's' : ''}',
                                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: context.textPrimary),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(l.price_per_seat_label, style: TextStyle(fontSize: 12, color: context.textSecondary)),
                                    const SizedBox(height: 2),
                                    Text(
                                      '₪ ${widget.pricePerSeat}',
                                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFFCF8307)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // Earnings Summary Card
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              decoration: BoxDecoration(
                                color: context.isDark ? const Color(0xFF064E3B) : const Color(0xFFF0FDF4),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: context.isDark ? const Color(0xFF065F46) : const Color(0xFFDCFCE7)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(l.total_potential_earnings,
                                          style: TextStyle(
                                              fontSize: 14, fontWeight: FontWeight.w600, color: context.isDark ? const Color(0xFF6EE7B7) : const Color(0xFF166534))),
                                      const SizedBox(height: 4),
                                      Text(l.if_all_seats_booked,
                                          style: TextStyle(fontSize: 12, color: context.isDark ? const Color(0xFFA7F3D0) : const Color(0xFF15803D))),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text('₪',
                                          style: TextStyle(
                                              fontSize: 18, fontWeight: FontWeight.bold, color: context.isDark ? const Color(0xFF6EE7B7) : const Color(0xFF15803D))),
                                      const SizedBox(width: 4),
                                      Text('$_totalEarnings',
                                          style: TextStyle(
                                              fontSize: 28, fontWeight: FontWeight.bold, color: context.isDark ? const Color(0xFF6EE7B7) : const Color(0xFF15803D))),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 15.99), // Specified Gap

                    // ── Ready to Post Banner (Image 4 Specs) ──
                    Container(
                      width: double.infinity,
                      height: 113.9, // Specified height
                      padding: const EdgeInsets.fromLTRB(15.99, 15.99, 15.99, 15.99),
                      decoration: BoxDecoration(
                        color: context.isDark ? const Color(0xFF1E3A8A).withValues(alpha: 0.3) : const Color(0xFFEFF6FF), // Specified background
                        borderRadius: BorderRadius.circular(16), // Specified radius
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: context.isDark ? const Color(0xFF1E40AF) : const Color(0xFFDBEAFE),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.check, color: context.isDark ? const Color(0xFFBFDBFE) : const Color(0xFF1D4ED8), size: 16),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(l.ready_to_post,
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: context.isDark ? const Color(0xFFBFDBFE) : const Color(0xFF1E40AF))),
                                const SizedBox(height: 4),
                                Text(l.ready_to_post_sub,
                                    style: TextStyle(fontSize: 12, color: context.isDark ? const Color(0xFF93C5FD) : const Color(0xFF1E40AF), height: 1.4)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // ── Bottom Action Area (Image 5 Specs) ──
            Container(
              width: double.infinity,
              height: 88.5, // Specified height
              padding: const EdgeInsets.fromLTRB(23.99, 16.61, 23.99, 0), // Specified padding
              decoration: BoxDecoration(
                color: context.bgWhite,
                border: Border(
                  top: BorderSide(color: context.borderColor, width: 0.62), // Specified border
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 52, 
                    child: Consumer<TripProvider>(
                      builder: (context, provider, _) => ElevatedButton(
                      onPressed: provider.createState == TripState.loading ? null : _onConfirm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFCF8307),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                      child: Text(
                        l.post_carpool_offer,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
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

  Widget _buildHeader(BuildContext context, AppLocalizations l) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: context.bgWhite,
                shape: BoxShape.circle,
                border: Border.all(color: context.borderColor),
              ),
              child: Icon(Icons.arrow_back, size: 20, color: context.textPrimary),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.preview_your_offer,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: context.textPrimary),
              ),
              Text(
                l.review_before_posting,
                style: TextStyle(fontSize: 14, color: context.textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRouteCard(AppLocalizations l) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(23.99),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFCF8307), Color(0xFFE09520)],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -4,
          ),
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 10),
            blurRadius: 15,
            spreadRadius: -3,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l.your_route,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.2), shape: BoxShape.circle),
                  child: const Icon(Icons.edit_outlined, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          IntrinsicHeight(
            child: Stack(
              children: [
                // Dashed Line Layer
                Positioned(
                  left: 5,
                  top: 10,
                  bottom: 10,
                  child: CustomPaint(
                    size: const Size(2, double.infinity),
                    painter: DashLinePainter(),
                  ),
                ),
                // Content Layer
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _routeStep(widget.pickupLocation, l.pickup_loc, true),
                    const SizedBox(height: 16),
                    _routeStep(widget.dropoffLocation, l.dropoff_loc, false),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _routeStep(String location, String label, bool isWhite, {bool isStop = false}) {
    return Row(
      children: [
        Icon(
          isStop ? Icons.location_on_outlined : Icons.circle, 
          size: isStop ? 14 : 12, 
          color: isWhite ? Colors.white : Colors.white.withValues(alpha: 0.8)
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                location,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                label,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String text) => Text(
        text,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: context.textPrimary),
      );

  Widget _detailRow(IconData icon, String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            _iconBox(icon),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 12, color: context.textSecondary)),
                const SizedBox(height: 2),
                Text(value, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: context.textPrimary)),
              ],
            ),
          ],
        ),
      );

  Widget _iconBox(IconData icon) => Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(color: context.isDark ? AppColors.orangeprimary.withValues(alpha: 0.1) : const Color(0xFFFFF7ED), shape: BoxShape.circle),
        child: Icon(icon, size: 22, color: AppColors.orangeprimary),
      );
}

class DashLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 3, startY = 0;
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..strokeWidth = 1.2; // Thinner for design match
    while (startY < size.height) {
      canvas.drawLine(Offset(size.width / 2, startY), Offset(size.width / 2, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
