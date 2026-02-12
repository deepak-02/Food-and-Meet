import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/gestures.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/preview_field.dart';

class RegistrationScreen4 extends StatefulWidget {
  const RegistrationScreen4({super.key, required this.name, required this.phone, required this.dob, required this.address, required this.bio, required this.selectedInterests, required this.images, required this.allInterests, required this.termsAccepted, required this.onTermsChanged});


  final String name;
  final String phone;
  final String dob;
  final String address;
  final String bio;
  final Set<String> selectedInterests;
  final List<File?> images;
  final List<Map<String, dynamic>> allInterests;

  final bool termsAccepted;
  final ValueChanged<bool> onTermsChanged;
  @override
  State<RegistrationScreen4> createState() => _RegistrationScreen4State();
}

class _RegistrationScreen4State extends State<RegistrationScreen4> {


  int calculateAge(String dobString) {
    try {
      // 1. Clean the string: " 12 / 05 / 2000 " -> "12/05/2000"
      String cleanDate = dobString.replaceAll(' ', '');

      // 2. Split into [Day, Month, Year]
      List<String> parts = cleanDate.split('/');
      if (parts.length != 3) return 0;

      int day = int.parse(parts[0]);
      int month = int.parse(parts[1]);
      int year = int.parse(parts[2]);

      DateTime dob = DateTime(year, month, day);
      DateTime today = DateTime.now();

      // 3. Basic calculation
      int age = today.year - dob.year;

      // 4. Adjust if birthday hasn't happened yet this year
      if (today.month < dob.month || (today.month == dob.month && today.day < dob.day)) {
        age--;
      }

      return age;
    } catch (e) {
      // Fallback if date is empty or invalid
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
// Helper to get icon for a selected interest string
    IconData getIconForLabel(String label) {
      final interest = widget.allInterests.firstWhere(
            (element) => element['label'] == label,
        orElse: () => {'icon': Icons.star}, // Default fallback
      );
      return interest['icon'];
    }

    // Prepare images for display (ensure we don't crash if null)
    File? mainImage = widget.images.isNotEmpty ? widget.images[0] : null;
    List<File?> sideImages = widget.images.length > 1 ? widget.images.sublist(1) : [];

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Top Text
            Text(
              "Profile Overview",
              style: TextStyle(
                color: AppTheme.text1,
                fontSize: 34.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5.w,
              ),
            ),
            Text(
              "One last look before you join the table.",
              style: TextStyle(
                color: AppTheme.text2,
                fontSize: 16.sp,
                height: 1.5,
              ),
            ),
            SizedBox(height: 20.h),


            // 2. Profile images section
            ClipRRect(
              borderRadius: BorderRadius.circular(24.r), // The outer rounded corners
              child: Container(
                height: 250.h,
                color: AppTheme.text1, // Color of the grid lines (gaps)
                child: Row(
                  children: [
                    // ---------------------------------------------
                    // LEFT SIDE: The Main Large Profile Image (Flex 2)
                    // ---------------------------------------------
                    Expanded(
                      flex: 2,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // 1. The Main Image
                          mainImage != null
                              ? Image.file(mainImage, fit: BoxFit.cover)
                              : Container(
                            width: double.infinity,
                            color: Colors.grey[300], // Grey background
                            child: Center(
                              child: Icon(
                                Icons.image, // The generic image icon
                                color: Colors.grey[600],
                                size: 24.sp,
                              ),
                            ),
                          ),

                          // 2. The Gradient Overlay (Optional, makes text readable)
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 80.h,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.transparent, Colors.black.withValues(alpha: 0.4)],
                                ),
                              ),
                            ),
                          ),

                          // 3. The Badges (Verified & Age)
                          Positioned(
                            bottom: 12.h,
                            left: 12.w,
                            child: Row(
                              children: [
                                // Verified Badge
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: AppTheme.accent.withValues(alpha: 0.3),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.verified, color: AppTheme.accent, size: 14.sp),
                                      SizedBox(width: 4.w),
                                      Text(
                                        "Verified",
                                        style: TextStyle(
                                          color: AppTheme.text1,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(width: 8.w),

                                // Age Badge
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.6), // Semi-transparent black
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Text(
                                    "${calculateAge(widget.dob)} y/o",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // The gap between Left and Right columns
                    SizedBox(width: 2.w),

                    // ---------------------------------------------
                    // RIGHT SIDE: The Column of 3 Small Images (Flex 1)
                    // ---------------------------------------------
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          // Top Right
                          Expanded(
                            child: sideImages.isNotEmpty && sideImages[0] != null
                                ? Image.file(sideImages[0]!, fit: BoxFit.cover, width: double.infinity)
                                : Container(
                              width: double.infinity,
                              color: Colors.grey[300], // Grey background
                              child: Center(
                                child: Icon(
                                  Icons.image, // The generic image icon
                                  color: Colors.grey[600],
                                  size: 24.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h),

                          // Middle Right
                          Expanded(
                            child: sideImages.length > 1 && sideImages[1] != null
                                ? Image.file(sideImages[1]!, fit: BoxFit.cover, width: double.infinity)
                                : Container(
                              width: double.infinity,
                              color: Colors.grey[300], // Grey background
                              child: Center(
                                child: Icon(
                                  Icons.image, // The generic image icon
                                  color: Colors.grey[600],
                                  size: 24.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h),

                          // Bottom Right (Placeholder or 3rd side image)
                          Expanded(
                            child: sideImages.length > 2 && sideImages[2] != null
                                ? Image.file(sideImages[2]!, fit: BoxFit.cover, width: double.infinity)
                                : Container(
                              width: double.infinity,
                              color: Colors.grey[300], // Grey background
                              child: Center(
                                child: Icon(
                                  Icons.image, // The generic image icon
                                  color: Colors.grey[600],
                                  size: 24.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10.h),

            // 3. Details Section
            Text(
              widget.name.isNotEmpty ? widget.name : "Your Name",
              style: TextStyle(
                color: AppTheme.text1,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5.w,
              ),
            ),
            Text(
              widget.bio.isNotEmpty ? widget.bio : "No bio provided yet...",
              style: TextStyle(
                color: AppTheme.text2,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                // letterSpacing: 0.5.w,
              ),
            ),
            SizedBox(height: 20.h),

            Text(
              "Cravings & Interests",
              style: TextStyle(
                color: AppTheme.text1,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: widget.selectedInterests.map((label) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: AppTheme.inputBackground,
                    border: Border.all(color: AppTheme.accent, width: 1.w),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        getIconForLabel(label),
                        color: AppTheme.accent,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        label,
                        style: TextStyle(
                          color: AppTheme.accent,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 20.h),

            Row(
              children: [
                Icon(
                  Icons.lock,
                  color: AppTheme.text1,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  "Private details",
                  style: TextStyle(
                    color: AppTheme.text1,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              // height: 500.h,
              padding: EdgeInsets.all(24.w),

              decoration: BoxDecoration(
                color: Color(0xBB2C2C2E),
                borderRadius: BorderRadius.circular(20.r),

              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PreviewDetailField(
                    name: "Phone Number",
                    value: widget.phone,
                    icon: Icons.phone,
                  ),
                  // SizedBox(height: 10.h),
                  // PreviewDetailField(
                  //   name: "Aadhaar",
                  //   value: "xxxx xxxx 4664",
                  //   icon: Icons.credit_card_rounded,
                  // ),
                  SizedBox(height: 10.h),
                  PreviewDetailField(
                    name: "DOB",
                    value: widget.dob,
                    icon: Icons.calendar_month,
                  ),

                  SizedBox(height: 10.h),
                  PreviewDetailField(
                    name: "Address",
                    value: widget.address,
                    icon: Icons.home,
                  ),
                  SizedBox(height: 10.h),
                ]
            ),
            ),

            SizedBox(height: 20.h),

            // 4. Terms & Conditions
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    // Use widget.onTermsChanged to call the parent
                    widget.onTermsChanged(!widget.termsAccepted);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 24.w,
                    height: 24.w,
                    decoration: BoxDecoration(
                      // Use widget.termsAccepted
                      color: widget.termsAccepted
                          ? AppTheme.accent
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        // Use widget.termsAccepted
                        color: widget.termsAccepted
                            ? AppTheme.accent
                            : AppTheme.text2,
                        width: 2,
                      ),
                    ),
                    child: widget.termsAccepted
                        ? Icon(Icons.check, color: AppTheme.text1, size: 16.sp)
                        : null,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                          color: AppTheme.text2,
                          fontSize: 14.sp,
                          height: 1.5),
                      children: [
                        const TextSpan(text: "I agree to the "),
                        TextSpan(
                          text: "Terms of Service",
                          style: TextStyle(
                            color: AppTheme.accent,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationColor: AppTheme.accent,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              debugPrint("Terms of Service Clicked");
                            },
                        ),
                        const TextSpan(text: " and "),
                        TextSpan(
                          text: "Community Safety Guidelines",
                          style: TextStyle(
                            color: AppTheme.accent,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationColor: AppTheme.accent,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              debugPrint("Guidelines Clicked");
                            },
                        ),
                        const TextSpan(text: "."),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h,)

          ],
        ),
      ),
    );
  }
}

