import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/dob_picker.dart';
import '../../../widgets/gender_dropdown.dart';
import '../../../widgets/input_fields.dart';

class RegistrationScreen1 extends StatelessWidget {
  const RegistrationScreen1({
    super.key,
    required this.nameController,
    required this.phoneController,
    // required this.aadhaarController,
    required this.addressController,
    required this.dobController,
    required this.otpController,
    required this.nameError,
    required this.phoneError,
    required this.addressError,
    required this.dobError,
    this.selectedGender,
    required this.onGenderChanged,
    required this.genderError,
  });

  final TextEditingController nameController;
  final TextEditingController phoneController;
  // final TextEditingController aadhaarController;
  final TextEditingController addressController;
  final TextEditingController dobController;
  final TextEditingController otpController;

  final ValueNotifier<String?> nameError;
  final ValueNotifier<String?> phoneError;
  final ValueNotifier<String?> addressError;
  final ValueNotifier<String?> dobError;

  final String? selectedGender;
  final ValueChanged<String?> onGenderChanged;
  final ValueNotifier<String?> genderError;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create Profile",
                style: TextStyle(
                  color: AppTheme.text1,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5.w,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Start your culinary journey. Let's get to know the real you.",
                style: TextStyle(
                  color: AppTheme.text1.withValues(alpha: 0.6),
                  fontSize: 16.sp,
                  height: 1.5,
                ),
              ),

              SizedBox(height: 20.h),

              ValueListenableBuilder<String?>(
                valueListenable: nameError,
                builder: (context, error, child) {
                  return InputField(
                    name: "Full Name",
                    hint: "John Doe",
                    icon: Icons.person,
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    maxLength: 30,
                    errorText: error, // Show error if present
                  );
                },
              ),
              SizedBox(height: 20.h),
              ValueListenableBuilder<String?>(
                valueListenable: phoneError,
                builder: (context, error, child) {
                  return ValueListenableBuilder<TextEditingValue>(
                    valueListenable: phoneController,
                    builder: (context, value, child) {
                      final bool isPhoneValid = value.text.length == 10;
                      return Column(
                        children: [
                          InputField(
                            name: "Phone Number",
                            hint: "9952543212",
                            icon: Icons.phone,
                            suffixIcon: isPhoneValid
                                ? Icons.verified_outlined
                                : null,
                            controller: phoneController,
                            maxLength: 10,
                            keyboardType: TextInputType.phone,
                            errorText: error, // Show error if present
                            onPressed: () {},
                            tooltip: "Verify Phone Number",
                          ),
                          if (isPhoneValid) ...[
                            SizedBox(height: 20.h),
                            InputField(
                              name: "OTP",
                              hint: "1234",
                              icon: Icons.message,
                              controller: otpController,
                            ),
                          ],
                        ],
                      );
                    },
                  );
                },
              ),
              // SizedBox(height: 20.h),
              // InputField(
              //   name: "Aadhaar",
              //   hint: "xxxx xxxx 4664",
              //   icon: Icons.credit_card_rounded,
              //   controller: aadhaarController,
              // ),
              SizedBox(height: 20.h),
              ValueListenableBuilder<String?>(
                valueListenable: dobError,
                builder: (context, errorText, child) {
                  return DateOfBirthField(
                    controller: dobController,
                    errorText: errorText,
                  );
                },
              ),
              SizedBox(height: 20.h),
              ValueListenableBuilder<String?>(
                valueListenable: genderError,
                builder: (context, error, child) {
                  return GenderDropdown(
                    value: selectedGender,
                    onChanged: onGenderChanged,
                    errorText: error, // Logic handled inside widget
                  );
                },
              ),
              SizedBox(height: 20.h),
              ValueListenableBuilder<String?>(
                valueListenable: addressError,
                builder: (context, error, child) {
                  return InputField(
                    name: "Address",
                    hint: "H. No-162, Hari Nagar Society...",
                    icon: Icons.home,
                    controller: addressController,
                    errorText: error, // Show error if present
                  );
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
