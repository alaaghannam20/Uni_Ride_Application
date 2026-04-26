import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/trip_provider.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/features/home_page/presentation/widgets/trip_cards.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class FindTripsTab extends StatefulWidget {
  const FindTripsTab({super.key});

  @override
  State<FindTripsTab> createState() => _FindTripsTabState();
}

class _FindTripsTabState extends State<FindTripsTab> {
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

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.greyE5E),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Icon(Icons.search, size: 18, color: AppColors.languagecolor),
              const SizedBox(width: 10),
              Text(
                l.search_trips,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  fontSize: 13.7,
                  color: AppColors.languagecolor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l.available_trips,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 15.5,
                color: AppColors.skiptextcolor,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, Routes.allAvailableTrips),
              child: Text(
                l.view_all,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 13.6,
                  color: AppColors.orangeprimary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Consumer<TripProvider>(
          builder: (context, provider, _) {
            if (provider.availableTripsState == TripState.loading) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(child: CircularProgressIndicator(color: AppColors.orangeprimary)),
              );
            }
            if (provider.availableTripsState == TripState.error) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Text(
                    provider.errorMessage,
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            if (provider.availableTrips.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Text(l.noTripsAvailable, style: const TextStyle(color: AppColors.greyHint)),
                ),
              );
            }
            return Column(
              children: provider.availableTrips
                  .take(3)
                  .map((trip) => AvailableTripApiCard(trip: trip))
                  .toList(),
            );
          },
        ),
      ],
    );
  }
}
