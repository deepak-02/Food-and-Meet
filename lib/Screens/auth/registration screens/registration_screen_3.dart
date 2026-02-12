import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../theme/app_theme.dart';

class RegistrationScreen3 extends StatefulWidget {
  const RegistrationScreen3({super.key});

  @override
  State<RegistrationScreen3> createState() => _RegistrationScreen3State();
}

class _RegistrationScreen3State extends State<RegistrationScreen3> {
  final TextEditingController _controller = TextEditingController();
  final int maxLength = 150;


  // 1. The list of available options with their icons
  final List<Map<String, dynamic>> _options = [

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

  // 2. Set to track selected items (using Set prevents duplicates)
  final Set<String> _selectedOptions = {};


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top Text
              Text.rich(
                TextSpan(
                  // Default Style for the whole block (Grey & Small)
                  style: TextStyle(
                    color: AppTheme.text1.withValues(alpha: 0.5),
                    fontSize: 12.sp,
                    height: 1.5, // Adds line spacing for better readability
                  ),
                  children: [
                    TextSpan(
                      text: "Tell us about",
                      style: TextStyle(
                        color: AppTheme.text1,
                        fontSize: 34.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5.w,
                      ),
                    ),

                    TextSpan(
                      text: "\nyour taste",
                      style: TextStyle(
                        color: AppTheme.accent,
                        fontSize: 34.sp,
                        fontWeight: FontWeight.bold,
                        // letterSpacing: 0.5.w,
                      ),
                    ),
                    TextSpan(
                      text: ".",
                      style: TextStyle(
                        color: AppTheme.accent,
                        fontSize: 34.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                "Your bio and interests help us curate the perfect dining crowd for you.",
                style: TextStyle(
                  color: AppTheme.text2,
                  fontSize: 18.sp,
                  height: 1.5,
                ),
              ),

              SizedBox(height: 20.h),

              // 2. The Input Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Foodie Bio",
                    style: TextStyle(
                      color: AppTheme.text1.withValues(alpha: 0.8),
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),

                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            // Optional: very subtle shadow to match the clean look
                            BoxShadow(
                              color: AppTheme.buttonForeground.withValues(alpha: 0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _controller,
                          maxLength: maxLength,
                          maxLines: 4, // Gives it the height shown in image
                          style: TextStyle(
                            color: AppTheme.text1, // Color of the text user types
                            fontSize: 16.sp,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            // The Light Grey background from the image
                            fillColor: const Color(0xBB2C2C2E),
                            hintText:
                                "I'm a ramen enthusiast looking for spicy adventures...",
                            hintStyle: TextStyle(
                              color: AppTheme.text1.withValues(alpha: 0.4),
                              fontSize: 16.sp,
                            ),
                            // Hide the default "0/150" counter that appears below the field
                            counterText: "",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.r),
                              borderSide: BorderSide.none,
                            ),
                            // Add bottom padding so text doesn't overlap the custom counter
                            contentPadding: EdgeInsets.fromLTRB(
                              16.w,
                              16.h,
                              16.w,
                              40.h,
                            ),
                          ),
                        ),
                      ),

                      // 3. The Custom "Pill" Counter (Bottom Right)
                      Positioned(
                        bottom: 12.h,
                        right: 12.w,
                        child: ValueListenableBuilder<TextEditingValue>(
                          valueListenable: _controller,
                          builder: (context, value, child) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                // Light Green Background
                                color: AppTheme.text3,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                "${value.text.length}/$maxLength",
                                style: TextStyle(
                                  // Green Text Color
                                  color: AppTheme.accent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              Row(
                children: [
                  Text(
                    "Cravings & Interests",
                    style: TextStyle(
                      color: AppTheme.text1.withValues(alpha: 0.8),
                      fontSize: 16.sp,
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Select at least 3",
                    style: TextStyle(
                      color: AppTheme.text2,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),

              Wrap(
                spacing: 12.w, // Horizontal gap between chips
                runSpacing: 12.h, // Vertical gap between lines
                children: _options.map((option) {
                  final String label = option['label'];
                  final IconData icon = option['icon'];
                  final bool isSelected = _selectedOptions.contains(label);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedOptions.remove(label);
                        } else {
                          _selectedOptions.add(label);
                        }
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        // Dynamic Color: Bright Green if selected, Light Grey if not
                        color: isSelected ? AppTheme.accent : AppTheme.inputBackground,
                        borderRadius: BorderRadius.circular(30.r), // Pill shape
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min, // Shrink to fit content
                        children: [
                          // Main Icon
                          Icon(
                            icon,
                            color: isSelected ? AppTheme.buttonForeground : AppTheme.text2,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),

                          // Label Text
                          Text(
                            label,
                            style: TextStyle(
                              color: isSelected ? AppTheme.buttonForeground : AppTheme.text2,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          // Conditional Checkmark (Only appears when selected)
                          if (isSelected) ...[
                            SizedBox(width: 8.w),
                            Icon(
                              Icons.check_rounded,
                              color: AppTheme.buttonForeground,
                              size: 18.sp,
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
