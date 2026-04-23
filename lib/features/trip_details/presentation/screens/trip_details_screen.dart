import 'package:flutter/material.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class TripDetailsScreen extends StatelessWidget {
  const TripDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    
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
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFF3F4F6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Color(0xFF101828), size: 20),
              ),
            ),
          ),
        ),
        title: Text(
          l.tripDetails,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: Color(0xFF101828),
          ),
        ),
        centerTitle: false,
        titleSpacing: 5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildGoldenCard(context),
            const SizedBox(height: 16),
            _buildDriverInfo(context),
            const SizedBox(height: 16),
            _buildPickupPoints(context),
            const SizedBox(height: 16),
            _buildAvailableSeats(context),
            const SizedBox(height: 16),
            _buildSelectSeats(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildGoldenCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFCF8307),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  const SizedBox(height: 4),
                  Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                  const SizedBox(height: 4),
                  _buildDashedLine(),
                  Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('PTUK University', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                    const SizedBox(height: 2),
                    const Text('Tulkarm, Palestine', style: TextStyle(color: Colors.white70, fontSize: 12)),
                    const SizedBox(height: 12),
                    Row(
                      children: const [
                        _TripChip(icon: Icons.access_time, label: '15 min'),
                        SizedBox(width: 8),
                        _TripChip(icon: Icons.location_on_outlined, label: '8.5 km'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('City Center', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                    const SizedBox(height: 2),
                    const Text('Main Square, Tulkarm', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white24, height: 1),
          const SizedBox(height: 16),
          Row(
            children: const [
              Icon(Icons.calendar_today_outlined, color: Colors.white, size: 16),
              SizedBox(width: 8),
              Text('Today, March 2 • 2:30 PM', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDashedLine() {
    return Column(
      children: List.generate(
        7,
        (index) => Container(
          width: 1.5,
          height: 4,
          color: Colors.white60,
          margin: const EdgeInsets.only(bottom: 4),
        ),
      ),
    );
  }

  Widget _buildDriverInfo(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return _CardContainer(
      title: l.driverInfo,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: Color(0xFFCF8307),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Text('M', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Mohammed K.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF101828))),
                    const SizedBox(height: 4),
                    Row(
                      children: const [
                        Icon(Icons.star, color: Color(0xFFF5A623), size: 14),
                        SizedBox(width: 4),
                        Text('4.8 • 142 trips', style: TextStyle(color: Color(0xFF6A7282), fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              const _CircleIconBtn(icon: Icons.phone_outlined),
              const SizedBox(width: 8),
              const _CircleIconBtn(icon: Icons.chat_bubble_outline),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFFF9FAFB), borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                const Icon(Icons.directions_car_outlined, color: Color(0xFF6A7282), size: 20),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Hyundai i10 • White', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF101828))),
                    SizedBox(height: 4),
                    Text('Plate: AB 1234 • Year: 2021', style: TextStyle(color: Color(0xFF6A7282), fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPickupPoints(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return _CardContainer(
      title: l.pickup_points,
      child: Column(
        children: [
          _PickupRow(number: '1', title: l.pickup_ptuk_gate, time: '2:30 PM'),
          const SizedBox(height: 16),
          _PickupRow(number: '2', title: l.pickup_eng_building, time: '2:32 PM'),
          const SizedBox(height: 16),
          _PickupRow(number: '3', title: l.pickup_student_housing, time: '2:35 PM'),
        ],
      ),
    );
  }

  Widget _buildAvailableSeats(BuildContext context) {
    final l = AppLocalizations.of(context)!;
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
              Text(l.availableSeats, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF101828))),
              const SizedBox(height: 4),
              Text('3 of 4 ${l.seats_remaining}', style: const TextStyle(color: Color(0xFF6A7282), fontSize: 12)),
            ],
          ),
          Row(
            children: const [
              Icon(Icons.people_outline, color: Color(0xFFCF8307), size: 20),
              SizedBox(width: 8),
              Text('3', style: TextStyle(color: Color(0xFFCF8307), fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSelectSeats(BuildContext context) {
    final l = AppLocalizations.of(context)!;
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
                  Text(l.how_many_seats, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF101828))),
                  const SizedBox(height: 4),
                  Text('3 ${l.seats_available}', style: const TextStyle(color: Color(0xFF6A7282), fontSize: 11)),
                ],
              ),
              Row(
                children: [
                  const _StepperBtn(icon: Icons.remove, color: Color(0xFFFEF3DF), iconColor: Color(0xFFCF8307)),
                  const SizedBox(width: 12),
                  Container(
                    width: 36,
                    height: 40,
                    decoration: BoxDecoration(color: const Color(0xFFCF8307), borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: const Text('3', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  const SizedBox(width: 12),
                  const _StepperBtn(icon: Icons.add, color: Color(0xFFF3F4F6), iconColor: Color(0xFF9CA3AF)),
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
                    Text(l.pricePerSeat, style: const TextStyle(color: Color(0xFF6A7282), fontSize: 12)),
                    const Text('₪ 8', style: TextStyle(color: Color(0xFF101828), fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(l.numberOfSeats, style: const TextStyle(color: Color(0xFF6A7282), fontSize: 12)),
                    const Text('× 3', style: TextStyle(color: Color(0xFF101828), fontSize: 12, fontWeight: FontWeight.w500)),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(color: Color(0xFFE5E7EB), height: 1),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(l.total, style: const TextStyle(color: Color(0xFF101828), fontSize: 14, fontWeight: FontWeight.bold)),
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(text: '₪ ', style: TextStyle(color: Color(0xFFCF8307), fontSize: 12, fontWeight: FontWeight.bold)),
                          TextSpan(text: '24', style: TextStyle(color: Color(0xFFCF8307), fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
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
  Widget _buildBottomBar(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14), 
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -4)),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(l.total_price, style: const TextStyle(color: Color(0xFF6A7282), fontSize: 11)),
                const SizedBox(height: 4),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(text: '₪ ', style: TextStyle(color: Color(0xFFCF8307), fontSize: 14, fontWeight: FontWeight.bold)),
                      TextSpan(text: '24', style: TextStyle(color: Color(0xFFCF8307), fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
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
                      onPressed: () {
                        Navigator.pushNamed(context, '/BookingConfirmedScreen');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFCF8307),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 14), 
                        elevation: 0,
                      ),
                      child: Text(l.book_now, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)), 
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {},
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
}

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
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF101828))),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _TripChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _TripChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 14),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _PickupRow extends StatelessWidget {
  final String number;
  final String title;
  final String time;

  const _PickupRow({required this.number, required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(color: Color(0xFFFEF3DF), shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Text(number, style: const TextStyle(color: Color(0xFFCF8307), fontWeight: FontWeight.bold, fontSize: 11)),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF101828)))),
        Text(time, style: const TextStyle(color: Color(0xFF6A7282), fontSize: 12)),
      ],
    );
  }
}

class _CircleIconBtn extends StatelessWidget {
  final IconData icon;

  const _CircleIconBtn({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: const BoxDecoration(color: Color(0xFFFEF3DF), shape: BoxShape.circle),
      child: Icon(icon, color: const Color(0xFFCF8307), size: 18),
    );
  }
}

class _StepperBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color iconColor;

  const _StepperBtn({required this.icon, required this.color, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(icon, color: iconColor, size: 18),
    );
  }
}