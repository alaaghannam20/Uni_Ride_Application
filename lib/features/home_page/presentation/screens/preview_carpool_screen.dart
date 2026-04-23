import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';
import 'offer_confirmation_screen.dart';

class PreviewCarpoolScreen extends StatelessWidget {
  final String pickupLocation;
  final String dropoffLocation;
  final String date;
  final String time;
  final int availableSeats;
  final int pricePerSeat;

  const PreviewCarpoolScreen({
    super.key,
    this.pickupLocation = 'City Center',
    this.dropoffLocation = 'PTUK University',
    this.date = 'Saturday, December 11, 2024',
    this.time = '4:40 AM',
    this.availableSeats = 1,
    this.pricePerSeat = 8,
  });

  int get _totalEarnings => availableSeats * pricePerSeat;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
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

                    // ── Departure Details (Image 2 Specs) ──
                    _sectionTitle(l.departure_details),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      height: 178.2, // Specified height
                      padding: const EdgeInsets.fromLTRB(20.61, 20.61, 20.61, 0.62), // Specified padding
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: const Border(
                          top: BorderSide(color: Color(0xFFF3F4F6), width: 0.62), // Specified border
                        ),
                      ),
                      child: Column(
                        children: [
                          _detailRow(
                            Icons.calendar_today_outlined,
                            l.date,
                            date,
                          ),
                          const Divider(height: 1, color: Color(0xFFF3F4F6), indent: 72),
                          _detailRow(
                            Icons.access_time_rounded,
                            l.departure_time,
                            time,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15.99), // Specified Gap

                    // ── Pricing Details (Image 3 Specs) ──
                    _sectionTitle(l.pricing_details),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      height: 213.4, // Specified height
                      padding: const EdgeInsets.fromLTRB(20.61, 20.61, 20.61, 0.62), // Specified padding
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: const Border(
                          top: BorderSide(color: Color(0xFFF3F4F6), width: 0.62),
                        ),
                        boxShadow: const [
                          // Specified shadows
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
                                        Text(l.available_seats, style: const TextStyle(fontSize: 12, color: Color(0xFF667085))),
                                        const SizedBox(height: 2),
                                        Text(
                                          l.localeName == 'ar'
                                              ? '$availableSeats ${availableSeats > 1 ? 'مقاعد' : 'مقعد'}'
                                              : '$availableSeats seat${availableSeats > 1 ? 's' : ''}',
                                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF101828)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(l.price_per_seat_label, style: const TextStyle(fontSize: 12, color: Color(0xFF667085))),
                                    const SizedBox(height: 2),
                                    Text(
                                      '₪ $pricePerSeat',
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
                                color: const Color(0xFFF0FDF4),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: const Color(0xFFDCFCE7)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(l.total_potential_earnings,
                                          style: const TextStyle(
                                              fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF166534))),
                                      const SizedBox(height: 4),
                                      Text(l.if_all_seats_booked,
                                          style: const TextStyle(fontSize: 12, color: Color(0xFF15803D))),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      const Text('₪',
                                          style: TextStyle(
                                              fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF15803D))),
                                      const SizedBox(width: 4),
                                      Text('$_totalEarnings',
                                          style: const TextStyle(
                                              fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF15803D))),
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
                        color: const Color(0xFFEFF6FF), // Specified background
                        borderRadius: BorderRadius.circular(16), // Specified radius
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Color(0xFFDBEAFE),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.check, color: Color(0xFF1D4ED8), size: 16),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(l.ready_to_post,
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF1E40AF))),
                                const SizedBox(height: 4),
                                Text(l.ready_to_post_sub,
                                    style: const TextStyle(fontSize: 12, color: Color(0xFF1E40AF), height: 1.4)),
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
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Color(0xFFF3F4F6), width: 0.62), // Specified border
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 52, 
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          Routes.offerConfirmation,
                          arguments: {
                            'pickupLocation': pickupLocation,
                            'dropoffLocation': dropoffLocation,
                            'date': date,
                            'time': time,
                            'availableSeats': availableSeats,
                            'pricePerSeat': pricePerSeat,
                          },
                        );
                      },
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
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFF2F4F7)),
              ),
              child: const Icon(Icons.arrow_back, size: 20, color: Color(0xFF101828)),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l.preview_your_offer,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF101828)),
              ),
              Text(
                l.review_before_posting,
                style: const TextStyle(fontSize: 14, color: Color(0xFF667085)),
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
      height: 250,
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
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                  child: const Icon(Icons.edit_outlined, size: 16, color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // --- Pickup Step ---
                    Row(
                      children: [
                        const Icon(Icons.circle, size: 12, color: Colors.white),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pickupLocation,
                                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, height: 1.2),
                              ),
                              Text(
                                l.pickup_loc,
                                style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // --- Drive Time ---
                    Row(
                      children: [
                        const SizedBox(width: 28),
                        Text(
                          '${l.approx_drive} 15 min drive',
                          style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 11),
                        ),
                      ],
                    ),
                    // --- Dropoff Step ---
                    Row(
                      children: [
                        const Icon(Icons.circle, size: 12, color: Colors.white),
                         const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                dropoffLocation,
                                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, height: 1.2),
                              ),
                              Text(
                                l.dropoff_loc,
                                style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
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

  Widget _sectionTitle(String text) => Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF101828)),
      );

  Widget _buildWhiteCard({required Widget child}) => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFF2F4F7)),
        ),
        child: child,
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
                Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF667085))),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF101828))),
              ],
            ),
          ],
        ),
      );

  Widget _iconBox(IconData icon) => Container(
        width: 44,
        height: 44,
        decoration: const BoxDecoration(color: Color(0xFFFFF7ED), shape: BoxShape.circle),
        child: Icon(icon, size: 22, color: const Color(0xFFCF8307)),
      );
}

class DashLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 5, dashSpace = 3, startY = 0;
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..strokeWidth = 1.2; // Thinner for design match
    while (startY < size.height) {
      canvas.drawLine(Offset(size.width / 2, startY), Offset(size.width / 2, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
