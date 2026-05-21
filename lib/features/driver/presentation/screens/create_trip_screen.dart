import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/trip_provider.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/features/home_page/data/models/location_model.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class CreateTripScreen extends StatefulWidget {
  const CreateTripScreen({super.key});

  @override
  State<CreateTripScreen> createState() => _CreateTripScreenState();
}

class _CreateTripScreenState extends State<CreateTripScreen> {
  final _formKey    = GlobalKey<FormState>();
  final _pickupCtrl = TextEditingController();
  final _dropoffCtrl= TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int  _seats         = 1;
  int  _price         = 8;
  int  _duration      = 15;
  bool _customDuration = false;
  final _durationCtrl  = TextEditingController();
  LocationModel? _selectedStop;
  final _customStopCtrl = TextEditingController();
  static final _otherLocation = LocationModel(id: -1, name: 'Other');

  int get _estimatedEarnings => _seats * _price;

  static const _durationOptions = [15, 30, 45, 60, 90, 120];

  String _durationLabel(int v) {
    if (v < 60) return '$v min';
    if (v == 60) return '1 hour';
    if (v % 60 == 0) return '${v ~/ 60} hours';
    return '${v ~/ 60}h ${v % 60}min';
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pickupCtrl.dispose();
    _dropoffCtrl.dispose();
    _durationCtrl.dispose();
    _customStopCtrl.dispose();
    super.dispose();
  }

  static const _days   = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  static const _months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

  String _formatDate(DateTime d) {
    final day   = _days[d.weekday - 1];
    final month = _months[d.month - 1];
    return '$day, $month ${d.day}, ${d.year}';
  }

  ThemeData get _pickerTheme => ThemeData.light().copyWith(
    colorScheme: const ColorScheme.light(
      primary:            AppColors.orangeprimary,
      onPrimary:          Colors.white,
      onSurface:          Color(0xFF1A1A2E),
      tertiaryContainer:  AppColors.orangeprimary,
      onTertiaryContainer: Colors.white,
      secondaryContainer: AppColors.orangeprimary,
      onSecondaryContainer: Colors.white,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.orangeprimary),
    ),
  );

  Future<void> _pickDate() async {
    final now  = DateTime.now();
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 90)),
      builder: (ctx, child) => Theme(data: _pickerTheme, child: child!),
    );
    if (date != null) setState(() => _selectedDate = date);
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (ctx, child) => Theme(data: _pickerTheme, child: child!),
    );
    if (time != null) setState(() => _selectedTime = time);
  }

  String get _formattedDateTime {
    if (_selectedDate == null) return '';
    final d = _selectedDate!;
    final months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    final dateStr = '${d.day} ${months[d.month - 1]} ${d.year}';
    if (_selectedTime == null) return dateStr;
    final t      = _selectedTime!;
    final hour   = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final minute = t.minute.toString().padLeft(2, '0');
    final period = t.period == DayPeriod.am ? 'AM' : 'PM';
    return '$dateStr  •  $hour:$minute $period';
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.pleaseSelectDateTime), backgroundColor: AppColors.errorRed),
      );
      return;
    }

    final d = _selectedDate!;
    final t = _selectedTime!;
    final departureTime =
        '${d.year}-${d.month.toString().padLeft(2,'0')}-${d.day.toString().padLeft(2,'0')}'
        'T${t.hour.toString().padLeft(2,'0')}:${t.minute.toString().padLeft(2,'0')}:00';

    final duration = _customDuration
        ? (int.tryParse(_durationCtrl.text) ?? _duration)
        : _duration;

    final tripId = await context.read<TripProvider>().createTrip(
      pickupLocation:  _pickupCtrl.text.trim(),
      dropoffLocation: _dropoffCtrl.text.trim(),
      departureTime:   departureTime,
      pricePerSeat:    _price.toDouble(),
      totalSeats:      _seats,
      description:              'estimatedDurationMinutes:$duration',
      estimatedDurationMinutes: duration,
      stops: [],
    );

    if (!mounted) return;
    if (tripId != null) {
      context.read<TripProvider>().fetchDriverScheduled();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.read<TripProvider>().errorMessage), backgroundColor: AppColors.errorRed),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: context.bgWhite,
      appBar: AppBar(
        backgroundColor: context.appBarBg,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: context.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(l.scheduleATrip, style: TextStyle(color: context.textPrimary, fontWeight: FontWeight.w700, fontSize: 18)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: context.borderColor),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── Route Section ─────────────────────────────────────
              _sectionLabel(context, l.route),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: context.bgCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: context.borderColor),
                ),
                child: Column(
                  children: [
                    _LocationField(
                      controller: _pickupCtrl,
                      hint: l.pickupLocation,
                      icon: Icons.circle,
                      iconColor: AppColors.orangeprimary,
                      isFirst: true,
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                    ),
                    Divider(height: 1, indent: 52, color: context.borderColor),
                    _LocationField(
                      controller: _dropoffCtrl,
                      hint: l.dropoffLocation,
                      icon: Icons.location_on,
                      iconColor: context.textSecondary,
                      isFirst: false,
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Pickup Points (Stops) ─────────────────────────────
              _buildStopsSection(context, l),

              const SizedBox(height: 24),

              // ── Date & Time ───────────────────────────────────────
              _sectionLabel(context, l.dateAndTime),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _PickerTile(
                      icon: Icons.calendar_today_outlined,
                      label: _selectedDate == null
                          ? l.selectDate
                          : _formatDate(_selectedDate!),
                      hasValue: _selectedDate != null,
                      onTap: _pickDate,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _PickerTile(
                      icon: Icons.access_time_outlined,
                      label: _selectedTime == null
                          ? l.selectTime
                          : _selectedTime!.format(context),
                      hasValue: _selectedTime != null,
                      onTap: _pickTime,
                    ),
                  ),
                ],
              ),
              if (_selectedDate != null && _selectedTime != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.check_circle, size: 14, color: AppColors.adminSuccessText),
                    const SizedBox(width: 6),
                    Text(_formattedDateTime, style: const TextStyle(fontSize: 12, color: AppColors.adminSuccessText, fontWeight: FontWeight.w500)),
                  ],
                ),
              ],

              const SizedBox(height: 24),

              // ── Trip Details ──────────────────────────────────────
              _sectionLabel(context, l.tripDetails),
              const SizedBox(height: 12),

              // Seats
              _detailCard(context, child: Row(children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(l.availableSeats, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: context.textPrimary)),
                  const SizedBox(height: 2),
                  Text(l.howManyPassengers, style: TextStyle(fontSize: 12, color: context.textSecondary)),
                ])),
                const SizedBox(width: 12),
                _Stepper(value: _seats, min: 1, max: 20, prefix: '', onChanged: (v) => setState(() => _seats = v)),
              ])),

              const SizedBox(height: 12),

              // Duration
              _detailCard(context, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                        DropdownMenuItem(value: -1, child: Text(l.custom, style: TextStyle(color: AppColors.orangeprimary, fontWeight: FontWeight.w600))),
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
                      width: 90,
                      child: TextFormField(
                        controller: _durationCtrl,
                        keyboardType: TextInputType.number,
                        autofocus: true,
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
                        onChanged: (v) { final n = int.tryParse(v); if (n != null && n > 0) setState(() => _duration = n); },
                      ),
                    ),
                  ],
                ]),
              ])),

              const SizedBox(height: 12),

              // Price
              _detailCard(context, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(l.pricePerSeat, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: context.textPrimary)),
                    const SizedBox(height: 2),
                    Text(l.setPriceInILS, style: TextStyle(fontSize: 12, color: context.textSecondary)),
                  ])),
                  const SizedBox(width: 12),
                  _Stepper(value: _price, min: 1, max: 100, prefix: '₪', onChanged: (v) => setState(() => _price = v)),
                ]),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: context.isDark ? const Color(0xFF1E293B) : AppColors.adminInfoBG,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(children: [
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
                  ]),
                ),
              ])),

              const SizedBox(height: 12),

              // ── Estimated Earnings ──
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: context.isDark ? null : const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.successBGStart, AppColors.successBGEnd],
                  ),
                  color: context.isDark ? const Color(0xFF064E3B) : null,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: context.isDark ? const Color(0xFF059669) : AppColors.successBorder,
                    width: 0.62,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.estimated_earnings,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: context.isDark ? const Color(0xFF34D399) : AppColors.darkGreen),
                    ),
                    const SizedBox(height: 4),
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
                    const SizedBox(height: 2),
                    Text(
                      '$_seats ${l.localeName == 'ar' ? (_seats > 1 ? 'مقاعد' : 'مقعد') : (_seats > 1 ? 'seats' : 'seat')} × ₪$_price ${l.per_seat}',
                      style: TextStyle(fontSize: 12, color: context.isDark ? const Color(0xFF34D399) : AppColors.darkGreen),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // ── Submit ────────────────────────────────────────────
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.orangeprimary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(l.scheduleTrip, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStopsSection(BuildContext context, AppLocalizations l) {
    final provider   = context.watch<TripProvider>();
    final locations  = provider.locations;
    final isLoading  = provider.locationsState == TripState.loading;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel(context, l.pickup_points),
        const SizedBox(height: 8),

        // ── Location Dropdown from API ──
        DropdownButtonFormField<LocationModel>(
          dropdownColor: Theme.of(context).cardColor,
          initialValue: _selectedStop,
          hint: Row(children: [
            if (isLoading) ...[
              const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.orangeprimary)),
              const SizedBox(width: 8),
            ],
            Text(
              isLoading ? 'Loading...' : l.selectPickupPoint,
              style: TextStyle(color: context.textHint, fontSize: 14),
            ),
          ]),
          style: TextStyle(color: context.textPrimary, fontSize: 14),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border:        OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: context.borderColor)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: context.borderColor)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.orangeprimary)),
          ),
          items: [
            ...locations.map((loc) => DropdownMenuItem(value: loc, child: Text(loc.name))),
            DropdownMenuItem(value: _otherLocation, child: Text(AppLocalizations.of(context)!.other)),
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
              hintText: AppLocalizations.of(context)!.pickupLocation,
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

  Widget _detailCard(BuildContext context, {required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: context.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.borderColor),
      ),
      child: child,
    );
  }

  Widget _sectionLabel(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.8, color: context.textPrimary),
    );
  }
}

// ── Location Field ────────────────────────────────────────────────────────────

class _LocationField extends StatelessWidget {
  final TextEditingController controller;
  final String      hint;
  final IconData    icon;
  final Color       iconColor;
  final bool        isFirst;
  final String? Function(String?) validator;

  const _LocationField({
    required this.controller,
    required this.hint,
    required this.icon,
    required this.iconColor,
    required this.isFirst,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 12, color: iconColor),
          const SizedBox(width: 12),
          Expanded(
            child: TextFormField(
              controller: controller,
              validator: validator,
              style: TextStyle(fontSize: 14, color: context.textPrimary, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: context.textHint, fontSize: 14),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                errorStyle: const TextStyle(fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Picker Tile ───────────────────────────────────────────────────────────────

class _PickerTile extends StatelessWidget {
  final IconData icon;
  final String   label;
  final bool     hasValue;
  final VoidCallback onTap;

  const _PickerTile({required this.icon, required this.label, required this.hasValue, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: context.bgCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: hasValue ? AppColors.orangeprimary : context.borderColor),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: hasValue ? AppColors.orangeprimary : context.textSecondary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: hasValue ? context.textPrimary : context.textHint,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Stepper ───────────────────────────────────────────────────────────────────

class _Stepper extends StatelessWidget {
  final int    value;
  final int    min;
  final int    max;
  final String prefix;
  final void Function(int) onChanged;

  const _Stepper({required this.value, required this.min, required this.max, required this.prefix, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StepBtn(
          icon: Icons.remove,
          onTap: value > min ? () => onChanged(value - 1) : null,
        ),
        const SizedBox(width: 8),
        Container(
          width: 56, height: 46,
          decoration: BoxDecoration(
            color: AppColors.orangeprimary,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            '$prefix$value',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
          ),
        ),
        const SizedBox(width: 8),
        _StepBtn(
          icon: Icons.add,
          onTap: value < max ? () => onChanged(value + 1) : null,
        ),
      ],
    );
  }
}

class _StepBtn extends StatelessWidget {
  final IconData   icon;
  final VoidCallback? onTap;
  const _StepBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36, height: 36,
        decoration: BoxDecoration(
          color: context.bgSubtle,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: context.borderColor),
        ),
        child: Icon(icon, size: 18, color: enabled ? context.textPrimary : context.textHint),
      ),
    );
  }
}
