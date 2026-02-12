import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/photo_upload_grid.dart';

class RegistrationScreen2 extends StatelessWidget {
  const RegistrationScreen2({super.key, required this.images, required this.imageError});

  final List<File?> images;
  final ValueNotifier<String?> imageError;
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

            ValueListenableBuilder<String?>(
              valueListenable: imageError,
              builder: (context, error, child) {
                // If no error, return empty space
                if (error == null) return const SizedBox.shrink();

                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 20.h),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: AppTheme.errorColor.withValues(alpha: 0.1), // Light red background
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppTheme.errorColor, width: 1),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: AppTheme.errorColor, size: 20.sp),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          error,
                          style: TextStyle(
                            color: AppTheme.errorColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            ImageUploadGrid(images: images),
          ],
        ),
      ),
    );
  }
}
