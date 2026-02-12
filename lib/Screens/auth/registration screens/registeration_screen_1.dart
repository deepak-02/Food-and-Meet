import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/dob_picker.dart';
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
  });

  final TextEditingController nameController;
  final TextEditingController phoneController;
  // final TextEditingController aadhaarController;
  final TextEditingController addressController;
  final TextEditingController dobController;
  final TextEditingController otpController;

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

              InputField(
                name: "Full Name",
                hint: "John Doe",
                icon: Icons.person,
                controller: nameController,
              ),
              SizedBox(height: 20.h),
              InputField(
                name: "Phone Number",
                hint: "9952543212",
                icon: Icons.phone,
                suffixIcon: phoneController.text.length == 10 ? Icons.verified_outlined : null,
                controller: phoneController,
                onPressed: (){},
                tooltip: "Verify Phone Number",
              ),
              if(phoneController.text.length == 10)
                SizedBox(height: 20.h),
              if(phoneController.text.length == 10)
                InputField(
                  name: "OTP",
                  hint: "1234",
                  icon: Icons.message,
                  controller: otpController,
              ),
              // SizedBox(height: 20.h),
              // InputField(
              //   name: "Aadhaar",
              //   hint: "xxxx xxxx 4664",
              //   icon: Icons.credit_card_rounded,
              //   controller: aadhaarController,
              // ),
              SizedBox(height: 20.h),
              DateOfBirthField(controller: dobController),
              SizedBox(height: 20.h),
              InputField(
                name: "Address",
                hint:
                    "H. No-162, Hari Nagar Society Dabholi Road, Near Govind Ji Hall Katargam, Surat, Gujarat - 395004",
                icon: Icons.home,
                controller: addressController,
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
