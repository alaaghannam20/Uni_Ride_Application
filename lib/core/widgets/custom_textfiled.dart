import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uni_ride_application/core/theme/app_colors.dart';
import 'package:uni_ride_application/core/theme/app_style.dart';

class CustomTextfiled extends StatefulWidget {
  final Color? backcgroundcolor;
  final String? labelText;
  final TextStyle? labelStyle;
  final String hintText;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool isPassword;
  final double? width;
  final double? height;
  final FormFieldValidator<String>? validator;
  final Color? iconColor;

  const CustomTextfiled({
    super.key,
    this.backcgroundcolor,
    this.labelText,
    this.labelStyle,
    required this.hintText,
    this.hintStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.keyboardType,
    this.isPassword = false,
    this.width,
    this.height,
    this.validator,
    this.iconColor,
  });

  @override
  State<CustomTextfiled> createState() => _CustomTextfiledState();
}

class _CustomTextfiledState extends State<CustomTextfiled> {
  late bool obscure;
  Timer? debounce;

  @override
  void initState() {
    super.initState();
    obscure = widget.isPassword ? true : widget.obscureText;
  }

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = widget.backcgroundcolor ?? AppColors.white;
    final Color borderColor = AppColors.bordercontainerlanguage;

    return SizedBox(
      width: widget.width ?? 303,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.labelText ?? '',
            style: widget.labelStyle ?? AppStyle.lablestyle,
          ),
          SizedBox(height: 6),
          SizedBox(
            width: widget.width ?? 303,
            height: widget.height ?? 54,
            child: TextFormField(
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              obscureText: obscure,
              validator: widget.validator,
              decoration: InputDecoration(
                filled: true,
                fillColor: backgroundColor,
                hintText: widget.hintText,
                hintStyle: widget.hintStyle ?? AppStyle.hintstyle,
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          obscure ? Icons.visibility : Icons.visibility_off,
                          color: widget.iconColor ?? AppColors.languagecolor,
                        ),
                        onPressed: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                      )
                    : widget.suffixIcon,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(width: 1, color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:
                BorderSide(width: 1, color: borderColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 2, color: AppColors.redColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(width: 2, color: AppColors.redColor),
          ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
