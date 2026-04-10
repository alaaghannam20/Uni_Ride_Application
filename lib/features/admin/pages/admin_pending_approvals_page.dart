import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/models/pending_approval_model.dart';
import 'package:uni_ride_application/core/provider/admin_provider.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/features/admin/widgets/admin_layout.dart';
import 'package:uni_ride_application/features/admin/widgets/admin_header.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class AdminPendingApprovalsPage extends StatefulWidget {
  const AdminPendingApprovalsPage({Key? key}) : super(key: key);

  @override
  State<AdminPendingApprovalsPage> createState() => _AdminPendingApprovalsPageState();
}

class _AdminPendingApprovalsPageState extends State<AdminPendingApprovalsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminProvider>().fetchPendingApprovals();
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return AdminLayout(
      activeRoute: '/AdminPendingApprovals',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AdminHeader(
            title: locale.pendingApprovals,
            showSearchAndFilter: false,
          ),
          Expanded(
            child: Consumer<AdminProvider>(
              builder: (context, provider, child) {
                if (provider.state == AdminState.loading && provider.pendingApprovals.isEmpty) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                }

                if (provider.state == AdminState.error && provider.pendingApprovals.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(provider.errorMessage, style: AppStyle.adminCardContactStyle),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => provider.fetchPendingApprovals(),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (provider.pendingApprovals.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check_circle_outline, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text('No pending approvals', style: AppStyle.adminCardSectionTitleStyle.copyWith(color: Colors.grey)),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
                  itemCount: provider.pendingApprovals.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final approval = provider.pendingApprovals[index];
                    return _ApprovalCard(approval: approval);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ApprovalCard extends StatelessWidget {
  final PendingApprovalModel approval;

  const _ApprovalCard({
    required this.approval,
  });

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final provider = context.read<AdminProvider>();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderadmincolor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Profile & Applied Time
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColors.adminDivider,
                    child: const Icon(Icons.person_outline, color: AppColors.adminIcon, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(approval.fullName, style: AppStyle.adminCardNameStyle),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.phone_android, size: 14, color: AppColors.adminIcon),
                          const SizedBox(width: 6),
                          Text(approval.phoneNumber, style: AppStyle.adminCardContactStyle),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(Icons.email_outlined, size: 14, color: AppColors.adminIcon),
                          const SizedBox(width: 6),
                          Text(approval.email, style: AppStyle.adminCardContactStyle),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                '${locale.applied} ${approval.appliedAt}',
                style: AppStyle.adminCardTimeStyle,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Vehicle Info Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.adminBackground,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.borderadmincolor, width: 0.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(locale.vehicleInformation, style: AppStyle.adminCardSectionTitleStyle),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(locale.vehicle, style: AppStyle.adminCardInfoLabelStyle),
                          const SizedBox(height: 4),
                          Text('${approval.vehicleType} ${approval.vehicleModel}', style: AppStyle.adminCardInfoValueStyle),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(locale.plateNumber, style: AppStyle.adminCardInfoLabelStyle),
                          const SizedBox(height: 4),
                          Text(approval.plateNumber, style: AppStyle.adminCardInfoValueStyle),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: _ActionButton(
                  icon: Icons.visibility_outlined,
                  label: locale.viewDetails,
                  onPressed: () {
                    // TODO: Implement View Details
                  },
                  color: const Color(0xFF4A5565),
                  bgColor: AppColors.adminBackground,
                  borderColor: AppColors.borderadmincolor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ActionButton(
                  icon: Icons.cancel_outlined,
                  label: locale.reject,
                  onPressed: () async {
                    final success = await provider.rejectApplication(approval.id, approval.type);
                    if (!success && context.mounted) {
                       ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text(provider.errorMessage)),
                       );
                    }
                  },
                  color: const Color(0xFFF04438),
                  bgColor: const Color(0xFFFEF3F2),
                  borderColor: const Color(0xFFFDA29B),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _ActionButton(
                  icon: Icons.check_circle_outline,
                  label: locale.approve,
                  onPressed: () async {
                    final success = await provider.approveApplication(approval.id, approval.type);
                    if (!success && context.mounted) {
                       ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(content: Text(provider.errorMessage)),
                       );
                    }
                  },
                  color: const Color(0xFF12B76A),
                  bgColor: const Color(0xFFECFDF3),
                  borderColor: const Color(0xFF6CE9A6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final Color bgColor;
  final Color borderColor;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.color,
    required this.bgColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 47,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: bgColor,
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.zero,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: AppStyle.adminCardActionButtonStyle.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
