import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/widgets/responsive.dart';
import 'package:uni_ride_application/features/admin/widgets/admin_layout.dart';
import 'package:uni_ride_application/features/admin/widgets/admin_header.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class AdminStudentsPage extends StatelessWidget {
  const AdminStudentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final bool isDesktop = Responsive.isDesktop(context);

    final students = [
      {
        'name': 'Sara Khalil',
        'phone': '+972 59 234 5678',
        'email': 'sara.k@ptuk.edu',
        'trips': 45,
        'joined': '2 months ago',
        'status': 'active',
      },
      {
        'name': 'Ahmed Mohammed',
        'phone': '+972 59 123 4567',
        'email': 'ahmed.m@ptuk.edu',
        'trips': 67,
        'joined': '3 months ago',
        'status': 'active',
      },
    ];

    return AdminLayout(
      activeRoute: '/AdminStudents',
      child: Column(
        children: [
          AdminHeader(
            title: locale.studentManagement,
            showSearchAndFilter: true,
            searchHint: 'Search students...',
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 25 : 12,
                vertical: 25,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color:  AppColors.borderadmincolor),
                ),
                child: Column(
                  children: [
                    if (isDesktop)
                      Container(
                        height: 52,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: AppColors.borderadmincolor),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(flex: 3, child: Text(locale.student.toUpperCase(), style: AppStyle.adminCardSectionTitleStyle)),
                            Expanded(flex: 3, child: Text(locale.emailAddress.toUpperCase(), style: AppStyle.adminCardSectionTitleStyle)),
                            Expanded(flex: 2, child: Text(locale.totalTrips.toUpperCase(), style: AppStyle.adminCardSectionTitleStyle, textAlign: TextAlign.center)),
                            Expanded(flex: 2, child: Text(locale.joined.toUpperCase(), style: AppStyle.adminCardSectionTitleStyle, textAlign: TextAlign.center)),
                            Expanded(flex: 2, child: Text(locale.status.toUpperCase(), style: AppStyle.adminCardSectionTitleStyle, textAlign: TextAlign.center)),
                            Expanded(flex: 2, child: Text(locale.actions.toUpperCase(), style: AppStyle.adminCardSectionTitleStyle, textAlign: TextAlign.center)),
                          ],
                        ),
                      ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final student = students[index];
                        final isLast = index == students.length - 1;
                        return _StudentRow(
                          name: student['name'] as String,
                          phone: student['phone'] as String,
                          email: student['email'] as String,
                          trips: student['trips'] as int,
                          joined: student['joined'] as String,
                          status: student['status'] as String,
                          showBottomBorder: !isLast,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StudentRow extends StatelessWidget {
  final String name;
  final String phone;
  final String email;
  final int trips;
  final String joined;
  final String status;
  final bool showBottomBorder;

  const _StudentRow({
    required this.name,
    required this.phone,
    required this.email,
    required this.trips,
    required this.joined,
    required this.status,
    this.showBottomBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    final isActive = status == 'active';
    final bool isDesktop = Responsive.isDesktop(context);

    if (!isDesktop) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: showBottomBorder
              ? const Border(bottom: BorderSide(color: AppColors.adminDivider))
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor:  AppColors.adminDivider,
                  child: const Icon(Icons.person_outline, size: 22, color:  AppColors.adminIcon),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: AppStyle.adminCardNameStyle.copyWith(fontSize: 16)),
                      Text(phone, style: AppStyle.adminCardContactStyle),
                    ],
                  ),
                ),
                _buildStatusBadge(isActive, locale),
              ],
            ),
            const SizedBox(height: 12),
            _buildInfoRow(locale.emailAddress, email),
            _buildInfoRow(locale.totalTrips, trips.toString()),
            _buildInfoRow(locale.joined, joined),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.visibility_outlined, size: 18),
                  label: Text(locale.viewDetails ?? "View"),
                  style: TextButton.styleFrom(foregroundColor: AppColors.adminIcon),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.more_vert, size: 20, color: AppColors.adminIcon),
                  onPressed: () {},
                ),
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
            ? const Border(bottom: BorderSide(color: AppColors.adminDivider))
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
                  backgroundColor:  AppColors.adminDivider,
                  child: const Icon(Icons.person_outline, size: 20, color:  AppColors.adminIcon),
                ),
                const SizedBox(width: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: AppStyle.adminCardNameStyle.copyWith(fontSize: 14)),
                    Text(phone, style: AppStyle.adminCardContactStyle),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(email, style: AppStyle.adminCardInfoValueStyle.copyWith(fontWeight: FontWeight.w400)),
          ),
          Expanded(
            flex: 2,
            child: Text(trips.toString(), style: AppStyle.adminCardInfoValueStyle, textAlign: TextAlign.center),
          ),
          Expanded(
            flex: 2,
            child: Text(joined, style: AppStyle.adminCardInfoValueStyle.copyWith(fontWeight: FontWeight.w400), textAlign: TextAlign.center),
          ),
          Expanded(
            flex: 2,
            child: Center(child: _buildStatusBadge(isActive, locale)),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.visibility_outlined, size: 20, color: AppColors.adminIcon),
                  onPressed: () {},
                ),
                const SizedBox(width: 4),
                IconButton(
                  icon: const Icon(Icons.more_vert, size: 20, color: AppColors.adminIcon),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(bool isActive, AppLocalizations locale) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ?  AppColors.adminSuccessBG :  AppColors.adminDivider,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isActive ? locale.active : locale.inactive,
        style: TextStyle(
          color: isActive ?  AppColors.adminSuccessText :  AppColors.adminIcon,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppStyle.adminCardSectionTitleStyle.copyWith(fontSize: 12)),
          Text(value, style: AppStyle.adminCardInfoValueStyle.copyWith(fontSize: 12, fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}
