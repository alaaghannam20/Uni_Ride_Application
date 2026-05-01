import 'package:flutter/material.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';
import 'package:uni_ride_application/features/home_page/presentation/screens/home_screen.dart';

class OfferConfirmationScreen extends StatelessWidget {
  final String pickupLocation;
  final String dropoffLocation;
  final String date;
  final String time;
  final int availableSeats;
  final int pricePerSeat;

  const OfferConfirmationScreen({
    super.key,
    this.pickupLocation = 'PTUK Main Gate',
    this.dropoffLocation = 'Engineering Building',
    this.date = '2024-05-20',
    this.time = '08:30 AM',
    this.availableSeats = 3,
    this.pricePerSeat = 8,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    final int potentialEarnings = availableSeats * pricePerSeat;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    
                    // ── Success Header Section (Image 2 specs) ──
                    Container(
                      width: 382,
                      // height: 168.49, // Calculated by content usually, but we'll use padding/gaps
                      child: Column(
                        children: [
                          const SizedBox(height: 32),
                          // Success Image (Custom Container Image)
                          Container(
                            width: 79.99,
                            height: 79.99,
                            child: Image.asset(
                              'assets/images/Container (5).png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(height: 12), // Gap: 12px
                          Text(
                            l.offer_posted,
                            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF101828)),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            l.offer_posted_sub,
                            style: const TextStyle(fontSize: 14, color: Color(0xFF667085)),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // ── Carpool ID Card (Image 3 specs) ──
                    Container(
                      width: 382.02,
                      height: 95.67,
                      padding: const EdgeInsets.only(top: 21.84, right: 21.84, bottom: 1.85, left: 21.84),
                      decoration: BoxDecoration(
                        color: const Color(0x0DCF8307), // #CF83070D
                        borderRadius: BorderRadius.circular(20),
                        border: const Border(
                          top: BorderSide(color: Color(0x33CF8307), width: 1.85), // #CF830733
                          bottom: BorderSide(color: Color(0x33CF8307), width: 1.85),
                          left: BorderSide(color: Color(0x33CF8307), width: 1.85),
                          right: BorderSide(color: Color(0x33CF8307), width: 1.85),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            l.carpool_id,
                            style: const TextStyle(fontSize: 13, color: Color(0xFF9E9E9E), fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 4), // Gap: 4px
                          const Text(
                            "CP-182451",
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFCF8307), letterSpacing: 0.5),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ── Route Summary Card (Image 4 specs) ──
                    Container(
                      width: 382.02,
                      height: 237.58,
                      padding: const EdgeInsets.only(top: 23.99, right: 23.99, left: 23.99),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFFCF8307), Color(0xFFE09520)],
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 4),
                            blurRadius: 6,
                            spreadRadius: -4,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 10),
                            blurRadius: 15,
                            spreadRadius: -3,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l.your_carpool_offer,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          const SizedBox(height: 15.99), // Gap: 15.99px
                          
                          // Path Visualization
                          Column(
                            children: [
                              // Pickup Row
                              Row(
                                children: [
                                  const CircleAvatar(radius: 5, backgroundColor: Colors.white),
                                  const SizedBox(width: 16),
                                  Text(pickupLocation, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white)),
                                ],
                              ),
                              // Middle Row (Dashed line + Date/Time)
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4),
                                    child: Column(
                                      children: [
                                        const SizedBox(height: 4),
                                        Container(width: 2, height: 4, color: Colors.white.withOpacity(0.4)),
                                        const SizedBox(height: 4),
                                        Container(width: 2, height: 4, color: Colors.white.withOpacity(0.4)),
                                        const SizedBox(height: 4),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Text("$date at $time", style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.8))),
                                ],
                              ),
                              // Dropoff Row
                              Row(
                                children: [
                                  const CircleAvatar(radius: 5, backgroundColor: Color(0xFFFDE68A)),
                                  const SizedBox(width: 16),
                                  Text(dropoffLocation, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white)),
                                ],
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 24),
                          Container(height: 1, color: Colors.white.withOpacity(0.1)),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Icon(Icons.people_outline, size: 20, color: Colors.white),
                              const SizedBox(width: 8),
                              Text("$availableSeats ${l.available_seats}", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
                              const SizedBox(width: 12),
                              const CircleAvatar(radius: 2, backgroundColor: Color(0xFFFDE68A)),
                              const SizedBox(width: 12),
                              const Icon(Icons.payments_outlined, size: 20, color: Colors.white),
                              const SizedBox(width: 4),
                              Text("₪$pricePerSeat${l.per_seat_label}", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ── Offer Statistics (Image 5 specs) ──
                    Container(
                      width: 382.02,
                      height: 173.11,
                      padding: const EdgeInsets.only(top: 20.61, right: 20.61, bottom: 0.62, left: 20.61),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFF3F4F6), width: 0.62),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 1),
                            blurRadius: 2,
                            spreadRadius: -1,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 1),
                            blurRadius: 3,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l.offer_statistics,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF101828)),
                          ),
                          const SizedBox(height: 15.99), // Gap: 15.99px
                          Row(
                            children: [
                              Expanded(
                                child: _statBox(l.available_seats, "$availableSeats", const Color(0xFFF9FAFB), const Color(0xFFCF8307)),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _statBox(l.potential_earnings, "₪$potentialEarnings", const Color(0xFFF0FDF4), const Color(0xFF16A34A)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // ── What Happens Next? (Image 1 specs) ──
                    Container(
                      width: 382.02,
                      height: 288.15,
                      padding: const EdgeInsets.only(top: 20.61, right: 20.61, bottom: 0.62, left: 20.61),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFF3F4F6), width: 0.62),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            offset: const Offset(0, 1),
                            blurRadius: 2,
                            spreadRadius: -1,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            offset: const Offset(0, 1),
                            blurRadius: 3,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l.what_happens_next,
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF101828)),
                          ),
                          const SizedBox(height: 15.99), // Gap: 15.99px
                          _nextStep(1, l.next1_title, l.next1_sub),
                          const SizedBox(height: 15.99),
                          _nextStep(2, l.next2_title, l.next2_sub),
                          const SizedBox(height: 15.99),
                          _nextStep(3, l.next3_title, l.next3_sub),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ── Secondary Action Buttons (Image 3 specs) ──
                    Container(
                      width: 382.02,
                      height: 51.72,
                      child: Row(
                        children: [
                          Expanded(
                            child: _secondaryButton(Icons.share_outlined, l.share),
                          ),
                          const SizedBox(width: 12), // Gap: 12px
                          Expanded(
                            child: _secondaryButton(Icons.list_alt_rounded, l.my_offers),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ── Pro Tip (Image 4 specs) ──
                    Container(
                      width: 382.02,
                      height: 113.96,
                      padding: const EdgeInsets.only(top: 15.99, left: 15.99, right: 15.99),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBEB),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(color: Color(0xFFFEF3C7), shape: BoxShape.circle),
                            child: const Icon(Icons.lightbulb_outline, color: Color(0xFFD97706), size: 20),
                          ),
                          const SizedBox(width: 12), // Gap: 12px
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l.pro_tip,
                                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFD97706)),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  l.pro_tip_description,
                                  style: const TextStyle(fontSize: 12, color: Color(0xFFB45309), height: 1.4),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            
            // ── Fixed Bottom Button ──
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                    (r) => false,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCF8307),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: Text(
                    l.done,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statBox(String label, String value, Color bg, Color valueColor) {
    // Image 2 internal box specs for Potential Earnings
    final isPositive = valueColor == const Color(0xFF16A34A);
    return Container(
      width: 158.40,
      height: 91.89,
      padding: const EdgeInsets.only(top: 16.61, right: 16.61, bottom: 0.62, left: 16.61),
      decoration: BoxDecoration(
        color: bg,
        gradient: isPositive ? const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF0FDF4), Color(0xFFECFDF5)],
        ) : null,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isPositive ? const Color(0xFFDCFCE7) : const Color(0xFFF3F4F6), width: 0.62),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: isPositive ? const Color(0xFF16A34A) : const Color(0xFF667085), fontWeight: FontWeight.w500)),
          const SizedBox(height: 8), // Gap: 8px
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: valueColor)),
        ],
      ),
    );
  }

  Widget _nextStep(int number, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(color: Color(0xFFEFF6FF), shape: BoxShape.circle),
          child: Center(child: Text("$number", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1D4ED8)))),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF101828))),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF667085), height: 1.3)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _secondaryButton(IconData icon, String label) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF344054)),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF344054))),
        ],
      ),
    );
  }
}
