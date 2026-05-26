import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/models/admin_trip_model.dart';
import 'package:uni_ride_application/core/provider/admin_provider.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/features/admin/widgets/admin_layout.dart';
import 'package:uni_ride_application/features/admin/widgets/admin_header.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class AdminOverviewPage extends StatefulWidget {
  const AdminOverviewPage({Key? key}) : super(key: key);

  @override
  State<AdminOverviewPage> createState() => _AdminOverviewPageState();
}

class _AdminOverviewPageState extends State<AdminOverviewPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminProvider>().fetchDashboardStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;
    return AdminLayout(
      activeRoute: '/AdminOverview',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AdminHeader(
            title: l.dashboardOverview,
            showSearchAndFilter: false,
          ),
          Expanded(
            child: Consumer<AdminProvider>(
              builder: (context, provider, _) {
                if (provider.dashboardState == AdminState.loading) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.orangeprimary));
                }
                if (provider.dashboardState == AdminState.error) {
                  return Center(child: Text(provider.errorMessage, style: const TextStyle(color: Colors.red)));
                }

                final stats = provider.dashboardStats;

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Stats Row ──────────────────────────────────────
                      Row(
                        children: [
                          Expanded(child: _buildStatCard(context,
                            icon: Icons.people_outline,
                            iconColor: Colors.blue,
                            iconBgColor: Colors.blue.withValues(alpha: 0.1),
                            value: '${stats?.totalUsersCount ?? 0}',
                            label: l.totalUsers,
                          )),
                          const SizedBox(width: 24),
                          Expanded(child: _buildStatCard(context,
                            icon: Icons.directions_car_outlined,
                            iconColor: Colors.green,
                            iconBgColor: Colors.green.withValues(alpha: 0.1),
                            value: '${stats?.activeDriversCount ?? 0}',
                            label: l.activeDrivers,
                          )),
                          const SizedBox(width: 24),
                          Expanded(child: _buildStatCard(context,
                            icon: Icons.trending_up,
                            iconColor: AppColors.orangeprimary,
                            iconBgColor: AppColors.orangeprimary.withValues(alpha: 0.1),
                            value: '${stats?.totalTripsCount ?? 0}',
                            label: l.totalTripsCount,
                          )),
                          const SizedBox(width: 24),
                          Expanded(child: _buildStatCard(context,
                            icon: Icons.error_outline,
                            iconColor: AppColors.redColor,
                            iconBgColor: AppColors.redColor.withValues(alpha: 0.1),
                            value: '${stats?.pendingApprovalsCount ?? 0}',
                            label: l.pendingApprovals,
                          )),
                        ],
                      ),
                      const SizedBox(height: 32),

                      // ── Revenue & Active Trips ─────────────────────────
                      IntrinsicHeight(
                        child: Row(
                          children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [AppColors.orangeprimary, AppColors.adminGradientEnd],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(alpha: 0.2),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.attach_money, color: Colors.white, size: 20),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(l.todayRevenue, style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white)),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    '₪${stats?.totalRevenue.toStringAsFixed(2) ?? '0.00'}',
                                    style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 36, color: Colors.white),
                                  ),
                                  const SizedBox(height: 16),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.account_balance_wallet_outlined, color: Colors.white, size: 14),
                                        const SizedBox(width: 6),
                                        Text(
                                          '${l.platformEarnings}: ₪${stats?.platformBalance.toStringAsFixed(2) ?? '0.00'}',
                                          style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 12, color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: context.bgCard,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: AppColors.borderadmincolor),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.purple.withValues(alpha: 0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.access_time, color: Colors.purple, size: 20),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(l.activeTripsNow, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 14, color: context.textPrimary)),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    '${stats?.activeTripsNowCount ?? 0}',
                                    style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 36, color: context.textPrimary),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(l.realtimeMonitoring, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 12, color: context.textSecondary)),
                                ],
                              ),
                            ),
                          ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // ── Recent Trips ───────────────────────────────────
                      Container(
                        decoration: BoxDecoration(
                          color: context.bgCard,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.borderadmincolor),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(24),
                              child: Text(l.recentTrips, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 16, color: context.textPrimary)),
                            ),
                            const Divider(height: 1, color: AppColors.borderadmincolor),
                            if (stats == null || stats.recentTrips.isEmpty)
                              Padding(
                                padding: const EdgeInsets.all(24),
                                child: Center(child: Text(l.noRecentTrips, style: const TextStyle(color: AppColors.greyHint))),
                              )
                            else
                              ...stats.recentTrips.asMap().entries.map((entry) {
                                final i    = entry.key;
                                final trip = entry.value;
                                return Column(
                                  children: [
                                    _buildTripItem(trip),
                                    if (i < stats.recentTrips.length - 1)
                                      const Divider(height: 1, indent: 24, endIndent: 24, color: AppColors.borderadmincolor),
                                  ],
                                );
                              }),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String value,
    required String label,
  }) {
    return Container(
      height: 187,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: context.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderadmincolor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: iconBgColor, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const Spacer(),
          Text(value, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 28, color: context.textPrimary)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 14, color: context.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildTripItem(AdminTripModel trip) {
    final isCompleted   = trip.status.toLowerCase() == 'completed';
    final statusColor   = isCompleted ? Colors.green : Colors.blue;
    final statusBgColor = isCompleted ? Colors.green.withValues(alpha: 0.1) : Colors.blue.withValues(alpha: 0.1);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: context.bgSubtle,
            child: Icon(Icons.directions_car_outlined, color: context.textSecondary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(trip.driverName, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w500, fontSize: 14, color: context.textPrimary)),
                const SizedBox(height: 4),
                Text(trip.route, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 12, color: context.textSecondary)),
              ],
            ),
          ),
          Text('₪${trip.price.toStringAsFixed(0)}', style: const TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.orangeprimary)),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: statusBgColor, borderRadius: BorderRadius.circular(16)),
            child: Text(trip.status, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 12, color: statusColor)),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 100,
            child: Text(trip.timeAgo, textAlign: TextAlign.right, style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w400, fontSize: 12, color: context.textSecondary)),
          ),
        ],
      ),
    );
  }
}
