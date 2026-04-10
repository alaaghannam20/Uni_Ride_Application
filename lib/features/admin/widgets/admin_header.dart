import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';
import 'package:uni_ride_application/core/widgets/responsive.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';

class AdminHeader extends StatelessWidget {
  final String title;
  final bool showSearchAndFilter;
  final String searchHint;
  final double? height;
  final Function(String)? onSearch;
  final VoidCallback? onFilterTap;

  const AdminHeader({
    super.key,
    required this.title,
    this.showSearchAndFilter = false,
    this.searchHint = 'Search...',
    this.height,
    this.onSearch,
    this.onFilterTap,
  }) ;

  @override
  Widget build(BuildContext context) {
    String currentDate = DateFormat('EEEE, MMMM d, yyyy').format(DateTime.now());
    final bool isDesktop = Responsive.isDesktop(context);

    return Container(
      height: height ?? (showSearchAndFilter ? (isDesktop ? 187 : 210) : (isDesktop ? 140 : 120)),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.borderadmincolor, width: 1),
        ),
      ),
      padding: EdgeInsets.only(
        top: isDesktop ? 24 : 16,
        right: isDesktop ? 32 : 16,
        left: isDesktop ? 32 : 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (!isDesktop) ...[
                IconButton(
                  icon: const Icon(Icons.menu, color: AppColors.adminTextSecondary),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: AppStyle.adminHeaderTitleStyle.copyWith(
                        fontSize: isDesktop ? 28 : 22,
                      ),
                    ),
                    Text(
                      currentDate,
                      style: AppStyle.adminHeaderDateStyle.copyWith(
                        fontSize: isDesktop ? 14 : 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (showSearchAndFilter) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: isDesktop ? 537.46 : double.infinity),
                    child: Container(
                      height: 47,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.borderadmincolor),
                      ),
                      child: TextField(
                        onChanged: onSearch,
                        style: AppStyle.adminSearchInputStyle,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.searchHint,
                          hintStyle: AppStyle.adminSearchHintStyle,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: AppColors.adminSearchHint,
                            size: 20,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                InkWell(
                  onTap: onFilterTap,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 47,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color:  AppColors.adminBackground,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color:  AppColors.borderadmincolor, width: 1),
                    ),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.filter_list_rounded,
                          size: 20,
                          color: AppColors.adminTextSecondary,
                        ),
                        if (isDesktop) ...[
                          const SizedBox(width: 8),
                          Text(
                            AppLocalizations.of(context)!.filter,
                            style: AppStyle.adminFilterTextStyle,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ]
        ],
      ),
    );
  }
}
