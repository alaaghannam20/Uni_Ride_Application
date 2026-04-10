import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/widgets/responsive.dart';
import 'package:uni_ride_application/features/admin/widgets/admin_layout.dart';
import 'package:uni_ride_application/features/admin/widgets/admin_header.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class AdminTripsPage extends StatelessWidget {
  const AdminTripsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final bool isDesktop = Responsive.isDesktop(context);

    final trips = [
      {
        'driver': 'Laila H.',
        'student': 'Sara K.',
        'from': 'PTUK University',
        'to': 'City Center',
        'price': 8,
        'status': 'completed',
        'time': '10 min ago',
      },
      {
        'driver': 'Omar S.',
        'student': 'Ahmed M.',
        'from': 'Main Square',
        'to': 'PTUK University',
        'price': 10,
        'status': 'ongoing',
        'time': 'Now',
      },
      {
        'driver': 'Fatima Q.',
        'student': 'Mohammed A.',
        'from': 'City Center',
        'to': 'PTUK University',
        'price': 7,
        'status': 'completed',
        'time': '25 min ago',
      },
    ];

    return AdminLayout(
      activeRoute: '/AdminTrips',
      child: Column(
        children: [
          AdminHeader(
            title: locale.tripManagement,
            showSearchAndFilter: true,
            searchHint: 'Search trips...',
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 25 : 12,
                vertical: 25,
              ),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color:  AppColors.borderadmincolor),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: trips.length,
                  itemBuilder: (context, index) {
                    final trip = trips[index];
                    final isLast = index == trips.length - 1;
                    return _TripCard(
                      driverName: trip['driver'] as String,
                      studentName: trip['student'] as String,
                      from: trip['from'] as String,
                      to: trip['to'] as String,
                      price: trip['price'] as int,
                      status: trip['status'] as String,
                      time: trip['time'] as String,
                      showBottomBorder: !isLast,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TripCard extends StatelessWidget {
  final String driverName;
  final String studentName;
  final String from;
  final String to;
  final int price;
  final String status;
  final String time;
  final bool showBottomBorder;

  const _TripCard({
    required this.driverName,
    required this.studentName,
    required this.from,
    required this.to,
    required this.price,
    required this.status,
    required this.time,
    this.showBottomBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final isCompleted = status == 'completed';
    final isOngoing = status == 'ongoing';
    final bool isDesktop = Responsive.isDesktop(context);

    return Container(
      constraints: BoxConstraints(minHeight: isDesktop ? 89 : 100),
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 24 : 12, vertical: isDesktop ? 0 : 12),
      decoration: BoxDecoration(
        border: showBottomBorder
            ? const Border(bottom: BorderSide(color: AppColors.adminDivider))
            : null,
      ),
      child: Row(
        children: [
          if (isDesktop) ...[
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color:  AppColors.adminDivider,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.directions_car_outlined, color:  AppColors.adminIcon, size: 24),
            ),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$driverName → $studentName',
                  style: AppStyle.adminCardNameStyle.copyWith(
                    fontSize: isDesktop ? 15 : 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$from → $to',
                  style: AppStyle.adminCardContactStyle.copyWith(
                    fontSize: isDesktop ? 13 : 11,
                  ),
                ),
                if (!isDesktop) ...[
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: const TextStyle(
                      color: AppColors.adminTextMuted,
                      fontSize: 11,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${locale.ils}$price',
                    style: TextStyle(
                      color: AppColors.adminPrice,
                      fontWeight: FontWeight.bold,
                      fontSize: isDesktop ? 16 : 14,
                    ),
                  ),
                  if (isDesktop) const SizedBox(width: 24),
                  if (isDesktop)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isCompleted
                            ?  AppColors.adminSuccessBG
                            : isOngoing
                                ?  AppColors.adminInfoBG
                                :  AppColors.adminErrorBG,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        isCompleted
                            ? locale.completed
                            : isOngoing
                                ? locale.ongoing
                                : locale.cancelled,
                        style: TextStyle(
                          color: isCompleted
                              ?  AppColors.adminSuccessText
                              : isOngoing
                                  ?  AppColors.adminInfoText
                                  :  AppColors.adminErrorText,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
              if (!isDesktop) ...[
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: isCompleted
                        ?  AppColors.adminSuccessBG
                        : isOngoing
                            ?  AppColors.adminInfoBG
                            :  AppColors.adminErrorBG,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isCompleted
                        ? locale.completed
                        : isOngoing
                            ? locale.ongoing
                            : locale.cancelled,
                    style: TextStyle(
                      color: isCompleted
                          ?  AppColors.adminSuccessText
                          : isOngoing
                              ?  AppColors.adminInfoText
                              :  AppColors.adminErrorText,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (isDesktop) ...[
            const SizedBox(width: 24),
            SizedBox(
              width: 80,
              child: Text(
                time,
                style: const TextStyle(
                  color: AppColors.adminTextMuted,
                  fontSize: 13,
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ],
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.visibility_outlined, size: isDesktop ? 20 : 18, color: AppColors.adminIcon),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
