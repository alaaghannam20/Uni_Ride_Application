import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_ride_application/core/models/admin_student_model.dart';
import 'package:uni_ride_application/core/provider/admin_provider.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/widgets/responsive.dart';
import 'package:uni_ride_application/features/admin/widgets/admin_layout.dart';
import 'package:uni_ride_application/features/admin/widgets/admin_header.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class AdminStudentsPage extends StatefulWidget {
  const AdminStudentsPage({super.key});

  @override
  State<AdminStudentsPage> createState() => _AdminStudentsPageState();
}

class _AdminStudentsPageState extends State<AdminStudentsPage> {
  String _query = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AdminProvider>().fetchStudents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale    = AppLocalizations.of(context)!;
    final isDesktop = Responsive.isDesktop(context);

    return AdminLayout(
      activeRoute: '/AdminStudents',
      child: Column(
        children: [
          AdminHeader(
            title: locale.studentManagement,
            showSearchAndFilter: true,
            searchHint: 'Search students...',
            onSearch: (val) => setState(() => _query = val.trim().toLowerCase()),
          ),
          Expanded(
            child: Consumer<AdminProvider>(
              builder: (context, provider, _) {
                if (provider.studentsState == AdminState.loading) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.orangeprimary));
                }
                if (provider.studentsState == AdminState.error) {
                  return Center(child: Text(provider.errorMessage, style: const TextStyle(color: Colors.red)));
                }

                final students = _query.isEmpty
                    ? provider.students
                    : provider.students.where((s) =>
                        s.fullName.toLowerCase().contains(_query) ||
                        s.email.toLowerCase().contains(_query),
                      ).toList();

                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: isDesktop ? 25 : 12, vertical: 25),
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
                            decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(color: AppColors.borderadmincolor)),
                            ),
                            child: Row(
                              children: [
                                Expanded(flex: 3, child: Text(locale.student.toUpperCase(),     style: AppStyle.adminCardSection(context))),
                                Expanded(flex: 3, child: Text(locale.emailAddress.toUpperCase(), style: AppStyle.adminCardSection(context))),
                                Expanded(flex: 2, child: Text(locale.totalTrips.toUpperCase(),   style: AppStyle.adminCardSection(context), textAlign: TextAlign.center)),
                                Expanded(flex: 2, child: Text(locale.joined.toUpperCase(),       style: AppStyle.adminCardSection(context), textAlign: TextAlign.center)),
                                Expanded(flex: 2, child: Text(locale.status.toUpperCase(),       style: AppStyle.adminCardSection(context), textAlign: TextAlign.center)),
                                Expanded(flex: 2, child: Text(locale.actions.toUpperCase(),      style: AppStyle.adminCardSection(context), textAlign: TextAlign.center)),
                              ],
                            ),
                          ),
                        if (students.isEmpty)
                          Padding(
                            padding: const EdgeInsets.all(32),
                            child: Center(child: Text(locale.noStudentsFound, style: const TextStyle(color: AppColors.greyHint))),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: students.length,
                            itemBuilder: (context, index) {
                              return _StudentRow(
                                student: students[index],
                                showBottomBorder: index < students.length - 1,
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

class _StudentRow extends StatelessWidget {
  final AdminStudentModel student;
  final bool showBottomBorder;

  const _StudentRow({required this.student, this.showBottomBorder = true});

  @override
  Widget build(BuildContext context) {
    final locale    = AppLocalizations.of(context)!;
    final isActive  = student.status.toLowerCase() == 'active';
    final isDesktop = Responsive.isDesktop(context);

    if (!isDesktop) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: showBottomBorder ? const Border(bottom: BorderSide(color: AppColors.adminDivider)) : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppColors.adminDivider,
                  child: Text(student.fullName.isNotEmpty ? student.fullName[0].toUpperCase() : '?',
                      style: const TextStyle(color: AppColors.adminIcon, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(student.fullName, style: AppStyle.adminCardName(context, fontSize: 16)),
                      if (student.phoneNumber.isNotEmpty)
                        Text(student.phoneNumber, style: AppStyle.adminCardContact(context)),
                    ],
                  ),
                ),
                _statusBadge(isActive, locale),
              ],
            ),
            const SizedBox(height: 12),
            _infoRow(context, locale.emailAddress, student.email),
            _infoRow(context, locale.totalTrips, '${student.totalTrips}'),
            _infoRow(context, locale.joined, student.joined),
          ],
        ),
      );
    }

    return Container(
      height: 73,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        border: showBottomBorder ? const Border(bottom: BorderSide(color: AppColors.adminDivider)) : null,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.adminDivider,
                  child: Text(student.fullName.isNotEmpty ? student.fullName[0].toUpperCase() : '?',
                      style: const TextStyle(color: AppColors.adminIcon, fontWeight: FontWeight.bold, fontSize: 14)),
                ),
                const SizedBox(width: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(student.fullName, style: AppStyle.adminCardName(context, fontSize: 14)),
                    Text(student.phoneNumber.isEmpty ? '—' : student.phoneNumber, style: AppStyle.adminCardContact(context)),
                  ],
                ),
              ],
            ),
          ),
          Expanded(flex: 3, child: Text(student.email,              style: AppStyle.adminCardValue(context))),
          Expanded(flex: 2, child: Text('${student.totalTrips}',    style: AppStyle.adminCardValue(context), textAlign: TextAlign.center)),
          Expanded(flex: 2, child: Text(student.joined,             style: AppStyle.adminCardValue(context), textAlign: TextAlign.center)),
          Expanded(flex: 2, child: Center(child: _statusBadge(isActive, locale))),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(icon: const Icon(Icons.visibility_outlined, size: 20, color: AppColors.adminIcon), onPressed: () {}),
                IconButton(icon: const Icon(Icons.more_vert,           size: 20, color: AppColors.adminIcon), onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusBadge(bool isActive, AppLocalizations locale) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? AppColors.adminSuccessBG : AppColors.adminDivider,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isActive ? locale.active : locale.inactive,
        style: TextStyle(color: isActive ? AppColors.adminSuccessText : AppColors.adminIcon, fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _infoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppStyle.adminCardSection(context).copyWith(fontSize: 12)),
          Text(value, style: AppStyle.adminCardValue(context, fontSize: 12)),
        ],
      ),
    );
  }
}
