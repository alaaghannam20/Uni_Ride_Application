import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/models/admin_trip_model.dart';
import 'package:uni_ride_application/core/provider/admin_provider.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/widgets/responsive.dart';
import 'package:uni_ride_application/features/admin/widgets/admin_layout.dart';
import 'package:uni_ride_application/features/admin/widgets/admin_header.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class AdminTripsPage extends StatefulWidget {
  const AdminTripsPage({super.key});

  @override
  State<AdminTripsPage> createState() => _AdminTripsPageState();
}

class _AdminTripsPageState extends State<AdminTripsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminProvider>().fetchAdminTrips();
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale    = AppLocalizations.of(context)!;
    final isDesktop = Responsive.isDesktop(context);

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
            child: Consumer<AdminProvider>(
              builder: (context, provider, _) {
                if (provider.tripsState == AdminState.loading) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.orangeprimary));
                }
                if (provider.tripsState == AdminState.error) {
                  return Center(child: Text(provider.errorMessage, style: const TextStyle(color: Colors.red)));
                }

                final trips = provider.adminTrips;

                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: isDesktop ? 25 : 12, vertical: 25),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.borderadmincolor),
                    ),
                    child: trips.isEmpty
                        ? Padding(
                            padding: const EdgeInsets.all(32),
                            child: Center(child: Text(locale.noTripsFound, style: const TextStyle(color: AppColors.greyHint))),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: trips.length,
                            itemBuilder: (context, index) => _TripCard(
                              trip: trips[index],
                              showBottomBorder: index < trips.length - 1,
                            ),
                          ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TripCard extends StatelessWidget {
  final AdminTripModel trip;
  final bool showBottomBorder;

  const _TripCard({required this.trip, this.showBottomBorder = true});

  @override
  Widget build(BuildContext context) {
    final locale      = AppLocalizations.of(context)!;
    final isCompleted = trip.status.toLowerCase() == 'completed';
    final isOngoing   = trip.status.toLowerCase() == 'ongoing';
    final isDesktop   = Responsive.isDesktop(context);

    return Container(
      constraints: BoxConstraints(minHeight: isDesktop ? 89 : 100),
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 24 : 12, vertical: isDesktop ? 0 : 12),
      decoration: BoxDecoration(
        border: showBottomBorder ? const Border(bottom: BorderSide(color: AppColors.adminDivider)) : null,
      ),
      child: Row(
        children: [
          if (isDesktop) ...[
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(color: AppColors.adminDivider, borderRadius: BorderRadius.circular(14)),
              child: const Icon(Icons.directions_car_outlined, color: AppColors.adminIcon, size: 24),
            ),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(trip.driverName, style: AppStyle.adminCardNameStyle.copyWith(fontSize: isDesktop ? 15 : 14)),
                const SizedBox(height: 4),
                Text(trip.route, style: AppStyle.adminCardContactStyle.copyWith(fontSize: isDesktop ? 13 : 11)),
                if (!isDesktop) ...[
                  const SizedBox(height: 4),
                  Text(trip.timeAgo, style: const TextStyle(color: AppColors.adminTextMuted, fontSize: 11)),
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
                    '${locale.ils}${trip.price.toStringAsFixed(0)}',
                    style: TextStyle(color: AppColors.adminPrice, fontWeight: FontWeight.bold, fontSize: isDesktop ? 16 : 14),
                  ),
                  if (isDesktop) ...[
                    const SizedBox(width: 24),
                    _statusBadge(locale, isCompleted, isOngoing),
                  ],
                ],
              ),
              if (!isDesktop) ...[
                const SizedBox(height: 4),
                _statusBadge(locale, isCompleted, isOngoing, small: true),
              ],
            ],
          ),
          if (isDesktop) ...[
            const SizedBox(width: 24),
            SizedBox(
              width: 100,
              child: Text(trip.timeAgo, style: const TextStyle(color: AppColors.adminTextMuted, fontSize: 13), textAlign: TextAlign.end),
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

  Widget _statusBadge(AppLocalizations locale, bool isCompleted, bool isOngoing, {bool small = false}) {
    final color   = isCompleted ? AppColors.adminSuccessText : isOngoing ? AppColors.adminInfoText : AppColors.adminErrorText;
    final bgColor = isCompleted ? AppColors.adminSuccessBG   : isOngoing ? AppColors.adminInfoBG   : AppColors.adminErrorBG;
    final label   = isCompleted ? locale.completed : isOngoing ? locale.ongoing : locale.cancelled;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: small ? 8 : 10, vertical: small ? 2 : 4),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(12)),
      child: Text(label, style: TextStyle(color: color, fontSize: small ? 10 : 12, fontWeight: FontWeight.w500)),
    );
  }
}
