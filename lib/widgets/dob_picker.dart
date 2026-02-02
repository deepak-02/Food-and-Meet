import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DateOfBirthField extends StatelessWidget {
  final TextEditingController controller;

  const DateOfBirthField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Label
        Text(
          "Date of Birth",
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 5.h),

        // 2. The Input Field
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
          child: TextField(
            controller: controller,
            // PREVENT KEYBOARD: This makes it act like a button
            readOnly: true,
            onTap: () => _selectDate(context),
            style: TextStyle(color: Colors.white, fontSize: 16.sp),
            decoration: InputDecoration(
              filled: true,
              // Match your existing semi-transparent background
              fillColor: const Color(0xBB2C2C2E),
              hintText: "DD / MM / YYYY",
              hintStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 16.sp,
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 12.0.w, right: 8.0.w),
                child: Icon(
                  Icons.calendar_today_rounded, // Calendar Icon
                  color: Colors.white.withValues(alpha: 0.4),
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),

      // ---------------------------------------------------------
      // CUSTOMIZING THE TRANSPARENCY & THEME HERE
      // ---------------------------------------------------------
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: const Color(0xFF00E676), // Your Green Accent Color
              onPrimary: Colors.black, // Text color on the accent
              surface: const Color(
                0xFF1C1C1E,
              ).withValues(alpha: 0.9), // Background with transparency
              onSurface: Colors.white, // Text color
            ), // Ensures rounded corners work
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF00E676), // Button text color
              ),
            ),
            dialogTheme: DialogThemeData(backgroundColor: Colors.transparent),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // Format the date as DD/MM/YYYY
      // You can use the 'intl' package for better formatting if you have it
      String formattedDate =
          "${picked.day.toString().padLeft(2, '0')} / ${picked.month.toString().padLeft(2, '0')} / ${picked.year}";
      controller.text = formattedDate;
    }
  }
}
