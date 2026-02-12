import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_theme.dart'; // Ensure correct path

class GenderDropdown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;
  final String? errorText;

  const GenderDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          "Gender",
          style: TextStyle(
            color: AppTheme.text1.withValues(alpha: 0.8),
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 5.h),

        // Dropdown Field
        // No Container needed here as InputDecorator handles the box styling
        DropdownButtonFormField<String>(
          initialValue: value,
          onChanged: onChanged,
          style: TextStyle(
            color: AppTheme.text1,
            fontSize: 16.sp,
            fontFamily: 'Inter', // Ensure font matches InputField
          ),
          dropdownColor: AppTheme.inputBackground, // Popup menu background
          icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppTheme.hint),

          // Dropdown Items
          items: ["Male", "Female", "Other"]
              .map(
                (gender) =>
                    DropdownMenuItem(value: gender, child: Text(gender)),
              )
              .toList(),

          // Styling (Exact match to your InputField)
          decoration: InputDecoration(
            filled: true,
            fillColor: AppTheme.inputBackground,
            hintText: "Select Gender",
            hintStyle: TextStyle(color: AppTheme.hint, fontSize: 16.sp),

            // Error Logic
            errorText: errorText,
            errorMaxLines: 1,
            errorStyle: TextStyle(color: AppTheme.errorColor, fontSize: 12.sp),

            // Icon Logic
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 12.0.w, right: 8.0.w),
              child: Icon(
                Icons.wc, // Gender Icon
                color: errorText != null ? AppTheme.errorColor : AppTheme.hint,
                size: 20.sp,
              ),
            ),

            // Borders (Copied from your InputField)
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(color: AppTheme.accent, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(color: AppTheme.errorColor, width: 1.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.r),
              borderSide: BorderSide(color: AppTheme.errorColor, width: 2.0),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 12.w,
            ),
          ),
        ),
      ],
    );
  }
}
