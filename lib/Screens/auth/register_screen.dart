import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  // final TextEditingController _aadhaarController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final List<File?> images = [null, null, null, null];

  String? _selectedGender;

  bool termsAccepted = false;

  // ERROR NOTIFIERS
  final ValueNotifier<String?> _nameError = ValueNotifier<String?>(null);
  final ValueNotifier<String?> _phoneError = ValueNotifier<String?>(null);
  final ValueNotifier<String?> _addressError = ValueNotifier<String?>(null);
  final ValueNotifier<String?> _dobError = ValueNotifier<String?>(null);
  final ValueNotifier<String?> _imageError = ValueNotifier<String?>(null);
  final ValueNotifier<String?> _interestsError = ValueNotifier<String?>(null);
  final ValueNotifier<String?> _genderError = ValueNotifier<String?>(null);

  // The list of available options with their icons
  final List<Map<String, dynamic>> interests = [
    // Top Requests
    {'label': 'Mandi', 'icon': Icons.rice_bowl},
    {'label': 'Biryani', 'icon': Icons.dinner_dining},
    {'label': 'Coffee', 'icon': Icons.coffee_rounded},
    {'label': 'Chai', 'icon': Icons.emoji_food_beverage},
    {'label': 'Snacks', 'icon': Icons.fastfood},
    {'label': 'Desserts', 'icon': Icons.cake},
    {'label': 'Pizza', 'icon': Icons.local_pizza},
    {'label': 'Meals', 'icon': Icons.bento},
    {'label': 'Dosa', 'icon': Icons.breakfast_dining},
    {'label': 'Seafood', 'icon': Icons.set_meal},
    {'label': 'Juice', 'icon': Icons.local_bar},

    // {'label': 'Shawarma', 'icon': Icons.kebab_dining},
    // {'label': 'Porotta', 'icon': Icons.bakery_dining},
    // {'label': 'Al Faham', 'icon': Icons.local_fire_department},
    // {'label': 'Ramen', 'icon': Icons.ramen_dining},
    // {'label': 'Spicy', 'icon': Icons.local_fire_department_rounded},
    // {'label': 'Vegan', 'icon': Icons.eco_rounded},
    // {'label': 'Burgers', 'icon': Icons.lunch_dining_rounded},
  ];

  final Set<String> selectedInterests = {};

  // State to track the current page index (0 to 3)
  int _currentPage = 0;

  // VALIDATION LOGIC FOR STEP 1
  bool _validateStep1() {
    bool isValid = true;

    // Validate Name
    if (_nameController.text.trim().isEmpty) {
      _nameError.value = "Full name is required";
      isValid = false;
    } else {
      _nameError.value = null;
    }

    // Validate Phone
    if (_phoneController.text.trim().length != 10) {
      _phoneError.value = "Enter a valid 10-digit number";
      isValid = false;
    } else {
      _phoneError.value = null;
    }

    // Validate Gender
    if (_selectedGender == null) {
      _genderError.value = "Please select a gender";
      isValid = false;
    } else {
      _genderError.value = null;
    }

    // validate dob
    if (_dobController.text.trim().isEmpty) {
      _dobError.value = "Date of birth is required";
      isValid = false;
    } else {
      _dobError.value = null;
    }

    // Validate Address
    if (_addressController.text.trim().isEmpty) {
      _addressError.value = "Address is required";
      isValid = false;
    } else {
      _addressError.value = null;
    }

    return isValid;
  }

  // VALIDATION LOGIC FOR STEP 2
  bool _validateStep2() {
    //  Check if at least 1 image (the main one) is uploaded
    if (images[0] == null) {
      _imageError.value = "Please upload a main profile photo.";
      return false;
    }

    //  Check if at least 3 images are uploaded
    int uploadedCount = images.where((img) => img != null).length;
    if (uploadedCount < 3) {
      _imageError.value = "Please upload at least 3 photos.";
      return false;
    }

    _imageError.value = null; // Clear error if valid
    return true;
  }

  // VALIDATION LOGIC FOR STEP 3
  bool _validateStep3() {
    if (selectedInterests.length < 3) {
      _interestsError.value = "Please select at least 3 interests.";
      return false;
    }

    _interestsError.value = null;
    return true;
  }

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
    FocusManager.instance.primaryFocus?.unfocus();
    // Validate Step 1
    if (_currentPage == 0) {
      if (!_validateStep1()) return; // Stop if validation fails
    }
    // Validate Step 2
    if (_currentPage == 1) {
      if (!_validateStep2()) return;
    }
    // Validate Step 3
    if (_currentPage == 2) {
      if (!_validateStep3()) return;
    }

    if (_currentPage < 3) {
      // If not on last page, go to next page
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // If on last page, submit form
      if (!termsAccepted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Please accept the Terms & Conditions to proceed."),
            backgroundColor: Colors.redAccent,
          ),
        );
        return;
      }
      // Add your submit logic here
      _submitRegistration();
    }
  }

  void _submitRegistration() {
    final registrationData = {
      "name": _nameController.text.trim(),
      "phone": _phoneController.text.trim(),
      "address": _addressController.text.trim(),
      "dob": _dobController.text,
      "bio": _bioController.text.trim(),
      "interests": selectedInterests.toList(),
      "termsAccepted": termsAccepted, // <--- Added here
      // Note: File objects don't print well, so we print their paths or count
      "images": images.where((img) => img != null).map((e) => e!.path).toList(),
    };

    // 4. PRINT EVERYTHING
    debugPrint("---------------- REGISTRATION DATA ----------------");
    debugPrint(registrationData.toString());
    debugPrint("---------------------------------------------------");
  }

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    // _aadhaarController.dispose();
    _addressController.dispose();
    _dobController.dispose();
    _otpController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // 'canPop' determines if the system is allowed to close the screen.
      // We only allow it if we are on the first page (index 0).
      canPop: _currentPage == 0,

      // This callback runs when the user tries to go back
      // This callback runs when the user tries to go back
      onPopInvokedWithResult: (didPop, result) {
        // If 'canPop' was true (page 0), the pop happened. We stop here.
        if (didPop) return;

        // If 'canPop' was false (page > 0), the pop was blocked.
        // We manually scroll back to the previous page.
        _pageController.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },

      child: AnnotatedRegion<SystemUiOverlayStyle>(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          tooltip: 'Back',
                          onPressed: _handleBack, // Link to back logic
                          icon: Icon(Icons.arrow_back, color: AppTheme.text1),
                        ),

                        SizedBox(
                          width: MediaQuery.of(context).size.width.w * 0.3,
                        ),

                        // Dynamic Dots
                        Row(
                          children: List.generate(4, (index) {
                            return _dot(active: index == _currentPage);
                          }),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),

                    // page view to handle 4 pages of registration screens
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        physics:
                            const NeverScrollableScrollPhysics(), // Do not allow swipe
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        children: [
                          RegistrationScreen1(
                            nameController: _nameController,
                            phoneController: _phoneController,
                            // aadhaarController: _aadhaarController,
                            addressController: _addressController,
                            dobController: _dobController,
                            otpController: _otpController,
                            nameError: _nameError,
                            phoneError: _phoneError,
                            addressError: _addressError,
                            dobError: _dobError,
                            selectedGender: _selectedGender,
                            onGenderChanged: (val) {
                              setState(() {
                                _selectedGender = val;
                              });
                            },
                            genderError: _genderError,
                          ),

                          RegistrationScreen2(
                            images: images,
                            imageError: _imageError,
                          ),

                          RegistrationScreen3(
                            selectedInterests: selectedInterests,
                            controller: _bioController,
                            interests: interests,
                            errorNotifier: _interestsError,
                          ),
                          RegistrationScreen4(
                            name: _nameController.text.trim(),
                            phone: _phoneController.text.trim(),
                            // aadhaar: _aadhaarController.text.trim(),
                            address: _addressController.text.trim(),
                            dob: _dobController.text,
                            bio: _bioController.text.trim(),
                            selectedInterests: selectedInterests,
                            images: images,
                            allInterests: interests,
                            termsAccepted: termsAccepted,
                            onTermsChanged: (bool newValue) {
                              setState(() {
                                termsAccepted = newValue;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // Button to handle the page switching
                    Padding(
                      padding: EdgeInsets.only(left: 24.w, right: 24.w),
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
                          onPressed: _handleContinue, // Link to continue logic,
                          child: Text(
                            _currentPage == 3 ? "Finish" : "Continue",
                            style: TextStyle(
                              color: AppTheme.buttonForeground,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0.w,
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
      ),
    );
  }

  static Widget _dot({bool active = false}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.r),
      width: active ? 25.w : 6.h,
      height: 6.h,
      decoration: BoxDecoration(
        color: active ? AppTheme.accent : AppTheme.text4,
        borderRadius: BorderRadius.circular(3.r),
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
