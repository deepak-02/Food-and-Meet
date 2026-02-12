import 'package:flutter/material.dart';
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
  });

  final String? name;
  final String? hint;
  final IconData? icon;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final Function()? onPressed;
  final String? tooltip;


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
            decoration: InputDecoration(
              filled: true,
              fillColor: AppTheme.inputBackground, // background color
              hintText: hint,
              hintStyle: TextStyle(
                color: AppTheme.hint,
                fontSize: 16.sp,
              ),

              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 12.0.w, right: 8.0.w),
                child: Icon(
                  icon,
                  color: AppTheme.hint,
                  size: 20.sp,
                ),
              ),

              suffixIcon: IconButton(
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
