import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
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
      backgroundColor: context.bgWhite,
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
                            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: context.textPrimary),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            l.offer_posted_sub,
                            style: TextStyle(fontSize: 14, color: context.textSecondary),
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
                        color: context.isDark ? const Color(0xFFCF8307).withValues(alpha: 0.1) : const Color(0x0DCF8307), // #CF83070D
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0x33CF8307), width: 1.85), // #CF830733
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            l.carpool_id,
                            style: TextStyle(fontSize: 13, color: context.textSecondary, fontWeight: FontWeight.w400),
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
                        color: context.bgWhite,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: context.borderColor, width: 0.62),
                        boxShadow: context.isDark ? [] : [
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
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: context.textPrimary),
                          ),
                          const SizedBox(height: 15.99), // Gap: 15.99px
                          Row(
                            children: [
                              Expanded(
                                child: _statBox(context, l.available_seats, "$availableSeats", const Color(0xFFF9FAFB), const Color(0xFFCF8307)),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _statBox(context, l.potential_earnings, "₪$potentialEarnings", const Color(0xFFF0FDF4), const Color(0xFF16A34A)),
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
                        color: context.bgWhite,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: context.borderColor, width: 0.62),
                        boxShadow: context.isDark ? [] : [
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
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: context.textPrimary),
                          ),
                          const SizedBox(height: 15.99), // Gap: 15.99px
                          _nextStep(context, 1, l.next1_title, l.next1_sub),
                          const SizedBox(height: 15.99),
                          _nextStep(context, 2, l.next2_title, l.next2_sub),
                          const SizedBox(height: 15.99),
                          _nextStep(context, 3, l.next3_title, l.next3_sub),
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
                            child: _secondaryButton(context, Icons.share_outlined, l.share),
                          ),
                          const SizedBox(width: 12), // Gap: 12px
                          Expanded(
                            child: _secondaryButton(context, Icons.list_alt_rounded, l.my_offers),
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
                        color: context.isDark ? const Color(0xFF451A03).withValues(alpha: 0.3) : const Color(0xFFFFFBEB),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(color: context.isDark ? const Color(0xFF78350F) : const Color(0xFFFEF3C7), shape: BoxShape.circle),
                            child: Icon(Icons.lightbulb_outline, color: context.isDark ? const Color(0xFFFCD34D) : const Color(0xFFD97706), size: 20),
                          ),
                          const SizedBox(width: 12), // Gap: 12px
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l.pro_tip,
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: context.isDark ? const Color(0xFFFCD34D) : const Color(0xFFD97706)),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  l.pro_tip_description,
                                  style: TextStyle(fontSize: 12, color: context.isDark ? const Color(0xFFFDE68A) : const Color(0xFFB45309), height: 1.4),
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
                    backgroundColor: AppColors.orangeprimary,
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

  Widget _statBox(BuildContext context, String label, String value, Color bg, Color valueColor) {
    final isPositive = valueColor == const Color(0xFF16A34A);
    final isDark = context.isDark;

    final Color boxColor = isPositive
        ? (isDark ? const Color(0xFF064E3B) : bg)
        : (isDark ? const Color(0xFF1F2937) : bg);

    final Gradient? boxGradient = isPositive && !isDark
        ? const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFF0FDF4), Color(0xFFECFDF5)],
          )
        : null;

    final Color borderColor = isPositive
        ? (isDark ? const Color(0xFF065F46) : const Color(0xFFDCFCE7))
        : (isDark ? const Color(0xFF374151) : context.borderColor);

    final Color textColor = isPositive
        ? (isDark ? const Color(0xFF6EE7B7) : const Color(0xFF16A34A))
        : (isDark ? const Color(0xFF9CA3AF) : context.textSecondary);

    final Color valueTextColor = isPositive
        ? (isDark ? const Color(0xFF6EE7B7) : const Color(0xFF16A34A))
        : (isDark ? const Color(0xFFCF8307) : valueColor);

    return Container(
      width: 158.40,
      height: 91.89,
      padding: const EdgeInsets.only(top: 16.61, right: 16.61, bottom: 0.62, left: 16.61),
      decoration: BoxDecoration(
        color: boxColor,
        gradient: boxGradient,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 0.62),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: textColor, fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: valueTextColor)),
        ],
      ),
    );
  }

  Widget _nextStep(BuildContext context, int number, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(color: context.isDark ? const Color(0xFF1E40AF) : const Color(0xFFEFF6FF), shape: BoxShape.circle),
          child: Center(child: Text("$number", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: context.isDark ? const Color(0xFFBFDBFE) : const Color(0xFF1D4ED8)))),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: context.textPrimary)),
              const SizedBox(height: 4),
              Text(subtitle, style: TextStyle(fontSize: 12, color: context.textSecondary, height: 1.3)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _secondaryButton(BuildContext context, IconData icon, String label) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: context.bgSubtle,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: context.textPrimary),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: context.textPrimary)),
        ],
      ),
    );
  }
}
