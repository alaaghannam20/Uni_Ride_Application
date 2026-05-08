import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class OfferCarpoolScreen extends StatefulWidget {
  const OfferCarpoolScreen({super.key});

  @override
  State<OfferCarpoolScreen> createState() => _OfferCarpoolScreenState();
}

class _OfferCarpoolScreenState extends State<OfferCarpoolScreen> {
  String? _carType;
  String? _carSeats;
  final _pickupCtrl  = TextEditingController();
  final _dropoffCtrl = TextEditingController();
  String _date = '';
  String _time = '';
  int _availableSeats = 1;
  int _pricePerSeat = 8;
  final _notesController = TextEditingController();
  final List<Map<String, dynamic>> _stops = [];

  // Inline stop adder state
  String? _newStopName;
  String? _newStopTime;
  final _customStopController = TextEditingController();

  @override
  void dispose() {
    _pickupCtrl.dispose();
    _dropoffCtrl.dispose();
    _notesController.dispose();
    _customStopController.dispose();
    super.dispose();
  }

  int get _estimatedEarnings => _availableSeats * _pricePerSeat;

  void _continueToPreview() {
    Navigator.pushNamed(
      context,
      Routes.previewCarpool,
      arguments: {
        'pickupLocation': _pickupCtrl.text.trim().isEmpty ? 'City Center' : _pickupCtrl.text.trim(),
        'dropoffLocation': _dropoffCtrl.text.trim().isEmpty ? 'PTUK University' : _dropoffCtrl.text.trim(),
        'date': _date.isEmpty ? 'Saturday, Dec 11' : _date,
        'time': _time.isEmpty ? '4:40 AM' : _time,
        'availableSeats': _availableSeats,
        'pricePerSeat': _pricePerSeat,
        'stops': _stops,
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
                    // ── Car Details (Image 1 Specs) ──
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionTitle(l.car_details),
                        const SizedBox(height: 12),
                        _buildPickerField(
                          label: l.car_type,
                          isSubHeader: true,
                          value: _carType ?? 'Sedan',
                          leadingIcon: Icons.directions_car,
                          onTap: () => _showOptions(context, l.car_type, ['Sedan', 'SUV', 'Bus', 'Van']),
                        ),
                        const SizedBox(height: 12), // Gap 12
                        _buildPickerField(
                          label: l.number_of_car_seats,
                          isSubHeader: true,
                          value: _carSeats ?? '4 Seats',
                          leadingIcon: Icons.event_seat,
                          onTap: () => _showOptions(context, l.number_of_car_seats, ['2', '4', '5', '7']),
                        ),
                      ],
                    ),

                    const SizedBox(height: 15.99),

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
                                flex: 3, // More space for Date
                                child: _buildPickerField(
                                  label: l.date,
                                  isSubHeader: true,
                                  value: _date.isEmpty ? 'Sat, Dec 11, 2024' : _date,
                                  leadingIcon: Icons.calendar_today_outlined,
                                  onTap: _pickDate,
                                  fontSize: 12, // Slightly smaller font to help it fit
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 2, // Less space for Time
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

                    // ── Price per Seat (Image 5 Specs) ──
                    _buildPriceSection(l),

                    const SizedBox(height: 24),

                    // ── Notes (Image 1 Specs) ──
                    _sectionTitle(l.additional_notes_optional),
                    const SizedBox(height: 12),
                    Container(
                      height: 177.8, // Specified height
                      child: _buildNotesField(l),
                    ),

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
        if (label != null) ...[
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
                      color: context.textSecondary,
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
                    color: Colors.black.withOpacity(0.08),
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

  Widget _buildNotesField(AppLocalizations l) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.bgWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 4), // Added padding for baseline alignment
                child: Icon(Icons.chat_bubble_outline, size: 20, color: context.textSecondary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _notesController,
                  maxLines: 4,
                  maxLength: 200,
                  style: TextStyle(fontSize: 15, color: context.textPrimary),
                  decoration: InputDecoration(
                    hintText: l.notes_hint,
                    hintStyle: TextStyle(color: context.textHint, fontSize: 14),
                    border: InputBorder.none,
                    counterText: '',
                    isDense: true, // Makes content more compact to match icon alignment
                    contentPadding: const EdgeInsets.symmetric(vertical: 4), // Aligns first line with icon
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ],
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              '${_notesController.text.length}/200',
              style: TextStyle(fontSize: 12, color: context.textHint),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStopsSection(AppLocalizations l) {
    const predefined = ['PTUK Main Gate', 'Engineering Building', 'Student Housing'];
    final dropdownVal = predefined.contains(_newStopName) ? _newStopName : (_newStopName == null ? null : 'Other');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _sectionTitle(l.pickup_points),
            if (_stops.isNotEmpty)
              TextButton.icon(
                onPressed: () => setState(() {
                  _newStopName = null;
                  _newStopTime = null;
                  _customStopController.clear();
                }),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add Point'),
                style: TextButton.styleFrom(foregroundColor: AppColors.orangeprimary),
              ),
          ],
        ),
        const SizedBox(height: 12),

        // ── Dropdown ──
        DropdownButtonFormField<String>(
          key: ValueKey(dropdownVal),
          dropdownColor: context.bgCard,
          initialValue: dropdownVal,
          hint: Text('Select pickup point', style: TextStyle(color: context.textHint, fontSize: 14)),
          style: TextStyle(color: context.textSecondary, fontSize: 14),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: context.borderColor)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: context.borderColor)),
          ),
          items: [...predefined, 'Other']
              .map((s) => DropdownMenuItem(value: s, child: Text(s)))
              .toList(),
          onChanged: (val) => setState(() {
            _newStopName = val == 'Other' ? '' : val;
            _newStopTime = null;
            _customStopController.clear();
          }),
        ),

        // ── Custom input (Other) ──
        if (_newStopName != null && !predefined.contains(_newStopName)) ...[
          const SizedBox(height: 12),
          TextField(
            controller: _customStopController,
            style: TextStyle(color: context.textPrimary, fontSize: 14),
            decoration: InputDecoration(
              hintText: 'Enter stop name',
              hintStyle: TextStyle(color: context.textHint, fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: context.borderColor)),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: context.borderColor)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.orangeprimary)),
            ),
            onChanged: (val) => setState(() => _newStopName = val),
          ),
        ],

        // ── Time picker + Add button ──
        if (_newStopName != null && _newStopName!.isNotEmpty) ...[
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () async {
                    final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                    if (time != null && mounted) setState(() => _newStopTime = time.format(context));
                  },
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: context.bgCard,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: _newStopTime != null ? AppColors.orangeprimary : context.borderColor),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.access_time, size: 18, color: _newStopTime != null ? AppColors.orangeprimary : context.textHint),
                        const SizedBox(width: 10),
                        Text(
                          _newStopTime ?? 'Arrival time',
                          style: TextStyle(fontSize: 14, color: _newStopTime != null ? context.textPrimary : context.textHint),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: _newStopTime == null ? null : () {
                  setState(() {
                    _stops.add({
                      'stopName': _newStopName!,
                      'estimatedArrivalTime': _newStopTime!,
                      'stopOrder': _stops.length + 1,
                    });
                    _newStopName = null;
                    _newStopTime = null;
                    _customStopController.clear();
                  });
                },
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: _newStopTime != null ? AppColors.orangeprimary : context.bgSubtle,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: _newStopTime != null ? Colors.white : context.textHint,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],

        // ── Added stops list ──
        if (_stops.isNotEmpty) ...[
          const SizedBox(height: 12),
          ..._stops.asMap().entries.map((entry) {
            final idx = entry.key;
            final stop = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: context.bgCard,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: context.borderColor),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 24, height: 24,
                      decoration: const BoxDecoration(color: Color(0xFFFEF3DF), shape: BoxShape.circle),
                      alignment: Alignment.center,
                      child: Text('${idx + 1}', style: const TextStyle(color: Color(0xFFCF8307), fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(stop['stopName'], style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: context.textPrimary)),
                          Text(stop['estimatedArrivalTime'], style: TextStyle(fontSize: 12, color: context.textSecondary)),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _stops.removeAt(idx)),
                      child: const Icon(Icons.remove_circle_outline, color: AppColors.errorRed, size: 20),
                    ),
                  ],
                ),
              ),
            );
          }),
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

  void _showOptions(BuildContext ctx, String title, List<String> options) {
    showModalBottomSheet(
      context: ctx,
      backgroundColor: context.bgCard,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: context.textPrimary))),
            const SizedBox(height: 16),
            ...options.map((o) => ListTile(
                  title: Text(o, style: TextStyle(color: context.textPrimary)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  onTap: () {
                    setState(() {
                      if (title == AppLocalizations.of(context)!.car_type) _carType = o;
                      if (title == AppLocalizations.of(context)!.number_of_car_seats) _carSeats = o;
                    });
                    Navigator.pop(ctx);
                  },
                )),
          ],
        ),
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
    final DateTime now = DateTime.now();
    DateTime tempDate = now;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return Container(
          height: 350,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: context.bgCard,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(AppLocalizations.of(context)!.cancel, style: TextStyle(color: context.textSecondary)),
                  ),
                  Text(AppLocalizations.of(context)!.selectDate, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: context.textPrimary)),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                        final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                        final dayName = weekdays[tempDate.weekday - 1];
                        _date = "$dayName, ${months[tempDate.month - 1]} ${tempDate.day}, ${tempDate.year}";
                      });
                      Navigator.pop(context);
                    },
                    child: Text(AppLocalizations.of(context)!.done, style: const TextStyle(color: AppColors.orangeprimary, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const Divider(height: 32),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: now,
                  minimumDate: now,
                  maximumDate: DateTime(2030), // Fix: increased to avoid crash if system date is in 2026
                  onDateTimeChanged: (date) => tempDate = date,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickTime() async {
    final DateTime now = DateTime.now();
    DateTime tempTime = now;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return Container(
          height: 350,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: context.bgCard,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(AppLocalizations.of(context)!.cancel, style: TextStyle(color: context.textSecondary)),
                  ),
                  Text(AppLocalizations.of(context)!.selectTime, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: context.textPrimary)),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        final hour = tempTime.hour > 12 ? tempTime.hour - 12 : (tempTime.hour == 0 ? 12 : tempTime.hour);
                        final amPm = tempTime.hour >= 12 ? 'PM' : 'AM';
                        final minute = tempTime.minute.toString().padLeft(2, '0');
                        _time = "$hour:$minute $amPm";
                      });
                      Navigator.pop(context);
                    },
                    child: Text(AppLocalizations.of(context)!.done, style: const TextStyle(color: AppColors.orangeprimary, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const Divider(height: 32),
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: now,
                  onDateTimeChanged: (date) => tempTime = date,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
