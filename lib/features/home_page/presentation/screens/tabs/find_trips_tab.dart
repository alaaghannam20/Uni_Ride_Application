import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/provider/trip_provider.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/features/home_page/presentation/widgets/trip_cards.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class FindTripsTab extends StatefulWidget {
  const FindTripsTab({super.key});

  @override
  State<FindTripsTab> createState() => _FindTripsTabState();
}

class _FindTripsTabState extends State<FindTripsTab> {
  final _searchCtrl = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TripProvider>().fetchAvailableTrips();
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return RefreshIndicator(
      onRefresh: () => context.read<TripProvider>().fetchAvailableTrips(),
      color: AppColors.orangeprimary,
      child: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // ── Search Bar ──
        Container(
          height: 46,
          decoration: BoxDecoration(
            color: context.bgCard,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: context.borderColor),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(Icons.search, size: 18, color: context.textHint),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _searchCtrl,
                  style: TextStyle(fontSize: 13.7, color: context.textPrimary, fontFamily: 'Inter'),
                  decoration: InputDecoration(
                    hintText: l.search_trips,
                    hintStyle: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 13.7, color: context.textHint),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (val) => setState(() => _query = val.trim().toLowerCase()),
                ),
              ),
              if (_query.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    _searchCtrl.clear();
                    setState(() => _query = '');
                  },
                  child: Icon(Icons.close, size: 16, color: context.textHint),
                ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // ── Header ──
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _query.isEmpty ? l.available_trips : 'Results for "$_query"',
              style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 15.5, color: context.textPrimary),
            ),
            if (_query.isEmpty)
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, Routes.allAvailableTrips),
                child: Text(l.view_all, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 13.6, color: AppColors.orangeprimary)),
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
                child: Center(child: Text(provider.errorMessage, style: const TextStyle(color: Colors.red, fontSize: 14), textAlign: TextAlign.center)),
              );
            }

            final filtered = _query.isEmpty
                ? provider.availableTrips
                : provider.availableTrips.where((t) =>
                    t.pickupLocation.toLowerCase().contains(_query) ||
                    t.dropoffLocation.toLowerCase().contains(_query),
                  ).toList();

            if (filtered.isEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.search_off, size: 40, color: context.textHint),
                      const SizedBox(height: 12),
                      Text(
                        _query.isEmpty ? l.noTripsAvailable : 'No trips found for "$_query"',
                        style: const TextStyle(color: AppColors.greyHint),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }

            final trips = _query.isEmpty ? filtered.take(3).toList() : filtered;

            return Column(
              children: trips.map((trip) => AvailableTripApiCard(trip: trip)).toList(),
            );
          },
        ),
      ],
      ),
    );
  }
}
