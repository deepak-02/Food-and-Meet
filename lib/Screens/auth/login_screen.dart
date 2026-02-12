import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          // 1. CHANGE THIS TO TRUE (Default)
          // This allows the layout to shrink when keyboard opens
          resizeToAvoidBottomInset: true,

          body: Stack(
            children: [
              // ------------------------------------------------
              // LAYER 1: Background Image with Dark Overlay
              // ------------------------------------------------
              Positioned.fill(
                child: Image.asset("assets/images/b1.jpg", fit: BoxFit.cover),
              ),
              Positioned.fill(
                child: Container(color: Colors.black.withValues(alpha: 0.6)),
              ),

              // ------------------------------------------------
              // LAYER 2: Scrollable Content with Layout Fix
              // ------------------------------------------------
              // 2. USE CustomScrollView instead of SingleChildScrollView
              CustomScrollView(
                slivers: [
                  // 3. SliverFillRemaining is the magic widget
                  SliverFillRemaining(
                    // hasScrollBody: false tells it "My child is not a list,
                    // it's a single block of layout."
                    hasScrollBody: false,

                    // This creates a scrollable area that fills the screen height
                    // but allows scrolling when content overflows (like keyboard open).
                    child: SafeArea(
                      child: Column(
                        children: [
                          // Now this Spacer works perfectly!
                          const Spacer(flex: 2),

                          Text(
                            "Taste. Meet.",
                            style: TextStyle(
                              color: AppTheme.text1,
                              fontSize: 42.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Arial',
                            ),
                          ),

                          ShaderMask(
                            shaderCallback: (Rect bounds) {
                              return LinearGradient(
                                colors: [Color(0xFFB9FF7F), AppTheme.accent],
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                              ).createShader(bounds);
                            },
                            blendMode: BlendMode.srcIn,
                            child: Text(
                              " Repeat.",
                              style: TextStyle(
                                color: AppTheme.text1,
                                fontSize: 42.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          SizedBox(height: 20.h),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 32.w),
                            child: Text(
                              "Login to access curated dining experiences.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppTheme.text2,
                                fontSize: 20.sp,
                                height: 1.4,
                              ),
                            ),
                          ),

                          SizedBox(height: 20.h),

                          // Login Form Container
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 24.w),
                            padding: EdgeInsets.all(14.r),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24.r),
                              color: Colors.white.withValues(alpha: 0.05),
                              border: Border.all(color: AppTheme.text4),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Phone Number",
                                  style: TextStyle(
                                    color: AppTheme.text2,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                SizedBox(height: 10.h),

                                TextField(
                                  style: TextStyle(color: AppTheme.text1),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppTheme.inputBackground,
                                    hintText: "9952543212",
                                    hintStyle: TextStyle(
                                      color: AppTheme.text1.withValues(
                                        alpha: 0.3,
                                      ),
                                    ),
                                    suffixIcon: const Icon(
                                      Icons.phone_iphone,
                                      color: AppTheme.accent,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),

                                SizedBox(height: 20.h),

                                Center(
                                  child: Text.rich(
                                    TextSpan(
                                      style: TextStyle(
                                        color: AppTheme.text1.withValues(
                                          alpha: 0.5,
                                        ),
                                        fontSize: 14.sp,
                                        height: 1.5,
                                      ),
                                      children: [
                                        const TextSpan(
                                          text:
                                              "By continuing, you agree to our ",
                                        ),
                                        TextSpan(
                                          text: "Terms of Service",
                                          style: const TextStyle(
                                            color: AppTheme.text1,
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              debugPrint("Terms clicked");
                                            },
                                        ),
                                        const TextSpan(text: "\nand "),
                                        TextSpan(
                                          text: "Privacy Policy",
                                          style: const TextStyle(
                                            color: AppTheme.text1,
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              debugPrint("Privacy clicked");
                                            },
                                        ),
                                        const TextSpan(text: "."),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                                SizedBox(height: 20.h),

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
                                        foregroundColor:
                                            AppTheme.buttonForeground,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30.r,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        debugPrint("continue clicked");
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Continue ",
                                            style: TextStyle(
                                              color: AppTheme.buttonForeground,
                                              fontSize: 20.sp,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.0.w,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: AppTheme.buttonForeground,
                                            size: 20.sp,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),

                          // Bottom Links
                          Text.rich(
                            TextSpan(
                              style: TextStyle(
                                color: AppTheme.text1.withValues(alpha: 0.5),
                                fontSize: 14.sp,
                                height: 1.5,
                              ),
                              children: [
                                const TextSpan(text: "New User?  "),
                                TextSpan(
                                  text: "Register",
                                  style: const TextStyle(
                                    color: AppTheme.text1,
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.push('/register');
                                    },
                                ),
                                const TextSpan(text: "."),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
