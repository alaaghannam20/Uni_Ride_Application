import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/trip_provider.dart';
import 'package:uni_ride_application/core/provider/profile_provider.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/core/storage/app_prefs.dart';
import 'package:uni_ride_application/features/home_page/data/models/my_trip_model.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen({super.key});

  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TripProvider>().fetchMyTrips();
      context.read<ProfileProvider>().fetchDriverProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l       = AppLocalizations.of(context)!;
    final profile = context.watch<ProfileProvider>().driverProfile;
    final trips   = context.watch<TripProvider>().myTrips;
    final state   = context.watch<TripProvider>().myTripsState;

    final scheduled = trips.where((t) =>
        t.status.toLowerCase() == 'scheduled' ||
        t.status.toLowerCase() == 'active' ||
        t.status.toLowerCase() == 'confirmed').toList();
    final history = trips.where((t) =>
        t.status.toLowerCase() == 'completed' ||
        t.status.toLowerCase() == 'cancelled').toList();
    final shown = _selectedTab == 0 ? scheduled : history;

    return Scaffold(
      backgroundColor: context.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, l, profile?.fullName ?? l.welcomeBack),
              const SizedBox(height: 20),
              _buildStatsRow(l, profile),
              const SizedBox(height: 20),
              _buildTabBar(l, scheduled.length, history.length),
              const SizedBox(height: 16),
              _buildTripList(context, l, state, shown),
              const SizedBox(height: 32),
              Center(
                child: Text('Powered by PTUK Engineering',
                    style: TextStyle(fontFamily: 'Inter', fontSize: 11, color: Colors.grey[400])),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, Routes.offerCarpool),
        backgroundColor: AppColors.orangeprimary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(l.offer_a_carpool, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    );
  }

  // ── Header ────────────────────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context, AppLocalizations l, String name) {
    return SizedBox(
      width: double.infinity,
      height: 61,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l.welcomeBack, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 14, color: AppColors.greySecondary)),
              Text(name, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 24, color: AppColors.greyDark)),
            ],
          ),
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'profile') {
                Navigator.pushNamed(context, Routes.driverprofile);
              } else if (value == 'logout') {
                await AppPrefs.logout();
                if (mounted) Navigator.pushNamedAndRemoveUntil(this.context, Routes.signIn, (r) => false);
              }
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'profile', child: Row(children: [Icon(Icons.person_outline, size: 18, color: AppColors.greyDark), SizedBox(width: 10), Text('Profile')])),
              const PopupMenuItem(value: 'logout',  child: Row(children: [Icon(Icons.logout, size: 18, color: AppColors.errorRed), SizedBox(width: 10), Text('Log Out', style: TextStyle(color: AppColors.errorRed))])),
            ],
            child: Container(
              width: 36, height: 36,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8, offset: const Offset(0, 2))]),
              child: const Icon(Icons.more_vert, size: 20, color: AppColors.greyDark),
            ),
          ),
        ],
      ),
    );
  }

  // ── Stats ─────────────────────────────────────────────────────────────────
  Widget _buildStatsRow(AppLocalizations l, dynamic profile) {
    final rating = profile?.rating?.toStringAsFixed(1) ?? '—';
    final trips  = '${profile?.totalTrips ?? 0}';

    return SizedBox(
      height: 52,
      child: Row(
        children: [
          _statItem(label: l.rating, value: rating, prefix: '★ ', prefixColor: AppColors.adminPrice),
          const SizedBox(width: 16),
          Container(width: 1, height: 32, color: AppColors.borderadmincolor),
          const SizedBox(width: 16),
          _statItem(label: l.trips, value: trips),
        ],
      ),
    );
  }

  Widget _statItem({required String label, required String value, String? prefix, Color? prefixColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 13, color: AppColors.greySecondary)),
        const SizedBox(height: 2),
        Row(
          children: [
            if (prefix != null) Text(prefix, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 20, height: 1, color: prefixColor ?? AppColors.greyDark)),
            Text(value, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 24, height: 1, color: AppColors.greyDark)),
          ],
        ),
      ],
    );
  }

  // ── Tab Bar ───────────────────────────────────────────────────────────────
  Widget _buildTabBar(AppLocalizations l, int scheduledCount, int historyCount) {
    final tabs = [
      '${l.scheduled} ($scheduledCount)',
      '${l.history} ($historyCount)',
    ];
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
                Text(tabs[i], style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 15, color: active ? AppColors.greyDark : AppColors.greyHint)),
                const SizedBox(height: 4),
                if (active) Container(height: 2, width: tabs[i].length * 8.0, decoration: BoxDecoration(color: AppColors.orangeprimary, borderRadius: BorderRadius.circular(2))),
              ],
            ),
          ),
        );
      }),
    );
  }

  // ── Trip List ─────────────────────────────────────────────────────────────
  Widget _buildTripList(BuildContext context, AppLocalizations l, TripState state, List<MyTripModel> trips) {
    if (state == TripState.loading) {
      return const Center(child: Padding(padding: EdgeInsets.all(40), child: CircularProgressIndicator(color: AppColors.orangeprimary)));
    }
    if (state == TripState.error) {
      return Center(child: Padding(padding: const EdgeInsets.all(24), child: Text(context.read<TripProvider>().errorMessage, style: const TextStyle(color: AppColors.errorRed))));
    }
    if (trips.isEmpty) {
      return Center(child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(children: [
          const Icon(Icons.directions_car_outlined, size: 48, color: AppColors.greyLight),
          const SizedBox(height: 12),
          Text(l.noTripsFound, style: const TextStyle(color: AppColors.greyHint, fontSize: 14)),
        ]),
      ));
    }
    return Column(children: trips.map((t) => _DriverTripCard(trip: t, isScheduled: _selectedTab == 0)).toList());
  }
}

// ── Driver Trip Card ──────────────────────────────────────────────────────────

class _DriverTripCard extends StatefulWidget {
  final MyTripModel trip;
  final bool isScheduled;
  const _DriverTripCard({required this.trip, required this.isScheduled});

  @override
  State<_DriverTripCard> createState() => _DriverTripCardState();
}

class _DriverTripCardState extends State<_DriverTripCard> {
  bool _loading = false;

  Future<void> _doAction(Future<bool> Function() action, VoidCallback onSuccess) async {
    setState(() => _loading = true);
    final ok = await action();
    if (!mounted) return;
    setState(() => _loading = false);
    if (ok) {
      context.read<TripProvider>().fetchMyTrips();
      onSuccess();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.read<TripProvider>().errorMessage), backgroundColor: AppColors.errorRed),
      );
    }
  }

  void _onCancel(AppLocalizations l) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.cancel_the_trip),
        content: Text(l.booking_confirmed_sub),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l.back_to_home)),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _doAction(() => context.read<TripProvider>().cancelTrip(widget.trip.tripId), () {});
            },
            child: Text(l.cancel_the_trip, style: const TextStyle(color: AppColors.errorRed)),
          ),
        ],
      ),
    );
  }

  void _onComplete(AppLocalizations l) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.completed),
        content: const Text('Mark this trip as completed?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('No')),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _doAction(() => context.read<TripProvider>().completeTrip(widget.trip.tripId), () {});
            },
            child: Text(l.completed, style: const TextStyle(color: AppColors.adminSuccessText)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l    = AppLocalizations.of(context)!;
    final trip = widget.trip;

    Color statusColor; Color statusBg; String statusLabel; IconData statusIcon;
    switch (trip.status.toLowerCase()) {
      case 'completed':
        statusColor = const Color(0xFF00A63E); statusBg = const Color(0xFFEFFBF3);
        statusIcon = Icons.check_circle_outline; statusLabel = l.completed; break;
      case 'cancelled':
        statusColor = AppColors.errorRed; statusBg = const Color(0xFFFFF2F2);
        statusIcon = Icons.cancel_outlined; statusLabel = l.cancelled; break;
      default:
        statusColor = AppColors.orangeprimary; statusBg = const Color(0xFFFFFAEE);
        statusIcon = Icons.access_time; statusLabel = l.upcoming;
    }

    String formattedDate = trip.departureTime;
    try {
      final dt = DateTime.parse(trip.departureTime);
      const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
      formattedDate = '${dt.day} ${months[dt.month-1]}  •  ${dt.hour.toString().padLeft(2,'0')}:${dt.minute.toString().padLeft(2,'0')}';
    } catch (_) {}

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ─────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(trip.tripCode, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 13, color: AppColors.orangeprimary)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(12)),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(statusIcon, size: 12, color: statusColor),
                  const SizedBox(width: 4),
                  Text(statusLabel, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: statusColor)),
                ]),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // ── Route ───────────────────────────────────────────────
          Row(children: [const Icon(Icons.circle, size: 8, color: AppColors.orangeprimary), const SizedBox(width: 8), Expanded(child: Text(trip.pickupLocation, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.greyDark)))]),
          Padding(padding: const EdgeInsets.only(left: 3), child: Container(width: 1.5, height: 14, color: AppColors.greyE5E, margin: const EdgeInsets.symmetric(vertical: 3))),
          Row(children: [const Icon(Icons.circle, size: 8, color: AppColors.greySecondary), const SizedBox(width: 8), Expanded(child: Text(trip.dropoffLocation, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.greyDark)))]),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppColors.greyE5E),
          const SizedBox(height: 10),

          // ── Footer ──────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                const Icon(Icons.calendar_today_outlined, size: 13, color: AppColors.greySecondary),
                const SizedBox(width: 4),
                Text(formattedDate, style: const TextStyle(fontSize: 11, color: AppColors.greySecondary)),
              ]),
              RichText(text: TextSpan(children: [
                const TextSpan(text: '₪ ', style: TextStyle(color: AppColors.orangeprimary, fontSize: 12, fontWeight: FontWeight.bold)),
                TextSpan(text: '${trip.pricePerSeat}', style: const TextStyle(color: AppColors.orangeprimary, fontSize: 14, fontWeight: FontWeight.bold)),
              ])),
            ],
          ),

          // ── Actions (Scheduled only) ─────────────────────────────
          if (widget.isScheduled) ...[
            const SizedBox(height: 12),
            _loading
                ? const Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: AppColors.orangeprimary, strokeWidth: 2)))
                : Row(children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _onCancel(l),
                        style: OutlinedButton.styleFrom(foregroundColor: AppColors.errorRed, side: const BorderSide(color: AppColors.errorRed), padding: const EdgeInsets.symmetric(vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        child: Text(l.cancel_the_trip, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _onComplete(l),
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.adminSuccessText, foregroundColor: Colors.white, elevation: 0, padding: const EdgeInsets.symmetric(vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                        child: Text(l.completed, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ]),
          ],
        ],
      ),
    );
  }
}
