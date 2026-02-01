import 'dart:io';

import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import '../../../widgets/photo_upload_grid.dart';

class RegistrationScreen2 extends StatelessWidget {
  const RegistrationScreen2({super.key, required this.images});

  final List<File?> images;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(

              TextSpan(
                // 1. Default Style for the whole block (Grey & Small)

                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 12,
                  height: 1.5, // Adds line spacing for better readability
                ),
                children: [
                  const TextSpan(
                    text: "Verify Your",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                  ),

                  TextSpan(
                    text: "\nIdentity",
                    style: const TextStyle(
                      color: AppTheme.accent,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      // letterSpacing: 0.5,
                    ),

                  ),
                  const TextSpan(text: ".",
                      style: TextStyle(
                        color: AppTheme.accent,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            Text(
              "We value authenticity. Upload photos to help your dining companions recognize you.",
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 16,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 20),

            ImageUploadGrid(images: images),


          ],
        ),
      ),
    );
  }
}
