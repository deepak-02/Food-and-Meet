import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        backgroundColor: Colors.black,
      
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
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16), // image radius
                            child: Image.asset(
                              "assets/images/ramen.png",
                              fit: BoxFit.cover,
                              height: 260,
                            ),
                          ),
      
                          SizedBox(height: 20,),
      
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white.withValues(alpha: 0.05),
                              border: Border.all(
                                color: Colors.white24
                              )
                            ),
      
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Icon(
                                    Icons.verified_user,
                                    color: AppTheme.accent,
      
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Text(
                                    "VERIFIED COMMUNITY",
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                        ],
                      ),
                    ),
      
                    const SizedBox(height: 20,),
      
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
                        "Repeat.",
                        style: TextStyle(
                          // The color here acts as a base; white is standard for masking
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
      
                    SizedBox(height: 20,),
      
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        "Discover curated dining experiences with verified foodies near you.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                          height: 1.4,
                        ),
                      ),
                    ),
      
                    const SizedBox(height: 20),
      
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     _dot(active: true),
                    //     // _dot(),
                    //     // _dot(),
                    //   ],
                    // ),

                    Spacer(),

      
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
                            context.push('/register');
                          },
                          child: Text(
                            "GET STARTED",
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

                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: OutlinedButton(
                          onPressed: () {
                            context.push('/login');
                          },
                          style: OutlinedButton.styleFrom(
                            // Transparent background
                            backgroundColor: Colors.transparent,
                            // White border to pop against dark background
                            side: const BorderSide(color: AppTheme.accent, width: 2),
                            shape: const StadiumBorder(),
                          ),
                          child: const Text(
                            "LOGIN",
                            style: TextStyle(
                              color: AppTheme.accent, // White text
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),



      
                  ],
                )
            )
      
          ],
        ),
      ),
    );
  }

  static Widget _dot({bool active = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 18 : 6,
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
