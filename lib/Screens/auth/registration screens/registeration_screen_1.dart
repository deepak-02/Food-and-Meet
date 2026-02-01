import 'package:flutter/material.dart';

import '../../../widgets/dob_picker.dart';
import '../../../widgets/input_fields.dart';

class RegistrationScreen1 extends StatelessWidget {
   const RegistrationScreen1({super.key, required this.nameController, required this.phoneController, required this.aadhaarController, required this.addressController, required this.dobController});

  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController aadhaarController;
  final TextEditingController addressController;
  final TextEditingController dobController;

  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create Profile",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Start your culinary journey. Let's get to know the real you.",
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 16,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 20),

            InputField(name: "Full Name", hint: "John Doe", icon: Icons.person, controller: nameController),
            const SizedBox(height: 20),
            InputField(name: "Phone Number", hint: "9952543212", icon: Icons.phone, controller: phoneController),
            const SizedBox(height: 20),
            InputField(name: "Aadhaar", hint: "xxxx xxxx 4664", icon: Icons.credit_card_rounded, controller: aadhaarController),
            const SizedBox(height: 20),
            DateOfBirthField(controller: dobController,),
            const SizedBox(height: 20),
            InputField(name: "Address", hint: "H. No-162, Hari Nagar Society Dabholi Road, Near Govind Ji Hall Katargam, Surat, Gujarat - 395004", icon: Icons.home, controller: addressController),
            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
}


