import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/models/user_model.dart';
import 'package:uni_ride_application/core/provider/auth_provider.dart';
import 'package:uni_ride_application/core/provider/trip_provider.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/routes/routes.dart';
import 'package:uni_ride_application/features/home_page/presentation/widgets/trip_cards.dart';
import 'package:uni_ride_application/features/regestration_pages/presentation/screens/signup_driver.dart';

class CarpoolTab extends StatefulWidget {
  const CarpoolTab({super.key});

  @override
  State<CarpoolTab> createState() => _CarpoolTabState();
}

class _CarpoolTabState extends State<CarpoolTab> {
  int _carpoolSubTab = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TripProvider>().fetchAvailableTrips();
      final userType = context.read<AuthProvider>().userType;
      if (userType == UserType.carpool) {
        context.read<TripProvider>().fetchMyTrips();
      }
    });
  }

  void _handleOfferClick() {
    final userType = context.read<AuthProvider>().userType;
    final user = context.read<AuthProvider>().user;

    if (userType == UserType.carpool) {
      if (user?.isActive == true) {
        // ✅ مسجل ومعتمد → صفحة العرض
        Navigator.pushNamed(context, Routes.offerCarpool);
      } else {
        // ✅ مسجل بس تحت المراجعة
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.underReview),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } else {
      // ✅ مش مسجل كـ carpool → روح لتسجيل الكاربول
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SignUpDriverScreen.carpoolRigestration(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            'Carpool',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.greyDark,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _buildTabItem(l.find_rides, _carpoolSubTab == 0, () => setState(() => _carpoolSubTab = 0)),
              const SizedBox(width: 24),
              _buildTabItem(l.my_rides, _carpoolSubTab == 1, () => setState(() => _carpoolSubTab = 1)),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 1, color: AppColors.greyF2F),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              const SizedBox(height: 24),
              if (_carpoolSubTab == 0) ...[
                _buildOfferBanner(l),
                const SizedBox(height: 32),
                _buildSectionLabel(l.available_rides, l.filter_label),
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
                      return Center(child: Text(provider.errorMessage, style: const TextStyle(color: Colors.red)));
                    }
                    if (provider.availableTrips.isEmpty) {
                      return Center(child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Text(l.noTripsAvailable, style: const TextStyle(color: AppColors.greyHint)),
                      ));
                    }
                    final carpoolTrips = provider.availableTrips
                        .where((t) => t.driverType == 'Carpool')
                        .toList();
                    if (carpoolTrips.isEmpty) {
                      return Center(child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Text(l.noTripsAvailable, style: const TextStyle(color: AppColors.greyHint)),
                      ));
                    }
                    return Column(
                      children: carpoolTrips
                          .map((trip) => AvailableTripApiCard(trip: trip))
                          .toList(),
                    );
                  },
                ),
              ] else ...[
                Consumer<TripProvider>(
                  builder: (context, provider, _) {
                    final userType = context.read<AuthProvider>().userType;
                    if (userType != UserType.carpool) return _buildMyRidesEmptyState(l);
                    if (provider.myTripsState == TripState.loading) {
                      return const Padding(padding: EdgeInsets.symmetric(vertical: 40), child: Center(child: CircularProgressIndicator(color: AppColors.orangeprimary)));
                    }
                    if (provider.myTrips.isEmpty) return _buildMyRidesEmptyState(l);
                    return Column(
                      children: provider.myTrips.map((t) => MyTripApiCard(trip: t)).toList(),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTabItem(String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                color: isActive ? AppColors.orangeprimary : AppColors.grey667,
              ),
            ),
          ),
          if (isActive)
            Container(
              height: 2,
              width: 40,
              decoration: BoxDecoration(
                color: AppColors.orangeprimary,
                borderRadius: BorderRadius.circular(2),
              ),
            )
          else
            const SizedBox(height: 2),
        ],
      ),
    );
  }

  Widget _buildOfferBanner(AppLocalizations l) {
    return GestureDetector(
      onTap: _handleOfferClick,
      child: Container(
        width: double.infinity,
        height: 112,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [AppColors.orangeprimary, AppColors.primaryGradientEnd],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppColors.orangeprimary.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    l.offer_a_ride,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l.offer_ride_sub,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 28),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String title, String filterLabel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.greyDark),
        ),
        Row(
          children: [
            const Icon(Icons.filter_alt_outlined, size: 16, color: AppColors.orangeprimary),
            const SizedBox(width: 4),
            Text(filterLabel,
                style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.orangeprimary,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }

  Widget _buildMyRidesEmptyState(AppLocalizations l) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 60),
        Container(
          width: 80,
          height: 80,
          decoration: const BoxDecoration(
            color: AppColors.greyBackground,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.directions_car_filled_outlined,
              size: 40, color: AppColors.dashedLineColor),
        ),
        const SizedBox(height: 24),
        Text(
          l.no_rides_yet,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.greyDark,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            l.no_rides_sub,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.grey667,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 32),
        SizedBox(
          width: 220,
          child: ElevatedButton(
            onPressed: _handleOfferClick,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.orangeprimary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 0,
            ),
            child: Text(
              l.offer_first_ride,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}