import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/admin_provider.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/widgets/responsive.dart';
import 'package:uni_ride_application/features/admin/widgets/admin_layout.dart';
import 'package:uni_ride_application/features/admin/widgets/admin_header.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class AdminDriversPage extends StatefulWidget {
  const AdminDriversPage({Key? key}) : super(key: key);

  @override
  State<AdminDriversPage> createState() => _AdminDriversPageState();
}

class _AdminDriversPageState extends State<AdminDriversPage> {
  // Mock data — will be replaced with real API data once GET /api/admin/drivers is available
  final List<Map<String, dynamic>> _drivers = [
    {
      'id': 'ef8c11f3-5831-4877-bb74-900bbf8c9380',
      'name': 'Laila Hassan',
      'phone': '+972 59 456 7890',
      'vehicle': '2020 Mazda 3',
      'rating': 4.8,
      'trips': 156,
      'status': 'active',
    },
    {
      'id': 'a1b2c3d4-1234-5678-abcd-ef0123456789',
      'name': 'Omar Saleh',
      'phone': '+972 59 567 8901',
      'vehicle': '2021 Nissan Altima',
      'rating': 4.9,
      'trips': 234,
      'status': 'active',
    },
    {
      'id': 'b2c3d4e5-2345-6789-bcde-f01234567890',
      'name': 'Fatima Qasem',
      'phone': '+972 59 678 9012',
      'vehicle': '2022 Kia Optima',
      'rating': 4.7,
      'trips': 189,
      'status': 'inactive',
    },
  ];

  Future<void> _toggleStatus(int index) async {
    final driver  = _drivers[index];
    final id      = driver['id'] as String;
    final success = await context.read<AdminProvider>().toggleDriverStatus(id);

    if (!mounted) return;
    if (success) {
      setState(() {
        _drivers[index]['status'] =
            driver['status'] == 'active' ? 'inactive' : 'active';
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.read<AdminProvider>().errorMessage),
          backgroundColor: AppColors.errorRed,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale    = AppLocalizations.of(context)!;
    final isDesktop = Responsive.isDesktop(context);

    return AdminLayout(
      activeRoute: '/AdminDrivers',
      child: Column(
        children: [
          AdminHeader(
            title: locale.driverManagement,
            showSearchAndFilter: true,
            searchHint: 'Search drivers...',
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 32 : 12,
                vertical: 32,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: context.bgCard,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: context.borderColor),
                ),
                child: Column(
                  children: [
                    if (isDesktop)
                      Container(
                        height: 52,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: context.borderColor)),
                        ),
                        child: Row(
                          children: [
                            Expanded(flex: 3, child: Text(locale.driver.toUpperCase(),     style: AppStyle.adminCardSection(context))),
                            Expanded(flex: 3, child: Text(locale.car.toUpperCase(),        style: AppStyle.adminCardSection(context))),
                            Expanded(flex: 2, child: Text(locale.rating.toUpperCase(),     style: AppStyle.adminCardSection(context), textAlign: TextAlign.center)),
                            Expanded(flex: 2, child: Text(locale.totalTrips.toUpperCase(), style: AppStyle.adminCardSection(context), textAlign: TextAlign.center)),
                            Expanded(flex: 2, child: Text(locale.status.toUpperCase(),     style: AppStyle.adminCardSection(context), textAlign: TextAlign.center)),
                            Expanded(flex: 2, child: Text(locale.actions.toUpperCase(),    style: AppStyle.adminCardSection(context), textAlign: TextAlign.center)),
                          ],
                        ),
                      ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _drivers.length,
                      itemBuilder: (context, index) {
                        final driver = _drivers[index];
                        return _DriverRow(
                          name:             driver['name']    as String,
                          phone:            driver['phone']   as String,
                          vehicle:          driver['vehicle'] as String,
                          rating:           driver['rating']  as double,
                          trips:            driver['trips']   as int,
                          status:           driver['status']  as String,
                          showBottomBorder: index < _drivers.length - 1,
                          onToggleStatus:   () => _toggleStatus(index),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DriverRow extends StatelessWidget {
  final String       name;
  final String       phone;
  final String       vehicle;
  final double       rating;
  final int          trips;
  final String       status;
  final bool         showBottomBorder;
  final VoidCallback onToggleStatus;

  const _DriverRow({
    required this.name,
    required this.phone,
    required this.vehicle,
    required this.rating,
    required this.trips,
    required this.status,
    required this.onToggleStatus,
    this.showBottomBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final locale   = AppLocalizations.of(context)!;
    final isActive = status == 'active';
    final isDesktop = Responsive.isDesktop(context);

    if (!isDesktop) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: showBottomBorder
              ? Border(bottom: BorderSide(color: context.borderColor))
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: context.bgSubtle,
                  child: Icon(Icons.person_outline, size: 22, color: context.textSecondary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: AppStyle.adminCardName(context, fontSize: 16)),
                      Text(phone, style: AppStyle.adminCardContact(context)),
                    ],
                  ),
                ),
                _statusBadge(isActive, locale),
              ],
            ),
            const SizedBox(height: 12),
            _infoRow(context, locale.car, vehicle),
            _infoRow(context, locale.rating, rating.toString(), isRating: true),
            _infoRow(context, locale.totalTrips, trips.toString()),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.visibility_outlined, size: 18),
                  label: Text(locale.viewDetails),
                  style: TextButton.styleFrom(foregroundColor: AppColors.adminIcon),
                ),
                const SizedBox(width: 8),
                _moreMenu(context, locale, isActive),
              ],
            ),
          ],
        ),
      );
    }

    return Container(
      height: 73,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        border: showBottomBorder
            ? Border(bottom: BorderSide(color: context.borderColor))
            : null,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: context.bgSubtle,
                  child: Icon(Icons.person_outline, size: 20, color: context.textSecondary),
                ),
                const SizedBox(width: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,  style: AppStyle.adminCardName(context, fontSize: 14)),
                    Text(phone, style: AppStyle.adminCardContact(context)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(flex: 3, child: Text(vehicle, style: AppStyle.adminCardValue(context))),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 16),
                const SizedBox(width: 4),
                Text(rating.toString(), style: AppStyle.adminCardValue(context)),
              ],
            ),
          ),
          Expanded(flex: 2, child: Text(trips.toString(), style: AppStyle.adminCardValue(context), textAlign: TextAlign.center)),
          Expanded(flex: 2, child: Center(child: _statusBadge(isActive, locale))),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.visibility_outlined, size: 20, color: context.textSecondary),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const SizedBox(width: 8),
                _moreMenu(context, locale, isActive),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _moreMenu(BuildContext context, AppLocalizations locale, bool isActive) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, size: 20, color: context.textSecondary),
      color: context.bgCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: context.borderColor),
      ),
      onSelected: (value) {
        if (value == 'toggle') onToggleStatus();
      },
      itemBuilder: (_) => [
        PopupMenuItem(
          value: 'toggle',
          child: Row(
            children: [
              Icon(
                isActive ? Icons.block : Icons.check_circle_outline,
                size: 18,
                color: isActive ? AppColors.errorRed : AppColors.adminSuccessText,
              ),
              const SizedBox(width: 8),
              Text(
                isActive ? locale.deactivate : locale.activate,
                style: TextStyle(
                  color: isActive ? AppColors.errorRed : AppColors.adminSuccessText,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statusBadge(bool isActive, AppLocalizations locale) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? AppColors.adminSuccessBG : AppColors.adminDivider,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isActive ? locale.active : locale.inactive,
        style: TextStyle(
          color: isActive ? AppColors.adminSuccessText : AppColors.adminIcon,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _infoRow(BuildContext context, String label, String value, {bool isRating = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppStyle.adminCardSection(context).copyWith(fontSize: 12)),
          Row(
            children: [
              if (isRating) ...[
                const Icon(Icons.star, color: Colors.orange, size: 14),
                const SizedBox(width: 4),
              ],
              Text(value, style: AppStyle.adminCardValue(context, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
