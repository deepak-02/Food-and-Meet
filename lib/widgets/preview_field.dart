import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_theme.dart';

class PreviewDetailField extends StatelessWidget {
  const PreviewDetailField({super.key, this.name, this.value, this.icon});

  final String? name;
  final String? value;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppTheme.text1, size: 20.sp),
        SizedBox(width: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              name ?? "",
              style: TextStyle(
                color: AppTheme.text1,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5.w,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.64,
              child: Text(
                value ?? "",
                style: TextStyle(
                  color: AppTheme.text2,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
