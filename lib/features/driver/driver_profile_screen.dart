import 'package:flutter/material.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Driver Profile Screen
// Keys used from ARB files:
//   personalInformation, vehicleInformation, appSettings, support,
//   fullName, phoneNumber, emailAddress, vehicleDetails, plateNumber,
//   notifications, manageYourAlerts, privacySecurity, controlYourData,
//   paymentMethods, manageWithdrawals, helpSupport, faqsAndContactUs,
//   logOut, rating, totalTrips, earned, driverActiveStatus, version
// ─────────────────────────────────────────────────────────────────────────────

class DriverProfileScreen extends StatelessWidget {
  const DriverProfileScreen({super.key});

  // Demo data — replace with real model in production
  static const String _driverName     = 'Ahmed Mohammed';
  static const String _driverNameAr   = 'أحمد محمد';
  static const String _driverInitial  = 'A';
  static const String _phoneValue     = '+872 59 123 4567';
  static const String _emailValue     = 'ahmed.m@ptuk.edu';
  static const String _vehicleValue   = '2022 Toyota Corolla';
  static const String _vehicleValueAr = '2022 تويوتا كورولا';
  static const String _plateValue     = 'PS 123456';
  static const String _ratingValue    = '4.8';
  static const String _tripsValue     = '23';
  static const String _earnedValue    = '₪780';

  @override
  Widget build(BuildContext context) {
    final l     = AppLocalizations.of(context)!;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final name    = isRtl ? _driverNameAr   : _driverName;
    final vehicle = isRtl ? _vehicleValueAr : _vehicleValue;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ────────────────────────────────────────────────────
            _HeaderCard(
              name:        name,
              initial:     _driverInitial,
              statusLabel: l.driverActiveStatus,
              ratingLabel: l.rating,
              tripsLabel:  l.totalTrips,
              earnedLabel: l.earned,
              ratingValue: _ratingValue,
              tripsValue:  _tripsValue,
              earnedValue: _earnedValue,
            ),

            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Personal Information ─────────────────────────────
                  _SectionLabel(text: l.personalInformation),
                  const SizedBox(height: 8),
                  _CardGroup(items: [
                    _InfoItem(
                      icon:     Icons.person_outline,
                      title:    l.fullName,
                      subtitle: name,
                    ),
                    _InfoItem(
                      icon:     Icons.phone_outlined,
                      title:    l.phoneNumber,
                      subtitle: _phoneValue,
                    ),
                    _InfoItem(
                      icon:     Icons.email_outlined,
                      title:    l.emailAddress,
                      subtitle: _emailValue,
                    ),
                  ]),

                  const SizedBox(height: 24),

                  // ── Vehicle Information ──────────────────────────────
                  _SectionLabel(text: l.vehicleInformation),
                  const SizedBox(height: 8),
                  _CardGroup(items: [
                    _InfoItem(
                      icon:     Icons.directions_car_outlined,
                      title:    l.vehicleDetails,
                      subtitle: vehicle,
                    ),
                    _InfoItem(
                      icon:     Icons.location_on_outlined,
                      title:    l.plateNumber,
                      subtitle: _plateValue,
                    ),
                  ]),

                  const SizedBox(height: 24),

                  // ── App Settings ─────────────────────────────────────
                  _SectionLabel(text: l.appSettings),
                  const SizedBox(height: 8),
                  _CardGroup(items: [
                    _InfoItem(
                      icon:     Icons.notifications_outlined,
                      title:    l.notifications,
                      subtitle: l.manageYourAlerts,
                    ),
                    _InfoItem(
                      icon:     Icons.shield_outlined,
                      title:    l.privacySecurity,
                      subtitle: l.controlYourData,
                    ),
                    _InfoItem(
                      icon:     Icons.credit_card_outlined,
                      title:    l.paymentMethods,
                      subtitle: l.manageWithdrawals,
                    ),
                  ]),

                  const SizedBox(height: 24),

                  // ── Support ──────────────────────────────────────────
                  _SectionLabel(text: l.support),
                  const SizedBox(height: 8),
                  _CardGroup(items: [
                    _InfoItem(
                      icon:     Icons.help_outline,
                      title:    l.helpSupport,
                      subtitle: l.faqsAndContactUs,
                    ),
                  ]),

                  const SizedBox(height: 24),

                  // ── Log Out ──────────────────────────────────────────
                  _LogOutButton(label: l.logOut),

                  const SizedBox(height: 24),

                  // ── Version ──────────────────────────────────────────
                  Center(
                    child: Text(
                      l.version,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: Color(0xFF6A7282),
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Header Card  (spec: 430 × 224.48 | padding 24 | gap 24)
// ─────────────────────────────────────────────────────────────────────────────
class _HeaderCard extends StatelessWidget {
  final String name;
  final String initial;
  final String statusLabel;
  final String ratingLabel;
  final String tripsLabel;
  final String earnedLabel;
  final String ratingValue;
  final String tripsValue;
  final String earnedValue;

  const _HeaderCard({
    required this.name,
    required this.initial,
    required this.statusLabel,
    required this.ratingLabel,
    required this.tripsLabel,
    required this.earnedLabel,
    required this.ratingValue,
    required this.tripsValue,
    required this.earnedValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        border: Border(
          bottom: BorderSide(color: Color(0xFFF3F4F6), width: 0.62),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 56, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back arrow + Avatar + Name/Status
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFF9FAFB),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, size: 20, color: Color(0xFF101828)),
              ),
              const SizedBox(width: 16),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFCF8307), Color(0xFFE09520)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFCF8307).withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  initial,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name — Bold 22px #101828
                  Text(
                    name,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      height: 1.5,
                      color: Color(0xFF101828),
                    ),
                  ),
                  // Status — Regular 14px #6A7282
                  Text(
                    statusLabel,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.5,
                      color: Color(0xFF6A7282),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Stats row
          Row(
            children: [
              _StatCell(value: ratingValue, label: ratingLabel),
              const SizedBox(width: 12),
              _StatCell(value: tripsValue,  label: tripsLabel),
              const SizedBox(width: 12),
              _StatCell(value: earnedValue, label: earnedLabel),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  final String value;
  final String label;
  const _StatCell({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            // Value — Bold 20px #101828
            Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 18,
                height: 1.5,
                color: Color(0xFF101828),
              ),
            ),
            const SizedBox(height: 4),
            // Label — Regular 11px #6A7282
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                fontSize: 12,
                height: 1.5,
                color: Color(0xFF6A7282),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section Label — Regular 13px uppercase letter-spacing 0.32 #6A7282
// ─────────────────────────────────────────────────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        fontSize: 13,
        height: 19.5 / 13,
        letterSpacing: 0.32,
        color: Color(0xFF6A7282),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Card group — App Settings spec: border-radius 16, border 0.62, box-shadow
// ─────────────────────────────────────────────────────────────────────────────
class _CardGroup extends StatelessWidget {
  final List<_InfoItem> items;
  const _CardGroup({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF3F4F6), width: 0.62),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            _InfoRow(item: items[i]),
            if (i < items.length - 1)
              const Divider(indent: 68, height: 1, thickness: 0.62, color: Color(0xFFF3F4F6)),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Data model + row widget
// ─────────────────────────────────────────────────────────────────────────────
class _InfoItem {
  final IconData icon;
  final String   title;
  final String   subtitle;
  const _InfoItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

class _InfoRow extends StatelessWidget {
  final _InfoItem item;
  const _InfoRow({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFF9FAFB),
              shape: BoxShape.circle,
            ),
            child: Icon(item.icon, size: 20, color: const Color(0xFF364153)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title — Medium 14px #101828
                Text(
                  item.title,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    height: 1.5,
                    color: Color(0xFF101828),
                  ),
                ),
                const SizedBox(height: 2),
                // Subtitle — Regular 13px #6A7282
                Text(
                  item.subtitle,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    height: 1.5,
                    color: Color(0xFF6A7282),
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 20, color: Color(0xFF9CA3AF)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Log Out — spec: border-radius 16, border #FFE2E2, box-shadow
// ─────────────────────────────────────────────────────────────────────────────
class _LogOutButton extends StatelessWidget {
  final String label;
  const _LogOutButton({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFFE2E2), width: 0.62),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFFFEF3F2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.logout, color: Color(0xFFE7000B), size: 20),
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  height: 1.5,
                  color: Color(0xFFE7000B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}