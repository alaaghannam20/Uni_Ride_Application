import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/models/admin_driver_model.dart';
import 'package:uni_ride_application/core/provider/admin_provider.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/widgets/responsive.dart';
import 'package:uni_ride_application/features/admin/widgets/admin_layout.dart';
import 'package:uni_ride_application/features/admin/widgets/admin_header.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class AdminDriversPage extends StatefulWidget {
  const AdminDriversPage({super.key});

  @override
  State<AdminDriversPage> createState() => _AdminDriversPageState();
}

class _AdminDriversPageState extends State<AdminDriversPage> {
  String _query = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminProvider>().fetchDriversList();
    });
  }

  Future<void> _toggleStatus(AdminDriverModel driver) async {
    final success = await context.read<AdminProvider>().toggleDriverStatus(driver.id);
    if (!mounted) return;
    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.read<AdminProvider>().errorMessage),
          backgroundColor: AppColors.errorRed,
        ),
      );
    } else {
      context.read<AdminProvider>().fetchDriversList();
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
            onSearch: (val) => setState(() => _query = val.trim().toLowerCase()),
          ),
          Expanded(
            child: Consumer<AdminProvider>(
              builder: (context, provider, _) {
                if (provider.driversState == AdminState.loading && provider.drivers.isEmpty) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.orangeprimary));
                }

                if (provider.driversState == AdminState.error && provider.drivers.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 48, color: AppColors.errorRed),
                        const SizedBox(height: 12),
                        Text(provider.errorMessage, style: TextStyle(color: context.textSecondary)),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => provider.fetchDriversList(),
                          child: Text(locale.retry),
                        ),
                      ],
                    ),
                  );
                }

                final drivers = _query.isEmpty
                    ? provider.drivers
                    : provider.drivers.where((d) =>
                        d.fullName.toLowerCase().contains(_query) ||
                        d.vehicleInfo.toLowerCase().contains(_query),
                      ).toList();

                if (drivers.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.directions_car_outlined, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text(locale.noDriversFound, style: AppStyle.adminCardSection(context).copyWith(color: Colors.grey)),
                      ],
                    ),
                  );
                }

                return SingleChildScrollView(
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
                          itemCount: drivers.length,
                          itemBuilder: (context, index) {
                            final driver = drivers[index];
                            return _DriverRow(
                              driver:           driver,
                              showBottomBorder: index < drivers.length - 1,
                              onToggleStatus:   () => _toggleStatus(driver),
                            );
                          },
                        ),
                      ],
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

class _DriverRow extends StatelessWidget {
  final AdminDriverModel driver;
  final bool             showBottomBorder;
  final VoidCallback     onToggleStatus;

  const _DriverRow({
    required this.driver,
    required this.onToggleStatus,
    this.showBottomBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final locale    = AppLocalizations.of(context)!;
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
                      Text(driver.fullName,    style: AppStyle.adminCardName(context, fontSize: 16)),
                      Text(driver.phoneNumber, style: AppStyle.adminCardContact(context)),
                    ],
                  ),
                ),
                _statusBadge(context, locale),
              ],
            ),
            const SizedBox(height: 12),
            _infoRow(context, locale.car,        driver.vehicleInfo),
            _infoRow(context, locale.rating,     driver.rating.toStringAsFixed(1), isRating: true),
            _infoRow(context, locale.totalTrips, driver.totalTrips.toString()),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _moreMenu(context, locale),
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
                    Text(driver.fullName,    style: AppStyle.adminCardName(context, fontSize: 14)),
                    Text(driver.phoneNumber, style: AppStyle.adminCardContact(context)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(flex: 3, child: Text(driver.vehicleInfo, style: AppStyle.adminCardValue(context))),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 16),
                const SizedBox(width: 4),
                Text(driver.rating.toStringAsFixed(1), style: AppStyle.adminCardValue(context)),
              ],
            ),
          ),
          Expanded(flex: 2, child: Text(driver.totalTrips.toString(), style: AppStyle.adminCardValue(context), textAlign: TextAlign.center)),
          Expanded(flex: 2, child: Center(child: _statusBadge(context, locale))),
          Expanded(
            flex: 2,
            child: Center(child: _moreMenu(context, locale)),
          ),
        ],
      ),
    );
  }

  Widget _moreMenu(BuildContext context, AppLocalizations locale) {
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
                driver.isActive ? Icons.block : Icons.check_circle_outline,
                size: 18,
                color: driver.isActive ? AppColors.errorRed : AppColors.adminSuccessText,
              ),
              const SizedBox(width: 8),
              Text(
                driver.isActive ? locale.deactivate : locale.activate,
                style: TextStyle(
                  color: driver.isActive ? AppColors.errorRed : AppColors.adminSuccessText,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statusBadge(BuildContext context, AppLocalizations locale) {
    final isActive  = driver.isActive;
    final isPending = driver.status.toLowerCase() == 'pending';
    final Color bg;
    final Color fg;
    final String label;

    if (isActive) {
      bg    = AppColors.adminSuccessBG;
      fg    = AppColors.adminSuccessText;
      label = locale.active;
    } else if (isPending) {
      bg    = AppColors.orangeprimary.withValues(alpha: 0.12);
      fg    = AppColors.orangeprimary;
      label = driver.status;
    } else {
      bg    = AppColors.adminDivider;
      fg    = AppColors.adminIcon;
      label = locale.inactive;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label, style: TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.w500)),
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
