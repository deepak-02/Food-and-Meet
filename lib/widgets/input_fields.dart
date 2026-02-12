import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_theme.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    this.name,
    this.hint,
    this.icon,
    this.suffixIcon,
    this.controller,
    this.onPressed,
    this.tooltip,
    this.inputFormatters,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization,
    this.maxLength,
    this.errorText,
  });

  final String? name;
  final String? hint;
  final IconData? icon;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final Function()? onPressed;
  final String? tooltip;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final int? maxLength;
  final String? errorText;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name ?? "",
          style: TextStyle(
            color: AppTheme.text1.withValues(alpha: 0.8),
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 5.h),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
          child: TextField(
            controller: controller,
            style: TextStyle(
              color: AppTheme.text1, // Color of the text user types
              fontSize: 16.sp,
            ),

            inputFormatters: inputFormatters,
            keyboardType: keyboardType ?? TextInputType.text,
            textInputAction: textInputAction ?? TextInputAction.done,
            textCapitalization: textCapitalization ?? TextCapitalization.sentences,
            maxLength: maxLength,

            decoration: InputDecoration(
              filled: true,
              fillColor: AppTheme.inputBackground, // background color
              hintText: hint,
              hintStyle: TextStyle(
                color: AppTheme.hint,
                fontSize: 16.sp,
              ),
              counterText: "",

              errorText: errorText,
              errorMaxLines: 2,
              errorStyle: TextStyle(
                color: AppTheme.errorColor,
                fontSize: 12.sp,
              ),

              // Border when there is NO error and NO focus
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide.none, // No border by default
              ),

              // Border when focused (Standard)
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(
                  color: AppTheme.accent, // Or your primary color
                  width: 1.5,
                ),
              ),

              // Border when there IS an error (Red Border)
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(
                  color: AppTheme.errorColor,
                  width: 1.0,
                ),
              ),

              // Border when there IS an error AND the user clicks it
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(
                  color: AppTheme.errorColor,
                  width: 2.0,
                ),
              ),

              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 12.0.w, right: 8.0.w),
                child: Icon(
                  icon,
                  color: errorText != null ? AppTheme.errorColor : AppTheme.hint,
                  size: 20.sp,
                ),
              ),

              suffixIcon: suffixIcon == null ? null : IconButton(
                onPressed: onPressed,
                tooltip: tooltip,
                icon: Icon(
                  suffixIcon,
                  color: AppTheme.accent,
                  size: 20.sp,
                ),
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 16.h),
            ),
          ),
        ),
      ],
    );
  }
}
