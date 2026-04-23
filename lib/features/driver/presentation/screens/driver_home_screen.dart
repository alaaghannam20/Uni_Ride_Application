import 'package:flutter/material.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildStatsRow(),
              const SizedBox(height: 20),
              _buildActiveTripCard(),
              const SizedBox(height: 24),
              _buildTabBar(),
              const SizedBox(height: 32),
              Center(
                child: Text(
                  'Powered by PTUK Engineering',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 11,
                    color: Colors.grey[400],
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SizedBox(
      width: double.infinity,
      height: 61,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.welcomeBack,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.5, // 21/14
                  letterSpacing: 0,
                  color: Color(0xFF6A7282),
                ),
              ),
              Text(
                'Ahmed',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  height: 1.5, // 36/24
                  letterSpacing: 0,
                  color: Color(0xFF101828),
                ),
              ),
            ],
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.more_vert,
              size: 20,
              color: Color(0xFF101828),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    final l = AppLocalizations.of(context)!;

    return SizedBox(
      height: 52,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _statItem(label: l.today, value: '₪145'),
          const SizedBox(width: 16),
          Container(width: 1, height: 32, color: const Color(0xFFE5E7EB)),
          const SizedBox(width: 16),
          _statItem(
            label: l.rating,
            value: '4.8',
            prefix: '★ ',
            prefixColor: const Color(0xFFF5A623),
          ),
          const SizedBox(width: 16),
          Container(width: 1, height: 32, color: const Color(0xFFE5E7EB)),
          const SizedBox(width: 16),
          _statItem(label: l.trips, value: '23'),
        ],
      ),
    );
  }

  Widget _statItem({
    required String label,
    required String value,
    String? prefix,
    Color? prefixColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 13,
            height: 1.5,
            letterSpacing: 0,
            color: Color(0xFF6A7282),
          ),
        ),
        const SizedBox(height: 2),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (prefix != null)
              Text(
                prefix,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  height: 1,
                  color: prefixColor ?? const Color(0xFF101828),
                ),
              ),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 24,
                height: 1,
                letterSpacing: 0,
                color: Color(0xFF101828),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActiveTripCard() {
    final l = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFCF8307), width: 1.85),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 3,
            spreadRadius: 0,
            offset: Offset(0, 1),
          ),
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 2,
            spreadRadius: -1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.only(
        top: 21.84,
        right: 21.84,
        left: 21.84,
        bottom: 1.85,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFCF8307),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                   Text(
                    l.activeTrip,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      height: 1.5,
                      letterSpacing: 0,
                      color: Color(0xFF101828),
                    ),
                  ),
                ],
              ),
               Text(
                l.pickupIn5Min,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  height: 1.5,
                  letterSpacing: 0,
                  color: Color(0xFF6A7282),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.person_outline,
                  size: 20,
                  color: Color(0xFF6A7282),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Laila H.',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        height: 1.5,
                        letterSpacing: 0,
                        color: Color(0xFF101828),
                      ),
                    ),
                    Text(
                      '4.5 km',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        height: 1.5,
                        letterSpacing: 0,
                        color: Color(0xFF6A7282),
                      ),
                    ),
                  ],
                ),
              ),
              const Text(
                '₪8',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  height: 1,
                  letterSpacing: 0,
                  color: Color(0xFFCF8307),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Row(
            children: const [
              Icon(
                Icons.location_on_outlined,
                size: 16,
                color: Color(0xFF6A7282),
              ),
              SizedBox(width: 6),
              Text(
                "PTUK University",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  height: 1.5,
                  letterSpacing: 0,
                  color: Color(0xFF101828),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 22),
            child: Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 22),
            child: Text(
              "City Center",
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
                fontSize: 14,
                height: 1.5,
                letterSpacing: 0,
                color: Color(0xFF101828),
              ),
            ),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(child: _actionBtn(Icons.phone_outlined, l.call)),
              SizedBox(width: 10),
              Expanded(child: _actionBtn(Icons.chat_bubble_outline, l.message)),
              SizedBox(width: 10),
              SizedBox(
                width: 112.78,
                height: 44.99,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFCF8307),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  icon: Icon(
                    Icons.navigation_outlined,
                    size: 16,
                    color: Colors.white,
                  ),
                  label: Text(
                    l.navigate,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 1.5,
                      letterSpacing: 0,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 1.85),
        ],
      ),
    );
  }

  Widget _actionBtn(IconData icon, String label) {
    return SizedBox(
      height: 44.99,
      child: OutlinedButton.icon(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF364153),
          side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.zero,
        ),
        icon: Icon(icon, size: 16, color: const Color(0xFF364153)),
        label: Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            height: 1.5,
            letterSpacing: 0,
            color: Color(0xFF364153),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    final l = AppLocalizations.of(context)!;
    final tabs = [l.scheduled, l.history];

    return Row(
      children: List.generate(tabs.length, (i) {
        final active = _selectedTab == i;
        return GestureDetector(
          onTap: () => setState(() => _selectedTab = i),
          child: Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tabs[i],
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    height: 22.5 / 15,
                    letterSpacing: 0,
                    color: active
                        ? const Color(0xFF101828)
                        : const Color(0xFF99A1AF),
                  ),
                ),
                const SizedBox(height: 4),
                if (active)
                  Container(
                    height: 2,
                    width: tabs[i].length * 8.4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFCF8307),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
