import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';

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
        color: const Color(0xFFF1F1F1),
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
                  color: isStudDocSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Student/Doctor',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isStudDocSelected
                        ? AppColors.orangeprimary
                        : Colors.grey,
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
                  color: !isStudDocSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Driver',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: !isStudDocSelected
                        ? AppColors.orangeprimary
                        : Colors.grey,
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