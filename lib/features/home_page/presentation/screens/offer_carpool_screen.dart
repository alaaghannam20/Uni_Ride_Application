import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class OfferCarpoolScreen extends StatefulWidget {
  const OfferCarpoolScreen({super.key});

  @override
  State<OfferCarpoolScreen> createState() => _OfferCarpoolScreenState();
}

class _OfferCarpoolScreenState extends State<OfferCarpoolScreen> {
  String? _carType;
  String? _carSeats;
  String _pickupLocation = '';
  String _dropoffLocation = '';
  String _date = '';
  String _time = '';
  int _availableSeats = 1;
  int _pricePerSeat = 8;
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  int get _estimatedEarnings => _availableSeats * _pricePerSeat;

  void _continueToPreview() {
    Navigator.pushNamed(
      context,
      Routes.previewCarpool,
      arguments: {
        'pickupLocation': _pickupLocation.isEmpty ? 'City Center' : _pickupLocation,
        'dropoffLocation': _dropoffLocation.isEmpty ? 'PTUK University' : _dropoffLocation,
        'date': _date.isEmpty ? 'Saturday, Dec 11' : _date,
        'time': _time.isEmpty ? '4:40 AM' : _time,
        'availableSeats': _availableSeats,
        'pricePerSeat': _pricePerSeat,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
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
                        color: AppColors.greyBackground,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.greyF2F),
                      ),
                      child: const Icon(Icons.arrow_back, size: 20, color: AppColors.greyDark),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l.offer_a_carpool,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.greyDark),
                      ),
                      Text(
                        l.offer_carpool_sub,
                        style: const TextStyle(fontSize: 14, color: AppColors.grey667),
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
                    SizedBox(
                      height: 203.4, // Specified height
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionTitle(l.car_details),
                          const SizedBox(height: 12),
                          _buildPickerField(
                            label: l.car_type,
                            value: _carType ?? 'Sedan',
                            onTap: () => _showOptions(context, l.car_type, ['Sedan', 'SUV', 'Bus', 'Van']),
                          ),
                          const SizedBox(height: 12), // Gap 12
                          _buildPickerField(
                            label: l.number_of_car_seats,
                            value: _carSeats ?? '4 Seats',
                            onTap: () => _showOptions(context, l.number_of_car_seats, ['2', '4', '5', '7']),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15.99),

                    // ── Route Details (Image 2 Specs) ──
                    SizedBox(
                      height: 203.4, // Specified height
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionTitle(l.route_details),
                          const SizedBox(height: 12),
                          _buildPickerField(
                            label: l.pickup_loc,
                            value: _pickupLocation.isEmpty ? 'City Center' : _pickupLocation,
                            leadingIcon: Icons.location_on,
                            iconColor: AppColors.adminPrice,
                            onTap: () => _updateLocation(true),
                          ),
                          const SizedBox(height: 12), // Gap 12
                          _buildPickerField(
                            label: l.dropoff_loc,
                            value: _dropoffLocation.isEmpty ? 'PTUK University' : _dropoffLocation,
                            leadingIcon: Icons.location_on,
                            iconColor: AppColors.greyBlueLight,
                            onTap: () => _updateLocation(false),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15.99),

                    // ── Timing (Image 3 Specs) ──
                    Container(
                      height: 113.7, // Specified height
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _sectionTitle(l.when_leaving),
                          const SizedBox(height: 8), // Slightly reduced from 12 to save space
                          Row(
                            children: [
                              Expanded(
                                child: _buildPickerField(
                                  label: l.date,
                                  value: _date.isEmpty ? 'Sat, Dec 11, 2024' : _date,
                                  leadingIcon: Icons.calendar_today_outlined,
                                  onTap: _pickDate,
                                  fontSize: 13, // Slightly smaller font for date
                                ),
                              ),
                              const SizedBox(width: 8), // Gap 8 instead of 12 for more horizontal space
                              Expanded(
                                child: _buildPickerField(
                                  label: l.time,
                                  value: _time.isEmpty ? '4:40 AM' : _time,
                                  leadingIcon: Icons.access_time,
                                  onTap: _pickTime,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15.99),

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
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: AppColors.greyLight, width: 0.62),
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

  Widget _sectionTitle(String text) => Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.greyDark),
      );

  Widget _buildPickerField({
    required String label,
    required String? value,
    required VoidCallback onTap,
    IconData? leadingIcon,
    Color? iconColor,
    double fontSize = 15,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: AppColors.grey344, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12), // Slightly reduced padding
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.greyF2F),
            ),
            child: Row(
              children: [
                if (leadingIcon != null) ...[
                  Icon(leadingIcon, size: 16, color: iconColor ?? AppColors.adminPrice),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    value ?? '',
                    style: TextStyle(fontSize: fontSize, color: AppColors.greyDark, height: 1.2),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(Icons.chevron_right, size: 16, color: AppColors.borderLightGrey),
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
        color: AppColors.greyBackground,
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
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.greyDark),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: AppColors.grey667),
                ),
              ],
            ),
          ),
          Row(
            children: [
              _stepButton(
                icon: Icons.remove,
                onTap: value > 1 ? () => onChanged(value - 1) : null,
                color: AppColors.borderadmincolor,
                iconColor: AppColors.grey667,
              ),
              const SizedBox(width: 12),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.orangeprimary,
                  borderRadius: BorderRadius.circular(12), // Squircle-like
                ),
                child: Center(
                  child: Text(
                    '$value',
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              _stepButton(
                icon: Icons.add,
                onTap: () => onChanged(value + 1),
                color: Colors.white,
                iconColor: AppColors.orangeprimary,
                hasShadow: true,
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
        color: AppColors.greyBackground,
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
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.greyDark),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l.set_price,
                      style: const TextStyle(fontSize: 12, color: AppColors.grey667),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  _stepButton(
                    icon: Icons.remove,
                    onTap: _pricePerSeat > 1 ? () => setState(() => _pricePerSeat--) : null,
                    color: Colors.white,
                    iconColor: AppColors.orangeprimary,
                    hasShadow: true,
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 52,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.greyF2F),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
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
                    color: Colors.white,
                    iconColor: AppColors.orangeprimary,
                    hasShadow: true,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.adminInfoBG,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: AppColors.lightBlueBg, shape: BoxShape.circle),
                  child: const Icon(Icons.attach_money, size: 14, color: AppColors.infoDarkBlue),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    l.suggested_price_range,
                    style: const TextStyle(fontSize: 13, color: AppColors.infoDarkBlue, fontWeight: FontWeight.w500),
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.greyF2F),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 4), // Added padding for baseline alignment
                child: Icon(Icons.chat_bubble_outline, size: 20, color: AppColors.greyBlueLight),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _notesController,
                  maxLines: 4,
                  maxLength: 200,
                  style: const TextStyle(fontSize: 15, color: AppColors.greyDark),
                  decoration: InputDecoration(
                    hintText: l.notes_hint,
                    hintStyle: const TextStyle(color: AppColors.greyBlueLight, fontSize: 14),
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
              style: const TextStyle(fontSize: 12, color: AppColors.greyBlueLight),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsCard(AppLocalizations l) {
    return Container(
      width: double.infinity,
      height: 123.9,
      padding: const EdgeInsets.symmetric(horizontal: 16), // Reduced vertical padding to prevent overflow
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.successBGStart, AppColors.successBGEnd],
        ),
        borderRadius: BorderRadius.circular(20),
        border: const Border(
          top: BorderSide(color: AppColors.successBorder, width: 0.62),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            l.estimated_earnings,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.darkGreen),
          ),
          const SizedBox(height: 4), // Reduced from 8
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              const Text('₪', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.darkGreen)),
              const SizedBox(width: 4),
              Text(
                '$_estimatedEarnings',
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.darkGreen),
              ),
            ],
          ),
          const SizedBox(height: 2), // Reduced from 4
          Text(
            '$_availableSeats ${l.localeName == 'ar' ? (_availableSeats > 1 ? 'مقاعد' : 'مقعد') : (_availableSeats > 1 ? 'seats' : 'seat')} × ₪$_pricePerSeat ${l.per_seat}',
            style: const TextStyle(fontSize: 12, color: AppColors.darkGreen),
          ),
        ],
      ),
    );
  }

  void _showOptions(BuildContext ctx, String title, List<String> options) {
    showModalBottomSheet(
      context: ctx,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            const SizedBox(height: 16),
            ...options.map((o) => ListTile(
                  title: Text(o),
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

  void _updateLocation(bool isPickup) {
    final l = AppLocalizations.of(context)!;
    final controller = TextEditingController(text: isPickup ? _pickupLocation : _dropoffLocation);
    
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(isPickup ? l.pickup_loc : l.dropoff_loc),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: isPickup ? l.enterPickupLocation : l.enterDropoffLocation),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l.cancel)),
          TextButton(
            onPressed: () {
              setState(() {
                if (isPickup) _pickupLocation = controller.text;
                else _dropoffLocation = controller.text;
              });
              Navigator.pop(ctx);
            },
            child: Text(l.oK),
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
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(AppLocalizations.of(context)!.cancel, style: const TextStyle(color: AppColors.grey667)),
                  ),
                  Text(AppLocalizations.of(context)!.selectDate, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.greyDark)),
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
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(AppLocalizations.of(context)!.cancel, style: const TextStyle(color: AppColors.grey667)),
                  ),
                  Text(AppLocalizations.of(context)!.selectTime, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.greyDark)),
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
