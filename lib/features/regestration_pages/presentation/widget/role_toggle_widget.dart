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
      width: 303,
      height: 60,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.bordercontainerlanguage,
        borderRadius: BorderRadius.circular(20),
          boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000), 
            offset: Offset(0, 1), 
            blurRadius: 3, 
          ),
          BoxShadow(
            color: Color(0x1A000000), 
            offset: Offset(0, 1), 
            blurRadius: 2, 
            spreadRadius: -1, 
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
       children: [
          _RoleButton(
            text: 'Student/Doctor',
            isSelected: isStudDocSelected,
            onTap: onStudentTap,
          ),
          _RoleButton(
            text: 'Driver',
            isSelected: !isStudDocSelected,
            onTap: onDriverTap,
          ),
        ],
      ),
    );
  }
}

class _RoleButton extends StatelessWidget {
  final String text; 
  final bool isSelected; 
  final VoidCallback onTap; 

  const _RoleButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, 
      child: Container(
        width: 143.5, 
        height: 44, 
        padding: const EdgeInsets.only(
          top: 14, 
          right: 16, 
          bottom: 14,
          left: 16, 
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.white 
              : AppColors.bordercontainerlanguage, 
          borderRadius: BorderRadius.circular(12), 
          border: Border.all(
            width: 1, 
            color: isSelected
                ? const Color(0x80E0E0E0) 
                : Colors.transparent, 
          ),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center, 
            style: TextStyle(
              fontFamily: 'Inter', 
              fontWeight: FontWeight.w700, 
              fontSize: 12, 
              height: 16 / 12, 
              letterSpacing: 0, 
              color: isSelected
                  ? AppColors.orangeprimary 
                  : AppColors.languagecolor, 
            ),
          ),
        ),
      ),
    );
  }
}