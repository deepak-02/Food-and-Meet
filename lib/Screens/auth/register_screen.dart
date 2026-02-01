import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food/Screens/auth/registration%20screens/registeration_screen_1.dart';
import 'package:food/Screens/auth/registration%20screens/registration_screen_2.dart';
import 'package:food/Screens/auth/registration%20screens/registration_screen_3.dart';
import 'package:food/Screens/auth/registration%20screens/registration_screen_4.dart';

import '../../theme/app_theme.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {

  // Controller to programmatically scroll pages
  final PageController _pageController = PageController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _aadhaarController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  final List<File?> images = [null, null, null, null];

  // State to track the current page index (0 to 3)
  int _currentPage = 0;

  // Helper to handle Back Button Logic
  void _handleBack() {
    if (_currentPage > 0) {
      // If not on first page, go back one page
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // If on first page, pop the screen
      Navigator.pop(context);
    }
  }

  // Helper to handle Continue Button Logic
  void _handleContinue() {
    if (_currentPage < 3) {
      // If not on last page, go to next page
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // If on last page, submit form
      debugPrint("Registration Completed!");
      // Add your submit logic here
      _submitRegistration();
    }
  }

  void _submitRegistration() {
    final registrationData = {
      "name": _nameController.text.trim(),
      "phone": _phoneController.text.trim(),
      "aadhaar": _aadhaarController.text.trim(),
      "address": _addressController.text.trim(),
      "dob": _dobController.text, // ideally DateTime
      "images": images.whereType<File>().toList(),
    };

    debugPrint(registrationData.toString());

    // Navigate to preview screen
  }


  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _aadhaarController.dispose();
    _addressController.dispose();
    _dobController.dispose();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // background
            _LightingBackground(),

            SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        tooltip: 'Back',
                        onPressed: _handleBack, // Link to back logic
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(width: MediaQuery.of(context).size.width * 0.3,),

                      // Dynamic Dots
                      Row(
                        children: List.generate(4, (index) {
                          return _dot(active: index == _currentPage);
                        }),
                      ),

                    ],
                  ),

                  const SizedBox(height: 20,),

                  // page view to handle 4 pages of registration screens
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(), // Do not allow swipe
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: [
                        RegistrationScreen1(
                          nameController: _nameController,
                          phoneController: _phoneController,
                          aadhaarController: _aadhaarController,
                          addressController: _addressController,
                          dobController: _dobController,
                        ),

                        RegistrationScreen2(images: images,),
                        RegistrationScreen3(),
                        RegistrationScreen4(),
                      ],
                    ),
                  ),


                  const SizedBox(height: 20,),

                  // Button to handle the page switching
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.accent,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: _handleContinue, // Link to continue logic,
                        child: Text(
                          _currentPage == 3 ? "Finish" : "Continue",
                          style: TextStyle(
                            color: Colors.black, // White text
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
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
    );
  }

  static Widget _dot({bool active = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 25 : 6,
      height: 6,
      decoration: BoxDecoration(
        color: active ? AppTheme.accent : Colors.grey[700],
        borderRadius: BorderRadius.circular(3),
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
            top: -120,
            left: -80,
            child: _glow(size: 320),
          ),

          // Center glow
          Positioned(
            top: 200,
            right: -100,
            child: _glow(size: 260),
          ),

          // Bottom glow
          Positioned(
            bottom: -140,
            left: 60,
            child: _glow(size: 300),
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
            AppTheme.accent.withValues(alpha: 0.0)
          ],
        ),
      ),
    );
  }
}