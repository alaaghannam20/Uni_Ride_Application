import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_theme_colors.dart';
import 'package:uni_ride_application/l10n/app_localizations.dart';


class RoleToggleWidget extends StatelessWidget {
  final bool isStudDocSelected;
  final VoidCallback onStudentTap;
  final VoidCallback onDriverTap;

  const RoleToggleWidget({
    super.key,
    required this.isStudDocSelected,
    required this.onStudentTap,
    required this.onDriverTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: context.bgSubtle,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onStudentTap,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: isStudDocSelected ? AppColors.orangeprimary : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.universityMember,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isStudDocSelected
                        ? Colors.white
                        : context.textSecondary,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: GestureDetector(
              onTap: onDriverTap,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: !isStudDocSelected ? AppColors.orangeprimary : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.driver,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: !isStudDocSelected
                        ? Colors.white
                        : context.textSecondary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}