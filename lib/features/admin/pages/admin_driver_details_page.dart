import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/models/pending_approval_model.dart';
import 'package:uni_ride_application/core/provider/admin_provider.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

const String _base = 'http://uniride.runasp.net/';

DateTime _parseUtc(String raw) {
  final normalized = raw.endsWith('Z') ? raw : '${raw}Z';
  return DateTime.parse(normalized).toLocal();
}

String _formatDateFull(String raw) {
  if (raw.isEmpty) return '—';
  try {
    return DateFormat('EEEE, MMMM d, y  •  h:mm a').format(_parseUtc(raw));
  } catch (_) {
    return raw;
  }
}

String _formatDateShort(String raw) {
  if (raw.isEmpty) return '';
  try {
    return DateFormat('MMM d, y').format(_parseUtc(raw));
  } catch (_) {
    return raw;
  }
}

class AdminDriverDetailsPage extends StatefulWidget {
  final String id;
  final String type;
  const AdminDriverDetailsPage({super.key, required this.id, required this.type});

  @override
  State<AdminDriverDetailsPage> createState() => _AdminDriverDetailsPageState();
}

class _AdminDriverDetailsPageState extends State<AdminDriverDetailsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminProvider>().fetchPendingApprovalDetails(widget.id, widget.type);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        backgroundColor: context.appBarBg,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: context.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l.driverDetails,
          style: TextStyle(color: context.textPrimary, fontWeight: FontWeight.w700, fontSize: 18),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: context.borderColor),
        ),
      ),
      body: Consumer<AdminProvider>(
        builder: (context, provider, _) {
          if (provider.detailsState == AdminState.loading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.orangeprimary));
          }

          if (provider.detailsState == AdminState.error || provider.selectedApproval == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: AppColors.errorRed),
                  const SizedBox(height: 12),
                  Text(provider.errorMessage, style: TextStyle(color: context.textSecondary)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => provider.fetchPendingApprovalDetails(widget.id, widget.type),
                    child: Text(l.retry),
                  ),
                ],
              ),
            );
          }

          return _DetailsBody(driver: provider.selectedApproval!, l: l);
        },
      ),
    );
  }
}

class _DetailsBody extends StatelessWidget {
  final PendingApprovalModel driver;
  final AppLocalizations l;
  const _DetailsBody({required this.driver, required this.l});

  @override
  Widget build(BuildContext context) {
    final initial = driver.fullName.isNotEmpty ? driver.fullName[0].toUpperCase() : '?';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── Profile Header Card ───────────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.orangeprimary, AppColors.adminGradientEnd],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.orangeprimary.withValues(alpha: 0.25),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 76, height: 76,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.2),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.4), width: 2),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: driver.profileImage != null
                          ? Image.network(
                              '$_base${driver.profileImage}',
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) => Center(
                                child: Text(initial, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28)),
                              ),
                            )
                          : Center(
                              child: Text(initial, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28)),
                            ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(driver.fullName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)),
                          const SizedBox(height: 4),
                          Text(driver.email, style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 13)),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            children: [
                              _chip(driver.type),
                              if (driver.appliedAt.isNotEmpty) _chip(_formatDateShort(driver.appliedAt)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Personal Information ──────────────────────────────────
              _sectionTitle(context, l.personalInformation),
              const SizedBox(height: 12),
              _InfoCard(context: context, items: [
                _InfoItem(icon: Icons.person_outline,  label: l.fullName,     value: driver.fullName),
                _InfoItem(icon: Icons.email_outlined,  label: l.emailAddress, value: driver.email),
                _InfoItem(icon: Icons.phone_outlined,  label: l.phoneNumber,  value: driver.phoneNumber.isEmpty ? '—' : driver.phoneNumber),
              ]),

              const SizedBox(height: 24),

              // ── Vehicle Information ───────────────────────────────────
              _sectionTitle(context, l.vehicleInformation),
              const SizedBox(height: 12),
              _InfoCard(context: context, items: [
                _InfoItem(icon: Icons.directions_car_outlined, label: l.vehicleType,    value: driver.vehicleType.isEmpty  ? '—' : driver.vehicleType),
                _InfoItem(icon: Icons.car_repair,              label: l.vehicleDetails, value: driver.vehicleModel.isEmpty  ? '—' : driver.vehicleModel),
                _InfoItem(icon: Icons.pin_outlined,            label: l.plateNumber,    value: driver.plateNumber.isEmpty  ? '—' : driver.plateNumber),
                if (driver.seatCapacity != null)
                  _InfoItem(icon: Icons.event_seat_outlined,   label: l.numberOfSeats, value: '${driver.seatCapacity}'),
              ]),

              const SizedBox(height: 24),

              // ── License & Documents ───────────────────────────────────
              _sectionTitle(context, l.driverDocuments),
              const SizedBox(height: 12),
              _InfoCard(context: context, items: [
                if (driver.licenseNumber != null && driver.licenseNumber!.isNotEmpty)
                  _InfoItem(icon: Icons.badge_outlined, label: l.licenseNumber,    value: driver.licenseNumber!),
                _InfoItem(icon: Icons.calendar_today,  label: l.appliedDate,      value: _formatDateFull(driver.appliedAt)),
                _InfoItem(icon: Icons.badge_outlined,  label: l.applicationType,  value: driver.type),
              ]),

              // Document Images
              if (driver.driverLicenseImage != null || driver.vehicleLicenseImage != null) ...[
                const SizedBox(height: 24),
                _sectionTitle(context, l.uploadedDocuments),
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (driver.driverLicenseImage != null)
                      Expanded(child: _DocImageCard(
                        context: context,
                        label: l.uploadDriverLicense,
                        url: '$_base${driver.driverLicenseImage}',
                      )),
                    if (driver.driverLicenseImage != null && driver.vehicleLicenseImage != null)
                      const SizedBox(width: 16),
                    if (driver.vehicleLicenseImage != null)
                      Expanded(child: _DocImageCard(
                        context: context,
                        label: l.uploadVehicleLicense,
                        url: '$_base${driver.vehicleLicenseImage}',
                      )),
                  ],
                ),
              ],

              const SizedBox(height: 32),

              // ── Action Buttons ────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: _ActionBtn(
                      label: l.rejectApplication,
                      icon: Icons.cancel_outlined,
                      bgColor: AppColors.adminErrorBG,
                      textColor: AppColors.errorRed,
                      borderColor: AppColors.lightRedBorder,
                      onTap: () => _onReject(context, l),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _ActionBtn(
                      label: l.approveApplication,
                      icon: Icons.check_circle_outline,
                      bgColor: AppColors.adminSuccessBG,
                      textColor: AppColors.adminSuccessText,
                      borderColor: AppColors.adminSuccessText.withValues(alpha: 0.3),
                      onTap: () => _onApprove(context, l),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Text(
      title.toUpperCase(),
      style: TextStyle(
        fontFamily: 'Inter', fontWeight: FontWeight.w600,
        fontSize: 12, letterSpacing: 0.8,
        color: context.textSecondary,
      ),
    );
  }

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }

  Future<void> _onApprove(BuildContext context, AppLocalizations l) async {
    final success = await context.read<AdminProvider>().approveApplication(driver.id, driver.type);
    if (!context.mounted) return;
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.approvedSuccessfully), backgroundColor: AppColors.adminSuccessText),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.read<AdminProvider>().errorMessage), backgroundColor: AppColors.errorRed),
      );
    }
  }

  Future<void> _onReject(BuildContext context, AppLocalizations l) async {
    final success = await context.read<AdminProvider>().rejectApplication(driver.id, driver.type);
    if (!context.mounted) return;
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.rejectedSuccessfully), backgroundColor: AppColors.errorRed),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.read<AdminProvider>().errorMessage), backgroundColor: AppColors.errorRed),
      );
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _InfoItem {
  final IconData icon;
  final String   label;
  final String   value;
  const _InfoItem({required this.icon, required this.label, required this.value});
}

class _InfoCard extends StatelessWidget {
  final List<_InfoItem>  items;
  final BuildContext     context;
  const _InfoCard({required this.items, required this.context});

  @override
  Widget build(BuildContext ctx) {
    return Container(
      decoration: BoxDecoration(
        color: context.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.borderColor),
      ),
      child: Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.orangeprimary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(items[i].icon, size: 20, color: AppColors.orangeprimary),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(items[i].label, style: TextStyle(fontSize: 11, color: context.textSecondary, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 3),
                      Text(items[i].value, style: TextStyle(fontSize: 14, color: context.textPrimary, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
            ),
            if (i < items.length - 1) Divider(height: 1, indent: 76, color: context.borderColor),
          ],
        ],
      ),
    );
  }
}

class _DocImageCard extends StatelessWidget {
  final String       label;
  final String       url;
  final BuildContext context;
  const _DocImageCard({required this.label, required this.url, required this.context});

  @override
  Widget build(BuildContext ctx) {
    return Container(
      decoration: BoxDecoration(
        color: context.bgCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.borderColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 160,
            width: double.infinity,
            child: Image.network(
              url,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => Center(
                child: Icon(Icons.image_not_supported_outlined, size: 40, color: context.textHint),
              ),
              loadingBuilder: (_, child, progress) =>
                  progress == null ? child : const Center(child: CircularProgressIndicator()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: context.textPrimary)),
          ),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String       label;
  final IconData     icon;
  final Color        bgColor;
  final Color        textColor;
  final Color        borderColor;
  final VoidCallback onTap;

  const _ActionBtn({
    required this.label,
    required this.icon,
    required this.bgColor,
    required this.textColor,
    required this.borderColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 20),
            const SizedBox(width: 8),
            Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.w600, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
