import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/photo_upload_grid.dart';

class RegistrationScreen2 extends StatelessWidget {
  const RegistrationScreen2({super.key, required this.images});

  final List<File?> images;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                // 1. Default Style for the whole block (Grey & Small)
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 12.sp,
                  height: 1.5, // Adds line spacing for better readability
                ),
                children: [
                  TextSpan(
                    text: "Verify Your",
                    style: TextStyle(
                      color: AppTheme.text1,
                      fontSize: 34.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5.w,
                    ),
                  ),

                  TextSpan(
                    text: "\nIdentity",
                    style: TextStyle(
                      color: AppTheme.accent,
                      fontSize: 34.sp,
                      fontWeight: FontWeight.bold,
                      // letterSpacing: 0.5.w,
                    ),
                  ),
                  TextSpan(
                    text: ".",
                    style: TextStyle(
                      color: AppTheme.accent,
                      fontSize: 34.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 10.h),
            Text(
              "We value authenticity. Upload photos to help your dining companions recognize you.",
              style: TextStyle(
                color: AppTheme.text2,
                fontSize: 18.sp,
                height: 1.5,
              ),
            ),

            SizedBox(height: 20.h),

            ImageUploadGrid(images: images),
          ],
        ),
      ),
    );
  }
}
