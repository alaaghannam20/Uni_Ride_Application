import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/trip_provider.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/features/home_page/presentation/widgets/trip_cards.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class AllAvailableTripsScreen extends StatefulWidget {
  const AllAvailableTripsScreen({super.key});

  @override
  State<AllAvailableTripsScreen> createState() => _AllAvailableTripsScreenState();
}

class _AllAvailableTripsScreenState extends State<AllAvailableTripsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TripProvider>().fetchAvailableTrips();
    });
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
          icon: const Icon(Icons.arrow_back, color: AppColors.greyDark),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l.all_available_trips,
          style: const TextStyle(color: AppColors.greyDark, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Consumer<TripProvider>(
        builder: (context, provider, _) {
          if (provider.availableTripsState == TripState.loading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.orangeprimary));
          }
          if (provider.availableTripsState == TripState.error) {
            return Center(
              child: Text(provider.errorMessage, style: const TextStyle(color: Colors.red, fontSize: 14), textAlign: TextAlign.center),
            );
          }

          final trips = provider.availableTrips;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l.trips_available_count(trips.length),
                      style: const TextStyle(color: AppColors.grey667, fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          const Icon(Icons.tune, size: 18, color: AppColors.orangeprimary),
                          const SizedBox(width: 4),
                          Text(l.filter_label, style: const TextStyle(color: AppColors.orangeprimary, fontSize: 14, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: trips.isEmpty
                    ? Center(child: Text(l.noTripsAvailable, style: const TextStyle(color: AppColors.greyHint)))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: trips.length,
                        itemBuilder: (context, index) => AvailableTripApiCard(trip: trips[index]),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
