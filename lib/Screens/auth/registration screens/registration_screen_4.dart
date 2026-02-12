import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/gestures.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/preview_field.dart';

class RegistrationScreen4 extends StatefulWidget {
  const RegistrationScreen4({super.key});

  @override
  State<RegistrationScreen4> createState() => _RegistrationScreen4State();
}

class _RegistrationScreen4State extends State<RegistrationScreen4> {

  final List<Map<String, dynamic>> options = [
    {'label': 'Mandi', 'icon': Icons.rice_bowl},
    {'label': 'Biryani', 'icon': Icons.dinner_dining},
    {'label': 'Coffee', 'icon': Icons.coffee_rounded},
    {'label': 'Pizza', 'icon': Icons.local_pizza},
    {'label': 'Meals', 'icon': Icons.bento},
  ];

  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {


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
                          Image.network(
                            'https://img.freepik.com/free-vector/smiling-young-man-illustration_1308-174669.jpg',
                            fit: BoxFit.cover,
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
                                    "28 y/o",
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
                          // Top Right Image (Ramen)
                          Expanded(
                            child: Image.network(
                              'https://img.freepik.com/free-photo/delicious-japanese-ramen-noodle-soup_1150-16164.jpg',
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),

                          SizedBox(height: 2.h), // Gap

                          // Middle Right Image (Interior)
                          Expanded(
                            child: Image.network(
                              'https://img.freepik.com/free-photo/restaurant-interior_1127-3394.jpg',
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),

                          SizedBox(height: 2.h), // Gap

                          // Bottom Right (Placeholder / "More" images)
                          Expanded(
                            child: Container(
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
              "Name",
              style: TextStyle(
                color: AppTheme.text1,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5.w,
              ),
            ),
            Text(
              "I'm a ramen enthusiast looking for spicy adventures and hidden gems in the city. Always down for a late- night food run! 🍝🌶️",
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
              spacing: 12.w, // Horizontal gap between chips
              runSpacing: 12.h, // Vertical gap between lines
              children: options.map((option) {
                final String label = option['label'];
                final IconData icon = option['icon'];

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    // Dynamic Color: Bright Green if selected, Light Grey if not
                    color: AppTheme.inputBackground,
                    border: Border.all(color: AppTheme.accent, width: 1.w),
                    borderRadius: BorderRadius.circular(30.r), // Pill shape
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Shrink to fit content
                    children: [
                      // Main Icon
                      Icon(
                        icon,
                        color: AppTheme.accent,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),

                      // Label Text
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
                    value: "9087654321",
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
                    value: "28/08/2002",
                    icon: Icons.calendar_month,
                  ),

                  SizedBox(height: 10.h),
                  PreviewDetailField(
                    name: "Address",
                    value: "H. No-162, Hari Nagar Society Dabholi Road, Near Govind Ji Hall Katargam, Surat, Gujarat",
                    icon: Icons.home,
                  ),
                  SizedBox(height: 10.h),
                ]
            ),
            ),

            SizedBox(height: 20.h),

            // 4. Terms & Conditions
            Row(
              crossAxisAlignment: CrossAxisAlignment.start, // Align to top in case text wraps
              children: [
                // 1. Custom Rounded Checkbox
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isChecked = !_isChecked;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 24.w,
                    height: 24.w,
                    decoration: BoxDecoration(
                      // Green if checked, Transparent if not
                      color: _isChecked ? AppTheme.accent : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        // Green border if checked, Grey border if not
                        color: _isChecked ? AppTheme.accent : AppTheme.text2,
                        width: 2,
                      ),
                    ),
                    child: _isChecked
                        ? Icon(Icons.check, color: AppTheme.text1, size: 16.sp)
                        : null,
                  ),
                ),

                SizedBox(width: 12.w), // Gap between checkbox and text

                // 2. Rich Text with Clickable Links
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      // Default Text Style (Grey)
                      style: TextStyle(
                        color: AppTheme.text2, // Cool Grey
                        fontSize: 14.sp,
                        height: 1.5, // Line height for better readability
                        fontFamily: 'Inter', // Or your app's default font
                      ),
                      children: [
                        const TextSpan(text: "I agree to the "),

                        // Link 1: Terms of Service
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
                              // Navigate to Terms page here
                            },
                        ),

                        const TextSpan(text: " and "),

                        // Link 2: Community Safety Guidelines
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
                              // Navigate to Guidelines page here
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

