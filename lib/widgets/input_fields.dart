import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    this.name,
    this.hint,
    this.icon,
    this.controller,
  });

  final String? name;
  final String? hint;
  final IconData? icon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name ?? "",
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.8),
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 5.h),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r)),
          child: TextField(
            controller: controller,
            style: TextStyle(
              color: Colors.white, // Color of the text user types
              fontSize: 16.sp,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xBB2C2C2E), // background color
              hintText: hint,
              hintStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 16.sp,
              ),

              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 12.0.w, right: 8.0.w),
                child: Icon(
                  icon,
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
}
