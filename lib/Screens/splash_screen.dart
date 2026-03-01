import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppTheme.scaffoldBackgroundColor,

        body: Stack(
          children: [
            // background
            _LightingBackground(),

            SafeArea(
              child: Column(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(right: 16, bottom: 16),
                  //       child: Text(
                  //         "Skip",
                  //           style: TextStyle(
                  //               color: Colors.grey,
                  //             fontSize: 16,
                  //             fontWeight: FontWeight.w600
                  //           )
                  //       ),
                  //     )
                  //   ],
                  // ),
                  SizedBox(height: 20.h),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 24.w),
                    padding: EdgeInsets.all(14.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                      color: AppTheme.text1.withValues(alpha: 0.05),
                      border: Border.all(color: AppTheme.text4),
                    ),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            16.r,
                          ), // image radius
                          child: Image.asset(
                            "assets/images/ramen.png",
                            fit: BoxFit.cover,
                            height: 260.h,
                          ),
                        ),

                        SizedBox(height: 20.h),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            color: Colors.white.withValues(alpha: 0.05),
                            border: Border.all(color: AppTheme.text4),
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(6.r),
                                child: Icon(
                                  Icons.verified_user,
                                  color: AppTheme.accent,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(6.r),
                                child: Text(
                                  "VERIFIED COMMUNITY",
                                  style: TextStyle(
                                    color: AppTheme.text1.withValues(
                                      alpha: 0.7,
                                    ),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  Text(
                    "Taste. Meet.",
                    style: TextStyle(
                      color: AppTheme.text1,
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Arial', // Use a clean sans-serif font
                    ),
                  ),

                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        // Approximate colors from your image (Gold to Orange)
                        colors: [
                          AppTheme.secondary, // Light
                          AppTheme.accent, // Dark
                        ],
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                      ).createShader(bounds);
                    },
                    // This blend mode applies the shader ONLY to the text pixels
                    blendMode: BlendMode.srcIn,
                    child: Text(
                      "Repeat.",
                      style: TextStyle(
                        // The color here acts as a base; white is standard for masking
                        color: AppTheme.text1,
                        fontSize: 40.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Text(
                      "Discover curated dining experiences with verified foodies near you.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.text2,
                        fontSize: 18.sp,
                        height: 1.4,
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  Spacer(),

                  Padding(
                    padding: EdgeInsets.only(
                      left: 24.w,
                      right: 24.w,
                      top: 10.h,
                      bottom: 24.h,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.accent,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                        onPressed: () {
                          context.push('/register');
                        },
                        child: Text(
                          "GET STARTED",
                          style: TextStyle(
                            color: Colors.black, // White text
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0.sp,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 24.w, right: 24.w),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56.h,
                      child: OutlinedButton(
                        onPressed: () {
                          // context.push('/login');
                          context.push('/home');
                        },
                        style: OutlinedButton.styleFrom(
                          // Transparent background
                          backgroundColor: Colors.transparent,
                          // White border to pop against dark background
                          side: BorderSide(color: AppTheme.accent, width: 2.w),
                          shape: const StadiumBorder(),
                        ),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                            color: AppTheme.accent, // White text
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0.sp,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LightingBackground extends StatelessWidget {
  const _LightingBackground();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          // Top glow
          Positioned(
            top: -120.h,
            left: -80.w,
            child: _glow(size: 320.w),
          ),

          // Center glow
          Positioned(
            top: 200.h,
            right: -100.w,
            child: _glow(size: 260.w),
          ),

          // Bottom glow
          Positioned(
            bottom: -140.h,
            left: 60.w,
            child: _glow(size: 300.w),
          ),
        ],
      ),
    );
  }

  Widget _glow({required double size}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppTheme.accent.withValues(alpha: 0.35),
            AppTheme.accent.withValues(alpha: 0.0),
          ],
        ),
      ),
    );
  }
}
