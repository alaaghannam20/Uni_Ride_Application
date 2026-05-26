import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/trip_provider.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/features/home_page/data/models/location_model.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class OfferCarpoolScreen extends StatefulWidget {
  const OfferCarpoolScreen({super.key});

  @override
  State<OfferCarpoolScreen> createState() => _OfferCarpoolScreenState();
}

class _OfferCarpoolScreenState extends State<OfferCarpoolScreen> {
  final _pickupCtrl  = TextEditingController();
  final _dropoffCtrl = TextEditingController();
  String _date = '';
  String _time = '';
  int _availableSeats = 1;
  int _pricePerSeat = 8;
  int _duration = 15;
  bool _customDuration = false;
  final _durationHrsCtrl = TextEditingController();
  final _durationMinCtrl = TextEditingController();

  static const _durationOptions = [15, 30, 45, 60, 90, 120];

  // Stop state
  LocationModel? _selectedStop;
  final _customStopCtrl = TextEditingController();
  static final _otherLocation = LocationModel(id: -1, name: 'Other');

  @override
  void initState() {
    super.initState();
  }

  String _durationLabel(int v) {
    if (v < 60) return '$v min';
    if (v == 60) return '1 hour';
    if (v % 60 == 0) return '${v ~/ 60} hours';
    return '${v ~/ 60}h ${v % 60}m';
  }

  @override
  void dispose() {
    _pickupCtrl.dispose();
    _dropoffCtrl.dispose();
    _durationHrsCtrl.dispose();
    _durationMinCtrl.dispose();
    _customStopCtrl.dispose();
    super.dispose();
  }

  int get _estimatedEarnings => _availableSeats * _pricePerSeat;

  String _formatDisplayDate(String iso) {
    try {
      final dt = DateTime.parse(iso);
      const days   = ['Mon','Tue','Wed','Thu','Fri','Sat','Sun'];
      const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
      return '${days[dt.weekday-1]}, ${months[dt.month-1]} ${dt.day}, ${dt.year}';
    } catch (_) { return iso; }
  }

  // Build ISO datetime string from a date string and time string
  String _buildDateTime(String dateStr, String timeStr) {
    try {
      final timeParts = timeStr.trim().split(RegExp(r'[\s:]'));
      int hour   = int.tryParse(timeParts[0]) ?? 0;
      int minute = int.tryParse(timeParts[1]) ?? 0;
      final isPM = timeStr.toUpperCase().contains('PM');
      if (isPM && hour != 12) hour += 12;
      if (!isPM && hour == 12) hour = 0;
      DateTime? dt;
      try { dt = DateTime.parse(dateStr); } catch (_) {}
      dt ??= DateTime.now();
      return '${dt.year}-${dt.month.toString().padLeft(2,'0')}-${dt.day.toString().padLeft(2,'0')}'
             'T${hour.toString().padLeft(2,'0')}:${minute.toString().padLeft(2,'0')}:00';
    } catch (_) {
      return '${DateTime.now().toIso8601String().substring(0, 10)}T00:00:00';
    }
  }

  void _continueToPreview() {
    final date = _date.isEmpty ? 'Saturday, Dec 11' : _date;
    final time = _time.isEmpty ? '4:40 AM' : _time;

    final List<Map<String, dynamic>> stops = (_selectedStop != null && _selectedStop!.id > 0)
        ? [{
            'locationId':           _selectedStop!.id,
            'estimatedArrivalTime': _buildDateTime(date, time),
            'stopOrder':            1,
          }]
        : [];

    Navigator.pushNamed(
      context,
      Routes.previewCarpool,
      arguments: {
        'pickupLocation':  _pickupCtrl.text.trim().isEmpty ? 'City Center' : _pickupCtrl.text.trim(),
        'dropoffLocation': _dropoffCtrl.text.trim().isEmpty ? 'PTUK University' : _dropoffCtrl.text.trim(),
        'date':            date,
        'time':            time,
        'availableSeats':  _availableSeats,
        'pricePerSeat':    _pricePerSeat,
        'duration':        _customDuration ? ((int.tryParse(_durationHrsCtrl.text) ?? 0) * 60 + (int.tryParse(_durationMinCtrl.text) ?? 0)).clamp(1, 9999) : _duration,
        'stops':           stops,
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
            // ── Top bar ──
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: context.bgSubtle,
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
                        l.offer_a_carpool,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: context.textPrimary),
                      ),
                      Text(
                        l.offer_carpool_sub,
                        style: TextStyle(fontSize: 14, color: context.textSecondary),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Form ──
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Route ──
                    _sectionTitle("Route"),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: context.bgCard,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: context.borderColor),
                      ),
                      child: Column(
                        children: [
                          _locationField(
                            controller: _pickupCtrl,
                            hint: 'Pickup Location',
                            icon: Icons.circle,
                            iconColor: AppColors.orangeprimary,
                          ),
                          Divider(height: 1, indent: 52, color: context.borderColor),
                          _locationField(
                            controller: _dropoffCtrl,
                            hint: 'Dropoff Location',
                            icon: Icons.location_on,
                            iconColor: context.textSecondary,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15.99),

                    // ── Pickup Points (Stops) ──
                    _buildStopsSection(l),

                    const SizedBox(height: 15.99),

                    // ── Timing (Image 3 Specs) ──
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle(l.when_leaving),
                        const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: _buildPickerField(
                                  label: l.date,
                                  isSubHeader: true,
                                  value: _date.isEmpty ? 'Sat, Dec 11, 2024' : _formatDisplayDate(_date),
                                  leadingIcon: Icons.calendar_today_outlined,
                                  onTap: _pickDate,
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 4,
                                child: _buildPickerField(
                                  label: l.time,
                                  isSubHeader: true,
                                  value: _time.isEmpty ? '4:40 AM' : _time,
                                  leadingIcon: Icons.access_time,
                                  onTap: _pickTime,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                    const SizedBox(height: 15.99),

                    // ── Available Seats (Image 4 Specs) ──

                    // ── Available Seats (Image 4 Specs) ──
                    _buildCounterSection(
                      title: l.available_seats_label,
                      subtitle: l.how_many_passengers,
                      value: _availableSeats,
                      onChanged: (val) => setState(() => _availableSeats = val),
                    ),

                    const SizedBox(height: 15.99),

                    // ── Trip Duration ──
                    _buildDurationSection(l),

                    const SizedBox(height: 15.99),

                    // ── Price per Seat (Image 5 Specs) ──
                    _buildPriceSection(l),

                    const SizedBox(height: 24),

                    // ── Earnings summary (Image 2 Specs) ──
                    _buildEarningsCard(l),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // ── Action Button Area (Image 3 Specs) ──
            Container(
              width: double.infinity,
              height: 88,
              padding: const EdgeInsets.fromLTRB(23.99, 16.61, 23.99, 0),
              decoration: BoxDecoration(
                color: context.bgWhite,
                border: Border(
                  top: BorderSide(color: context.borderColor, width: 0.62),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 55.99,
                    decoration: BoxDecoration(
                      color: AppColors.orangeprimary, // Specified Color
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [
                        // Specified shadows (Image 2)
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
                    child: ElevatedButton(
                      onPressed: _continueToPreview,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        elevation: 0,
                      ),
                      child: Text(
                        l.continue_to_preview,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

  Widget _sectionTitle(String title, {bool isSub = false}) {
    return Text(
      title,
      style: TextStyle(
        fontSize: isSub ? 14 : 16,
        fontWeight: isSub ? FontWeight.normal : FontWeight.bold,
        color: isSub ? context.textSecondary : context.textPrimary,
      ),
    );
  }

  Widget _buildPickerField({
    required String label,
    required String? value,
    required VoidCallback onTap,
    IconData? leadingIcon,
    Color? iconColor,
    double? fontSize,
    bool isSubHeader = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...[
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSubHeader ? FontWeight.normal : FontWeight.bold,
              color: isSubHeader ? context.textSecondary : context.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
        ],
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: 56, // Reverted to original height
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: context.bgCard,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: context.borderColor, width: 0.62),
            ),
            child: Row(
              children: [
                if (leadingIcon != null) ...[
                  Icon(leadingIcon, color: iconColor ?? AppColors.orangeprimary, size: 20),
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Text(
                    value ?? '',
                    maxLines: 1, // Reverted to single line
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: context.textPrimary,
                      fontSize: fontSize ?? 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(Icons.chevron_right, color: context.textHint, size: 18),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCounterSection({
    required String title,
    required String subtitle,
    required int value,
    required ValueChanged<int> onChanged,
  }) {
    return Container(
      width: double.infinity,
      height: 115.97,
      padding: const EdgeInsets.symmetric(horizontal: 19.99),
      decoration: BoxDecoration(
        color: context.bgSubtle,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: context.textPrimary),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: context.textSecondary),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _stepButton(
                icon: Icons.remove,
                onTap: value > 1 ? () => onChanged(value - 1) : null,
                color: context.isDark ? const Color(0xFF1E293B) : Colors.white,
                iconColor: AppColors.orangeprimary,
                hasShadow: !context.isDark,
              ),
              const SizedBox(width: 12),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: context.isDark ? const Color(0xFF1E293B) : context.bgWhite,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.borderColor),
                ),
                child: Center(
                  child: Text(
                    '$value',
                    style: const TextStyle(color: AppColors.orangeprimary, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              _stepButton(
                icon: Icons.add,
                onTap: () => onChanged(value + 1),
                color: context.isDark ? const Color(0xFF1E293B) : Colors.white,
                iconColor: AppColors.orangeprimary,
                hasShadow: !context.isDark,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDurationSection(AppLocalizations l) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l.tripDuration, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: context.textPrimary)),
          const SizedBox(height: 2),
          Text(l.estimatedTripTime, style: TextStyle(fontSize: 12, color: context.textSecondary)),
          const SizedBox(height: 10),
          Row(children: [
            Expanded(
              child: DropdownButtonFormField<int>(
                initialValue: _customDuration ? null : _duration,
                dropdownColor: context.bgCard,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: context.textPrimary),
                decoration: InputDecoration(
                  filled: true, fillColor: context.bgSubtle,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: context.borderColor)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: context.borderColor)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.orangeprimary, width: 1.5)),
                ),
                hint: Text(l.selectTime, style: TextStyle(color: context.textHint)),
                items: [
                  ..._durationOptions.map((v) => DropdownMenuItem(value: v, child: Text(_durationLabel(v)))),
                  DropdownMenuItem(value: -1, child: Text(l.custom, style: const TextStyle(color: AppColors.orangeprimary, fontWeight: FontWeight.w600))),
                ],
                onChanged: (v) {
                  if (v == -1) { setState(() => _customDuration = true); }
                  else if (v != null) { setState(() { _customDuration = false; _duration = v; }); }
                },
              ),
            ),
            if (_customDuration) ...[
              const SizedBox(width: 10),
              SizedBox(
                width: 72,
                child: TextFormField(
                  controller: _durationHrsCtrl,
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  style: TextStyle(fontSize: 14, color: context.textPrimary, fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    hintText: '0', suffixText: 'h',
                    suffixStyle: TextStyle(fontSize: 12, color: context.textSecondary),
                    filled: true, fillColor: context.bgSubtle,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.orangeprimary, width: 1.5)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.orangeprimary, width: 1.5)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.orangeprimary, width: 1.5)),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 72,
                child: TextFormField(
                  controller: _durationMinCtrl,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 14, color: context.textPrimary, fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    hintText: '0', suffixText: 'min',
                    suffixStyle: TextStyle(fontSize: 12, color: context.textSecondary),
                    filled: true, fillColor: context.bgSubtle,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.orangeprimary, width: 1.5)),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.orangeprimary, width: 1.5)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.orangeprimary, width: 1.5)),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ],
          ]),
        ],
      ),
    );
  }

  Widget _buildPriceSection(AppLocalizations l) {
    return Container(
      width: double.infinity,
      height: 145.96,
      padding: const EdgeInsets.all(19.99),
      decoration: BoxDecoration(
        color: context.bgSubtle,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.price_per_seat_label,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: context.textPrimary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l.set_price,
                      style: TextStyle(fontSize: 12, color: context.textSecondary),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  _stepButton(
                    icon: Icons.remove,
                    onTap: _pricePerSeat > 1 ? () => setState(() => _pricePerSeat--) : null,
                    color: context.isDark ? const Color(0xFF1E293B) : Colors.white,
                    iconColor: AppColors.orangeprimary,
                    hasShadow: !context.isDark,
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 52,
                    height: 44,
                    decoration: BoxDecoration(
                      color: context.isDark ? const Color(0xFF1E293B) : context.bgWhite,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: context.borderColor),
                      boxShadow: context.isDark ? [] : [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '₪$_pricePerSeat',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.orangeprimary),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  _stepButton(
                    icon: Icons.add,
                    onTap: () => setState(() => _pricePerSeat++),
                    color: context.isDark ? const Color(0xFF1E293B) : Colors.white,
                    iconColor: AppColors.orangeprimary,
                    hasShadow: !context.isDark,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: context.isDark ? const Color(0xFF1E293B) : AppColors.adminInfoBG,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: context.isDark ? const Color(0xFF334155) : AppColors.lightBlueBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.attach_money, size: 14, color: context.isDark ? const Color(0xFF94A3B8) : AppColors.infoDarkBlue),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l.suggested_price_range,
                    style: TextStyle(
                      fontSize: 13,
                      color: context.isDark ? const Color(0xFFCBD5E1) : AppColors.infoDarkBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _stepButton({
    required IconData icon,
    required VoidCallback? onTap,
    required Color color,
    Color? iconColor,
    bool hasShadow = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: hasShadow
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Icon(icon, size: 18, color: iconColor ?? AppColors.grey667),
      ),
    );
  }

  Widget _buildStopsSection(AppLocalizations l) {
    final locations = context.watch<TripProvider>().locations;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(l.pickup_points),
        const SizedBox(height: 12),

        // ── Location Dropdown ──
        DropdownButtonFormField<LocationModel>(
          dropdownColor: context.bgCard,
          initialValue: _selectedStop,
          hint: Text(l.selectPickupPoint, style: TextStyle(color: context.textHint, fontSize: 14)),
          style: TextStyle(color: context.textPrimary, fontSize: 14),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border:        OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: context.borderColor)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: context.borderColor)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.orangeprimary)),
          ),
          items: [
            ...locations.map((loc) => DropdownMenuItem(value: loc, child: Text(loc.name))),
            DropdownMenuItem(value: _otherLocation, child: Text(l.other)),
          ],
          onChanged: (val) => setState(() {
            _selectedStop = val;
            _customStopCtrl.clear();
          }),
        ),

        if (_selectedStop?.id == -1) ...[
          const SizedBox(height: 12),
          TextField(
            controller: _customStopCtrl,
            autofocus: true,
            style: TextStyle(fontSize: 14, color: context.textPrimary),
            decoration: InputDecoration(
              hintText: l.pickupLocation,
              hintStyle: TextStyle(color: context.textHint, fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border:        OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: context.borderColor)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: context.borderColor)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.orangeprimary)),
            ),
            onChanged: (_) => setState(() {}),
          ),
        ],

      ],
    );
  }


  Widget _buildEarningsCard(AppLocalizations l) {
    return Container(
      width: double.infinity,
      height: 123.9,
      padding: const EdgeInsets.symmetric(horizontal: 16), // Reduced vertical padding to prevent overflow
      decoration: BoxDecoration(
        color: context.isDark ? const Color(0xFF064E3B).withValues(alpha: 0.3) : AppColors.successBGStart,
        gradient: context.isDark ? null : const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.successBGStart, AppColors.successBGEnd],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.isDark ? const Color(0xFF059669) : AppColors.successBorder,
          width: 0.62,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            l.estimated_earnings,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: context.isDark ? const Color(0xFF34D399) : AppColors.darkGreen),
          ),
          const SizedBox(height: 4), // Reduced from 8
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text('₪', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: context.isDark ? const Color(0xFF34D399) : AppColors.darkGreen)),
              const SizedBox(width: 4),
              Text(
                '$_estimatedEarnings',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: context.isDark ? const Color(0xFF34D399) : AppColors.darkGreen),
              ),
            ],
          ),
          const SizedBox(height: 2), // Reduced from 4
          Text(
            '$_availableSeats ${l.localeName == 'ar' ? (_availableSeats > 1 ? 'مقاعد' : 'مقعد') : (_availableSeats > 1 ? 'seats' : 'seat')} × ₪$_pricePerSeat ${l.per_seat}',
            style: TextStyle(fontSize: 12, color: context.isDark ? const Color(0xFF34D399).withValues(alpha: 0.8) : AppColors.darkGreen),
          ),
        ],
      ),
    );
  }


  Widget _locationField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required Color iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 12, color: iconColor),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(fontSize: 14, color: context.textPrimary, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: context.textHint, fontSize: 14),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(2030),
      builder: (ctx, child) => Theme(data: _pickerTheme, child: child!),
    );
    if (picked != null) {
      setState(() {
        // Store as ISO so preview can parse it correctly
        _date = '${picked.year}-${picked.month.toString().padLeft(2,'0')}-${picked.day.toString().padLeft(2,'0')}';
      });
    }
  }


  ThemeData get _pickerTheme => ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light(
      primary:              AppColors.orangeprimary,
      onPrimary:            Colors.white,
      onSurface:            Color(0xFF1A1A2E),
      tertiaryContainer:    AppColors.orangeprimary,
      onTertiaryContainer:  Colors.white,
      secondaryContainer:   AppColors.orangeprimary,
      onSecondaryContainer: Colors.white,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.orangeprimary),
    ),
  );

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (ctx, child) => Theme(data: _pickerTheme, child: child!),
    );
    if (picked != null) {
      setState(() {
        final h      = picked.hourOfPeriod == 0 ? 12 : picked.hourOfPeriod;
        final m      = picked.minute.toString().padLeft(2, '0');
        final period = picked.period == DayPeriod.am ? 'AM' : 'PM';
        _time = '$h:$m $period';
      });
    }
  }
}
