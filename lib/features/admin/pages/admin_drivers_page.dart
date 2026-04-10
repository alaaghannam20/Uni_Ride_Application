import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/widgets/responsive.dart';
import 'package:uni_ride_application/features/admin/widgets/admin_layout.dart';
import 'package:uni_ride_application/features/admin/widgets/admin_header.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class AdminDriversPage extends StatelessWidget {
  const AdminDriversPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final bool isDesktop = Responsive.isDesktop(context);

    final drivers = [
      {
        'name': 'Laila Hassan',
        'phone': '+972 59 456 7890',
        'vehicle': '2020 Mazda 3',
        'rating': 4.8,
        'trips': 156,
        'status': 'active',
      },
      {
        'name': 'Omar Saleh',
        'phone': '+972 59 567 8901',
        'vehicle': '2021 Nissan Altima',
        'rating': 4.9,
        'trips': 234,
        'status': 'active',
      },
      {
        'name': 'Fatima Qasem',
        'phone': '+972 59 678 9012',
        'vehicle': '2022 Kia Optima',
        'rating': 4.7,
        'trips': 189,
        'status': 'inactive',
      },
    ];

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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color:  AppColors.borderadmincolor),
                ),
                child: Column(
                  children: [
                    if (isDesktop)
                      Container(
                        height: 52,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: AppColors.borderadmincolor),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(flex: 3, child: Text(locale.driver.toUpperCase(), style: AppStyle.adminCardSectionTitleStyle)),
                            Expanded(flex: 3, child: Text(locale.car.toUpperCase(), style: AppStyle.adminCardSectionTitleStyle)),
                            Expanded(flex: 2, child: Text(locale.rating.toUpperCase(), style: AppStyle.adminCardSectionTitleStyle, textAlign: TextAlign.center)),
                            Expanded(flex: 2, child: Text(locale.totalTrips.toUpperCase(), style: AppStyle.adminCardSectionTitleStyle, textAlign: TextAlign.center)),
                            Expanded(flex: 2, child: Text(locale.status.toUpperCase(), style: AppStyle.adminCardSectionTitleStyle, textAlign: TextAlign.center)),
                            Expanded(flex: 2, child: Text(locale.actions.toUpperCase(), style: AppStyle.adminCardSectionTitleStyle, textAlign: TextAlign.center)),
                          ],
                        ),
                      ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: drivers.length,
                      itemBuilder: (context, index) {
                        final driver = drivers[index];
                        final isLast = index == drivers.length - 1;
                        return _DriverRow(
                          name: driver['name'] as String,
                          phone: driver['phone'] as String,
                          vehicle: driver['vehicle'] as String,
                          rating: driver['rating'] as double,
                          trips: driver['trips'] as int,
                          status: driver['status'] as String,
                          showBottomBorder: !isLast,
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
  final String name;
  final String phone;
  final String vehicle;
  final double rating;
  final int trips;
  final String status;
  final bool showBottomBorder;

  const _DriverRow({
    required this.name,
    required this.phone,
    required this.vehicle,
    required this.rating,
    required this.trips,
    required this.status,
    this.showBottomBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final isActive = status == 'active';
    final bool isDesktop = Responsive.isDesktop(context);

    if (!isDesktop) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: showBottomBorder
              ? const Border(bottom: BorderSide(color: AppColors.adminDivider))
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor:  AppColors.adminDivider,
                  child: const Icon(Icons.person_outline, size: 22, color: AppColors.adminIcon),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: AppStyle.adminCardNameStyle.copyWith(fontSize: 16)),
                      Text(phone, style: AppStyle.adminCardContactStyle),
                    ],
                  ),
                ),
                _buildStatusBadge(isActive, locale),
              ],
            ),
            const SizedBox(height: 12),
            _buildInfoRow(locale.car, vehicle),
            _buildInfoRow(locale.rating, rating.toString(), isRating: true),
            _buildInfoRow(locale.totalTrips, trips.toString()),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.visibility_outlined, size: 18),
                  label: Text(locale.viewDetails ?? "View"),
                  style: TextButton.styleFrom(foregroundColor: AppColors.adminIcon),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.more_vert, size: 20, color: AppColors.adminIcon),
                  onPressed: () {},
                ),
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
            ? const Border(bottom: BorderSide(color: AppColors.adminDivider))
            : null,
      ),
      child: Row(
        children: [
          // Driver Info
          Expanded(
            flex: 3,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor:  AppColors.adminDivider,
                  child: const Icon(Icons.person_outline, size: 20, color: AppColors.adminIcon),
                ),
                const SizedBox(width: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: AppStyle.adminCardNameStyle.copyWith(fontSize: 14)),
                    Text(phone, style: AppStyle.adminCardContactStyle),
                  ],
                ),
              ],
            ),
          ),
          // Vehicle
          Expanded(
            flex: 3,
            child: Text(vehicle, style: AppStyle.adminCardInfoValueStyle.copyWith(fontWeight: FontWeight.w400)),
          ),
          // Rating
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 16),
                const SizedBox(width: 4),
                Text(rating.toString(), style: AppStyle.adminCardInfoValueStyle),
              ],
            ),
          ),
          // Total Trips
          Expanded(
            flex: 2,
            child: Text(trips.toString(), style: AppStyle.adminCardInfoValueStyle, textAlign: TextAlign.center),
          ),
          // Status
          Expanded(
            flex: 2,
            child: Center(child: _buildStatusBadge(isActive, locale)),
          ),
          // Actions
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.visibility_outlined, size: 20, color: AppColors.adminIcon),
                  onPressed: () {},
                ),
                const SizedBox(width: 4),
                IconButton(
                  icon: const Icon(Icons.more_vert, size: 20, color: AppColors.adminIcon),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(bool isActive, AppLocalizations locale) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ?  AppColors.adminSuccessBG :  AppColors.adminDivider,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isActive ? locale.active : locale.inactive,
            style: TextStyle(
              color: isActive ?  AppColors.adminSuccessText :  AppColors.adminIcon,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isRating = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppStyle.adminCardSectionTitleStyle.copyWith(fontSize: 12)),
          Row(
            children: [
              if (isRating) ...[
                const Icon(Icons.star, color: Colors.orange, size: 14),
                const SizedBox(width: 4),
              ],
              Text(value, style: AppStyle.adminCardInfoValueStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
            ],
          ),
        ],
      ),
    );
  }
}
