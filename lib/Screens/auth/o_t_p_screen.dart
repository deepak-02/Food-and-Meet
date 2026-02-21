import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_auth/smart_auth.dart';

import '../../theme/app_theme.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key, required this.phoneNumber});

  final String phoneNumber;
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  final TextEditingController _otpController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  // Timer variables
  int _secondsRemaining = 45;
  Timer? _timer;
  final SmartAuth _smartAuth = SmartAuth.instance;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _listenForOtp();
    // Auto-focus the OTP field when the screen opens
    _focusNode.requestFocus();
  }

  void _listenForOtp() async {
    try {
      final res = await _smartAuth.getSmsWithUserConsentApi();
      if (res.hasData) {
        final code = res.requireData.code;
        if (code != null) {
          _otpController.text = code;
        }
      }
    } catch (e) {
      debugPrint("SMS Autofill Error: $e");
    }
  }
  void _startTimer() {
    _secondsRemaining = 45;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _smartAuth.removeUserConsentApiListener();
    _timer?.cancel();
    _otpController.dispose();
    _focusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final defaultPinTheme = PinTheme(
      width: 60.w,
      height: 70.h,
      textStyle: TextStyle(
        fontSize: 28.sp,
        color: AppTheme.text1,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        color: AppTheme.inputBackground, // Uses your dark theme background
        borderRadius: BorderRadius.circular(16.r),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppTheme.accent, width: 2.w),
      boxShadow: [
        BoxShadow(
          color: AppTheme.accent.withValues(alpha: 0.2), // The outer glow
          blurRadius: 15.r,
          spreadRadius: 2.r,
        ),
      ],
    );

    final submittedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppTheme.text4.withValues(alpha: 0.5), width: 1.w),
    );

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
              // Positioned.fill(
              //   child: Image.asset("assets/images/b1.jpg", fit: BoxFit.cover),
              // ),
              // Positioned.fill(
              //   child: Container(color: Colors.black.withValues(alpha: 0.6)),
              // ),
              _LightingBackground(),

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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                tooltip: 'Back',
                                onPressed: () => Navigator.pop(context),
                                icon: Icon(Icons.arrow_back, color: AppTheme.text1),
                              ),

                            ],
                          ),
                          const Spacer(flex: 2),

                          Container(
                            // Using .w for both width and height ensures a perfect circle
                            width: 80.w,
                            height: 80.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // A very dark green/black for the inner circle background
                              color: const Color(0xFF081A0D),
                              boxShadow: [
                                // 1. The main diffused outer glow
                                BoxShadow(
                                  color: AppTheme.accent.withValues(
                                    alpha: 0.35,
                                  ),
                                  blurRadius: 35.r,
                                  spreadRadius: 8.r,
                                ),
                                // 2. A tighter, brighter glow closer to the button edge
                                BoxShadow(
                                  color: AppTheme.accent.withValues(alpha: 0.2),
                                  blurRadius: 10.r,
                                  spreadRadius: 2.r,
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                Icons
                                    .lock_open_rounded, // Closest standard material icon
                                color: AppTheme.accent,
                                size: 32.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),

                          Text(
                            "Verify Number",
                            style: TextStyle(
                              color: AppTheme.text1,
                              fontSize: 42.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Arial',
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 32.w),
                            child: Text.rich(
                              TextSpan(
                                style: TextStyle(
                                  color: AppTheme.text1.withValues(alpha: 0.5),
                                  fontSize: 16.sp,
                                  height: 1.5,
                                ),
                                children: [
                                  const TextSpan(
                                    text:
                                        "We have sent a 4-digit verification code to ",
                                  ),
                                  TextSpan(
                                    text: widget.phoneNumber,
                                    style: const TextStyle(
                                      color: AppTheme.text1,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Enter OTP",
                                  style: TextStyle(
                                    color: AppTheme.text2,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                SizedBox(height: 10.h),

                                Pinput(
                                  length: 4,
                                  controller: _otpController,
                                  focusNode: _focusNode,
                                  defaultPinTheme: defaultPinTheme,
                                  focusedPinTheme: focusedPinTheme,
                                  submittedPinTheme: submittedPinTheme,
                                  showCursor: true,
                                  cursor: Container(
                                    width: 2.w,
                                    height: 30.h,
                                    color: AppTheme.accent,
                                  ),
                                  separatorBuilder: (index) => SizedBox(width: 12.w),
                                  onCompleted: (pin) {
                                    debugPrint("User entered OTP: $pin");
                                    // You can trigger auto-verify here if you want
                                  },
                                ),

                                SizedBox(height: 20.h),
                                _secondsRemaining > 0
                                    ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.access_time_rounded,
                                      color: AppTheme.text2,
                                      size: 16.sp,
                                    ),
                                    Text(
                                      " Resend Code in 00:${_secondsRemaining.toString().padLeft(2, '0')}",
                                      style: TextStyle(
                                        color: AppTheme.text2,
                                        fontSize: 16.sp,
                                      ),
                                    ),
                                  ],
                                )
                                    : GestureDetector(
                                  onTap: () {
                                    debugPrint("Resend API Triggered");
                                    _startTimer(); // Restart the timer
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.refresh,
                                        color: AppTheme.accent,
                                        size: 18.sp,
                                      ),
                                      Text(
                                        " Resend Code",
                                        style: TextStyle(
                                          color: AppTheme.accent,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(flex: 2),
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
                                  foregroundColor: AppTheme.buttonForeground,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                ),
                                onPressed: () {
                                  debugPrint("Verify clicked with code: ${_otpController.text}");
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Verify & Continue",
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


class _LightingBackground extends StatelessWidget {
  const _LightingBackground();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          // Top glow
          Positioned(top: -120, left: -80, child: _glow(size: 320)),

          // Center glow
          Positioned(top: 200, right: -100, child: _glow(size: 260)),

          // Bottom glow
          Positioned(bottom: -140, left: 60, child: _glow(size: 300)),
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
