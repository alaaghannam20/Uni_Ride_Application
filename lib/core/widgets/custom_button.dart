import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final Color textColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.onPressed,
    required this.textColor,
    this.width,
    this.height,
    this.padding,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 303,
      height: height ?? 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        child: Text(text, style: textStyle ?? AppStyle.custombuttonstyle),
      ),
    );
  }
}
