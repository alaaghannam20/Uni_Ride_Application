import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/profile_provider.dart';
import 'package:uni_ride_application/core/provider/trip_provider.dart';
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
      context.read<ProfileProvider>().fetchDriverProfile();
      context.read<TripProvider>().fetchDriverScheduled();
      context.read<TripProvider>().fetchDriverHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l          = AppLocalizations.of(context)!;
    final profile    = context.watch<ProfileProvider>().driverProfile;
    final tripProv   = context.watch<TripProvider>();
    final scheduled  = tripProv.driverScheduled;
    final history    = tripProv.driverHistory;
    final shown      = _selectedTab == 0 ? scheduled : history;
    final isLoading  = _selectedTab == 0
        ? tripProv.scheduledState == TripState.loading
        : tripProv.historyState   == TripState.loading;

    return Scaffold(
      backgroundColor: context.bgWhite,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(context, Routes.createTrip),
        backgroundColor: AppColors.orangeprimary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(l.scheduleTrip, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, l, profile?.fullName ?? l.welcomeBack, profile?.profilePicturePath),
              const SizedBox(height: 20),
              _buildStatsRow(context, l, profile),
              const SizedBox(height: 48),
              _buildTabBar(context, l, scheduled.length, history.length),
              const SizedBox(height: 20),
              if (isLoading)
                const Center(child: Padding(padding: EdgeInsets.all(40), child: CircularProgressIndicator(color: AppColors.orangeprimary)))
              else if (shown.isEmpty)
                Center(child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(children: [
                    Icon(Icons.directions_car_outlined, size: 48, color: context.textHint),
                    const SizedBox(height: 12),
                    Text(l.noTripsFound, style: TextStyle(color: context.textHint, fontSize: 14)),
                  ]),
                ))
              else
                ...shown.map((t) => _selectedTab == 0
                    ? _ScheduledCard(trip: t)
                    : _HistoryCard(trip: t)),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations l, String name, String? imagePath) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Container(
            width: 48, height: 48,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.orangeprimary.withValues(alpha: 0.15),
            ),
            child: imagePath != null
                ? Image.network(
                    'http://uniride.runasp.net/$imagePath',
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Center(child: Text(initial, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.orangeprimary))),
                  )
                : Center(child: Text(initial, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.orangeprimary))),
          ),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(l.welcomeBack, style: TextStyle(fontSize: 14, color: context.textSecondary)),
            Text(name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: context.textPrimary)),
          ]),
        ]),
        PopupMenuButton<String>(
          onSelected: (value) async {
            if (value == 'profile') {
              Navigator.pushNamed(context, Routes.driverprofile);
            } else if (value == 'logout') {
              await AppPrefs.logout();
              if (mounted) Navigator.pushNamedAndRemoveUntil(this.context, Routes.signIn, (r) => false);
            }
          },
          color: context.bgCard,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          itemBuilder: (_) => [
            PopupMenuItem(value: 'profile', child: Row(children: [Icon(Icons.person_outline, size: 18, color: context.textPrimary), const SizedBox(width: 10), Text(AppLocalizations.of(context)!.profileMenuItem, style: TextStyle(color: context.textPrimary))])),
            PopupMenuItem(value: 'logout', child: Row(children: [const Icon(Icons.logout, size: 18, color: AppColors.errorRed), const SizedBox(width: 10), Text(AppLocalizations.of(context)!.logOut, style: const TextStyle(color: AppColors.errorRed))])),
          ],
          child: Container(
            width: 36, height: 36,
            decoration: BoxDecoration(color: context.bgCard, borderRadius: BorderRadius.circular(10), border: Border.all(color: context.borderColor)),
            child: Icon(Icons.more_vert, size: 20, color: context.textPrimary),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow(BuildContext context, AppLocalizations l, dynamic profile) {
    return Row(children: [
      Expanded(child: _statItem(context, label: l.today,  value: '${profile?.earned ?? 0}', prefix: '₪', prefixColor: AppColors.orangeprimary, align: CrossAxisAlignment.center)),
      Container(width: 1, height: 32, color: context.borderColor),
      Expanded(child: _statItem(context, label: l.rating, value: profile?.rating?.toStringAsFixed(1) ?? '0.0', prefix: '★', prefixColor: AppColors.adminPrice, align: CrossAxisAlignment.center)),
      Container(width: 1, height: 32, color: context.borderColor),
      Expanded(child: _statItem(context, label: l.trips,  value: '${profile?.totalTrips ?? 0}', align: CrossAxisAlignment.center)),
    ]);
  }

  Widget _statItem(BuildContext context, {required String label, required String value, String? prefix, Color? prefixColor, CrossAxisAlignment align = CrossAxisAlignment.start}) {
    return Column(crossAxisAlignment: align, children: [
      Text(label, style: TextStyle(fontSize: 13, color: context.textSecondary)),
      const SizedBox(height: 2),
      Row(mainAxisSize: MainAxisSize.min, children: [
        if (prefix != null) Text(prefix, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, height: 1, color: prefixColor ?? context.textPrimary)),
        Text(value, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24, height: 1, color: context.textPrimary)),
      ]),
    ]);
  }

  Widget _buildTabBar(BuildContext context, AppLocalizations l, int scheduledCount, int historyCount) {
    final tabs = [
      (label: l.scheduled, count: scheduledCount),
      (label: l.history,   count: historyCount),
    ];
    return Row(
      children: List.generate(tabs.length, (i) {
        final active = _selectedTab == i;
        return Expanded(
          child: GestureDetector(
          onTap: () => setState(() => _selectedTab = i),
          child: Container(
              margin: EdgeInsets.only(left: i > 0 ? 12 : 0),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              decoration: BoxDecoration(
                color: active
                    ? AppColors.orangeprimary
                    : context.isDark
                        ? Colors.white.withValues(alpha: 0.1)
                        : context.borderColor,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: active
                      ? Colors.transparent
                      : Colors.white.withValues(alpha: context.isDark ? 0.4 : 0.6),
                  width: 1.5,
                ),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  tabs[i].label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                    color: active ? Colors.white : context.textHint,
                  ),
                ),
                const SizedBox(width: 5),
                Container(
                  width: 17, height: 17,
                  decoration: BoxDecoration(
                    color: active || context.isDark
                        ? Colors.white.withValues(alpha: 0.3)
                        : Colors.black.withValues(alpha: 0.35),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text('${tabs[i].count}',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ]),
            ),
          ),
        );
        }),
    );
  }
}

// ── Scheduled Card ────────────────────────────────────────────────────────────

String _fmtTime(String raw) {
  try {
    final dt = DateTime.parse(raw);
    final h  = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final m  = dt.minute.toString().padLeft(2, '0');
    final p  = dt.hour >= 12 ? 'PM' : 'AM';
    const days   = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
    const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    final dayName = days[dt.weekday - 1];
    final month   = months[dt.month - 1];
    return '$h:$m $p  •  $dayName, $month ${dt.day}, ${dt.year}';
  } catch (_) { return raw; }
}

class _ScheduledCard extends StatefulWidget {
  final MyTripModel trip;
  const _ScheduledCard({required this.trip});

  @override
  State<_ScheduledCard> createState() => _ScheduledCardState();
}

class _ScheduledCardState extends State<_ScheduledCard> {
  bool _cancelling  = false;
  bool _publishing  = false;
  bool _completing  = false;

  String _fmtDuration(int minutes) {
    if (minutes < 60) return '$minutes min';
    if (minutes == 60) return '1 hour';
    if (minutes % 60 == 0) return '${minutes ~/ 60} hours';
    return '${minutes ~/ 60}h ${minutes % 60}m';
  }

  Future<void> _onCancel() async {
    setState(() => _cancelling = true);
    final success = await context.read<TripProvider>().cancelTrip(widget.trip.tripId);
    if (!mounted) return;
    setState(() => _cancelling = false);
    if (success) {
      context.read<TripProvider>().fetchDriverScheduled();
      context.read<TripProvider>().fetchDriverHistory();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.read<TripProvider>().errorMessage), backgroundColor: AppColors.errorRed),
      );
    }
  }

  Future<void> _onPublish() async {
    setState(() => _publishing = true);
    final success = await context.read<TripProvider>().publishTrip(widget.trip.tripId);
    if (!mounted) return;
    setState(() => _publishing = false);
    if (success) {
      context.read<TripProvider>().fetchDriverScheduled();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.read<TripProvider>().errorMessage), backgroundColor: AppColors.errorRed),
      );
    }
  }

  Future<void> _onComplete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        title: const Text('Complete Trip'),
        content: const Text('Are you sure you want to mark this trip as completed?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Complete', style: TextStyle(color: Color(0xFF00A63E))),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() => _completing = true);
    final success = await context.read<TripProvider>().completeTrip(widget.trip.tripId);
    if (!mounted) return;
    setState(() => _completing = false);
    if (success) {
      context.read<TripProvider>().fetchDriverScheduled();
      context.read<TripProvider>().fetchDriverHistory();
      context.read<ProfileProvider>().fetchDriverProfile();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.read<TripProvider>().errorMessage), backgroundColor: AppColors.errorRed),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final trip = widget.trip;
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: context.bgCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: context.borderColor),
        boxShadow: [
          BoxShadow(color: AppColors.orangeprimary.withValues(alpha: 0.08), blurRadius: 15, offset: const Offset(0, 10)),
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              // ── Route ──────────────────────────────────────────────
              Row(children: [
                const Icon(Icons.circle, size: 10, color: AppColors.orangeprimary),
                const SizedBox(width: 12),
                Expanded(child: Text(trip.pickupLocation, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: context.textPrimary))),
              ]),
              Padding(
                padding: const EdgeInsets.only(left: 1),
                child: Row(
                  children: [
                    _DashedLine(color: context.borderColor, height: 36),
                    if (trip.estimatedDurationMinutes > 0) ...[
                      const SizedBox(width: 8),
                      Text(
                        _fmtDuration(trip.estimatedDurationMinutes),
                        style: TextStyle(fontSize: 12, color: context.textHint, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ],
                ),
              ),
              Row(children: [
                Icon(Icons.circle, size: 10, color: context.textHint),
                const SizedBox(width: 12),
                Expanded(child: Text(trip.dropoffLocation, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: context.textPrimary))),
              ]),

              const SizedBox(height: 14),
              Divider(height: 1, color: context.borderColor),
              const SizedBox(height: 12),

              // ── Time + Price ────────────────────────────────────────
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  Icon(Icons.access_time_rounded, size: 15, color: context.textSecondary),
                  const SizedBox(width: 6),
                  Text(_fmtTime(trip.departureTime), style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: context.textSecondary)),
                ]),
                Row(children: [
                  const Text('₪', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.orangeprimary)),
                  const SizedBox(width: 2),
                  Text('${trip.pricePerSeat}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.orangeprimary)),
                  Text(' /seat', style: TextStyle(fontSize: 11, color: context.textHint)),
                ]),
              ]),
            ]),
          ),

          // ── Actions ──────────────────────────────────────────────
          Container(
            decoration: BoxDecoration(
              color: context.bgCard,
              border: Border(top: BorderSide(color: context.borderColor)),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _cancelling ? null : _onCancel,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: context.bgCard,
                    foregroundColor: AppColors.errorRed,
                    side: BorderSide(color: AppColors.errorRed.withValues(alpha: 0.4)),
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: _cancelling
                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.errorRed))
                      : Text(AppLocalizations.of(context)!.cancel, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _publishing ? null : _onPublish,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.orangeprimary,
                    foregroundColor: Colors.white,
                    side: BorderSide.none,
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: _publishing
                      ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                      : const Icon(Icons.send_rounded, size: 14, color: Colors.white),
                  label: Text(AppLocalizations.of(context)!.publish, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.white)),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _completing ? null : _onComplete,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: context.isDark
                        ? const Color(0xFF00A63E).withValues(alpha: 0.15)
                        : const Color(0xFFEFFBF3),
                    foregroundColor: const Color(0xFF00A63E),
                    side: BorderSide(
                      color: context.isDark
                          ? const Color(0xFF00A63E).withValues(alpha: 0.5)
                          : const Color(0xFF00A63E),
                      width: 1.2,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 11),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: _completing
                      ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF00A63E)))
                      : const Icon(Icons.check_circle_outline, size: 14, color: Color(0xFF00A63E)),
                  label: const Text('Complete', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12, color: Color(0xFF00A63E))),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

// ── Dashed Line ───────────────────────────────────────────────────────────────

class _DashedLine extends StatelessWidget {
  final Color  color;
  final double height;
  const _DashedLine({required this.color, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.5,
      height: height,
      child: CustomPaint(painter: _DashedPainter(color: color)),
    );
  }
}

class _DashedPainter extends CustomPainter {
  final Color color;
  const _DashedPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color ..strokeWidth = 1.5;
    const dashH = 4.0;
    const gapH  = 3.0;
    double y = 0;
    while (y < size.height) {
      canvas.drawLine(Offset(0, y), Offset(0, y + dashH), paint);
      y += dashH + gapH;
    }
  }

  @override
  bool shouldRepaint(_DashedPainter old) => old.color != color;
}

// ── History Card ──────────────────────────────────────────────────────────────

class _HistoryCard extends StatelessWidget {
  final MyTripModel trip;
  const _HistoryCard({required this.trip});

  @override
  Widget build(BuildContext context) {
    final isCompleted = trip.status == 'Completed';
    final statusColor = isCompleted ? const Color(0xFF00A63E) : const Color(0xFFE7000B);
    final statusBg    = isCompleted
        ? (context.isDark ? const Color(0xFF00A63E).withValues(alpha: 0.15) : const Color(0xFFEFFBF3))
        : (context.isDark ? const Color(0xFFE7000B).withValues(alpha: 0.15) : const Color(0xFFFFF2F2));
    final statusIcon  = isCompleted ? Icons.check_circle_outline : Icons.cancel_outlined;
    final statusLabel = isCompleted ? 'Completed' : 'Cancelled';

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.bgCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: context.borderColor),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 3))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        // ── Status Badge + Chevron ────────────────────────────────
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(12)),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Icon(statusIcon, size: 12, color: statusColor),
              const SizedBox(width: 4),
              Text(statusLabel, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: statusColor)),
            ]),
          ),
          Icon(Icons.chevron_right, size: 18, color: context.textSecondary),
        ]),
        const SizedBox(height: 14),

        // ── Route ────────────────────────────────────────────────
        Row(children: [
          const Icon(Icons.circle, size: 9, color: AppColors.orangeprimary),
          const SizedBox(width: 10),
          Expanded(child: Text(trip.pickupLocation, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: context.textPrimary))),
        ]),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Container(width: 1.5, height: 16, color: context.borderColor, margin: const EdgeInsets.symmetric(vertical: 3)),
        ),
        Row(children: [
          Icon(Icons.circle, size: 9, color: context.textHint),
          const SizedBox(width: 10),
          Expanded(child: Text(trip.dropoffLocation, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: context.textPrimary))),
        ]),

        const SizedBox(height: 14),
        Divider(height: 1, color: context.borderColor),
        const SizedBox(height: 12),

        // ── Time + Price ──────────────────────────────────────────
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            Icon(Icons.access_time_rounded, size: 15, color: context.textSecondary),
            const SizedBox(width: 6),
            Text(_fmtTime(trip.departureTime), style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: context.textSecondary)),
          ]),
          Row(children: [
            const Text('₪', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.orangeprimary)),
            const SizedBox(width: 2),
            Text('${trip.pricePerSeat}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.orangeprimary)),
            Text(' /seat', style: TextStyle(fontSize: 11, color: context.textHint)),
          ]),
        ]),
      ]),
    );
  }
}
