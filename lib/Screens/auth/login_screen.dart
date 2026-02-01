import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [

          // ------------------------------------------------
          // LAYER 1: Background Image with Dark Overlay
          // ------------------------------------------------
          Positioned.fill(
            child: Image.asset(
              "assets/images/b1.jpg",
              fit: BoxFit.cover,
            ),
          ),
          // Dark overlay to make text readable
          Positioned.fill(
            child: Container(
              color: Colors.black.withValues(alpha: 0.6),
            ),
          ),

          // ------------------------------------------------
          // LAYER 2: Main Content (Text & Form)
          // ------------------------------------------------
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 2),

                const Text(
                  "Taste. Meet.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial', // Use a clean sans-serif font
                  ),
                ),

                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return  LinearGradient(
                      // Approximate colors from your image (Gold to Orange)
                      colors: [
                        Color(0xFFB9FF7F), // Light
                        AppTheme.accent, // Dark
                      ],
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                    ).createShader(bounds);
                  },
                  // This blend mode applies the shader ONLY to the text pixels
                  blendMode: BlendMode.srcIn,
                  child: const Text(
                    " Repeat.",
                    style: TextStyle(
                      // The color here acts as a base; white is standard for masking
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

               const SizedBox(height: 20,),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    "Login to access curated dining experiences.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      height: 1.4,
                    ),
                  ),
                ),

                const SizedBox(height: 20,),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white.withValues(alpha: 0.05),
                      border: Border.all(
                          color: Colors.white24
                      )
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Phone Number",
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                      const SizedBox(height: 10),

                      // Input Field
                      TextField(
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xBB2C2C2E),
                          hintText: "9952543212",
                          hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
                          suffixIcon: const Icon(Icons.phone_iphone, color: AppTheme.accent),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Center(
                        child: Text.rich(
                          TextSpan(
                            // 1. Default Style for the whole block (Grey & Small)
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 12,
                              height: 1.5, // Adds line spacing for better readability
                            ),
                            children: [
                              const TextSpan(text: "By continuing, you agree to our "),

                              // 2. "Terms of Service" Link
                              TextSpan(
                                text: "Terms of Service",
                                style: const TextStyle(
                                  color: Colors.white, // Brighter to stand out
                                  decoration: TextDecoration.underline, // Underlined
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Handle the tap here (e.g., open URL)
                                    debugPrint("Terms of Service clicked");
                                  },
                              ),

                              const TextSpan(text: "\nand "),

                              // 3. "Privacy Policy" Link
                              TextSpan(
                                text: "Privacy Policy",
                                style: const TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Handle the tap here
                                    debugPrint("Privacy Policy clicked");
                                  },
                              ),

                              const TextSpan(text: "."),
                            ],
                          ),
                          // Center align the text block
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 20,),

                      Padding(
                        padding: const EdgeInsets.only(left: 24, right: 24, top: 10, bottom: 24),
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
                            onPressed: (){
                              debugPrint("continue clicked");
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Continue ",
                                  style: TextStyle(
                                    color: Colors.black, // White text
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.0,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black,
                                  size: 18,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),




                    ],
                  ),
                ),
                const SizedBox(height: 20,),


                Text.rich(
                  TextSpan(
                    // 1. Default Style for the whole block (Grey & Small)
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12,
                      height: 1.5, // Adds line spacing for better readability
                    ),
                    children: [
                      const TextSpan(text: "New User?  "),

                      TextSpan(
                        text: "Register",
                        style: const TextStyle(
                          color: Colors.white, // Brighter to stand out
                          decoration: TextDecoration.underline, // Underlined
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Handle the tap here (e.g., open URL)
                            debugPrint("Create account clicked");
                          },
                      ),
                      const TextSpan(text: "."),
                    ],
                  ),
                  // Center align the text block
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20,),




              ],
            ),

          ),

        ],
      ),
    );
  }
}
