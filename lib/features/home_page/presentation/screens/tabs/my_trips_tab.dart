import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/trip_provider.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/features/home_page/data/models/my_trip_model.dart';
import 'package:uni_ride_application/features/home_page/presentation/widgets/trip_cards.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class MyTripsTab extends StatefulWidget {
  const MyTripsTab({super.key});

  @override
  State<MyTripsTab> createState() => _MyTripsTabState();
}

class _MyTripsTabState extends State<MyTripsTab> {
  int _filterIndex = 0; // 0: All, 1: Upcoming, 2: Completed

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TripProvider>().fetchMyTrips();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Consumer<TripProvider>(
      builder: (context, provider, _) {
        final all = provider.myTrips;
        final upcoming = all.where((t) => t.status.toLowerCase() == 'scheduled').toList();
        final completed = all.where((t) => t.status.toLowerCase() == 'completed').toList();

        final List<MyTripModel> filtered = switch (_filterIndex) {
          1 => upcoming,
          2 => completed,
          _ => all,
        };

        return Column(
          children: [
            Container(
              height: 50.5,
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              child: Row(
                children: [
                  _filterTab(l.all, all.length, _filterIndex == 0, () => setState(() => _filterIndex = 0)),
                  const SizedBox(width: 24),
                  _filterTab(l.upcoming, upcoming.length, _filterIndex == 1, () => setState(() => _filterIndex = 1)),
                  const SizedBox(width: 24),
                  _filterTab(l.completed, completed.length, _filterIndex == 2, () => setState(() => _filterIndex = 2)),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.greyE5E),
            Expanded(child: _buildBody(provider, filtered, l)),
          ],
        );
      },
    );
  }

  Widget _buildBody(TripProvider provider, List<MyTripModel> trips, AppLocalizations l) {
    if (provider.myTripsState == TripState.loading) {
      return const Center(child: CircularProgressIndicator(color: AppColors.orangeprimary));
    }
    if (provider.myTripsState == TripState.error) {
      return Center(
        child: Text(provider.errorMessage, style: const TextStyle(color: Colors.red, fontSize: 14), textAlign: TextAlign.center),
      );
    }
    if (trips.isEmpty) {
      return Center(child: Text(l.noTripsFound, style: const TextStyle(color: AppColors.greyHint)));
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: trips.length,
      itemBuilder: (context, index) => MyTripApiCard(trip: trips[index]),
    );
  }

  Widget _filterTab(String label, int count, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: isActive ? AppColors.orangeprimary : AppColors.greySecondary,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.orangeprimary : AppColors.greyE5E,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$count',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isActive ? Colors.white : AppColors.greySecondary),
                ),
              ),
            ],
          ),
          const Spacer(),
          if (isActive) Container(height: 2, width: 40, color: AppColors.orangeprimary),
        ],
      ),
    );
  }
}
