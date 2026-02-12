import 'dart:io';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FaceValidator {
  // Create a detector with accurate mode for better quality checks
  static final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      performanceMode: FaceDetectorMode.accurate,
      enableLandmarks: true, // Needed to ensure eyes/mouth are visible
      enableClassification: true, // Needed for open eye/smile detection
    ),
  );

  static Future<String?> validateFace(File imageFile) async {
    try {
      final inputImage = InputImage.fromFile(imageFile);
      final List<Face> faces = await _faceDetector.processImage(inputImage);

      // 1. Check if any face is detected
      if (faces.isEmpty) {
        return "No face detected. Please upload a clear photo of yourself.";
      }

      // 2. Check if multiple faces are detected (Optional rule)
      if (faces.length > 1) {
        return "Too many faces detected. Please upload a photo of just you.";
      }

      final Face face = faces.first;

      // 3. Check Head Rotation (Is the user looking at the camera?)
      // Y-angle represents turning head left/right.
      // Ideally should be close to 0. Limit to +/- 20 degrees.
      if (face.headEulerAngleY != null) {
        if (face.headEulerAngleY! > 20 || face.headEulerAngleY! < -20) {
          return "Please look directly at the camera.";
        }
      }

      // 4. Check Image Quality via Landmarks (Basic Blur Check)
      // If ML Kit can't find eyes or nose, the image is likely too blurry or obscured
      final leftEye = face.landmarks[FaceLandmarkType.leftEye];
      final nose = face.landmarks[FaceLandmarkType.noseBase];

      if (leftEye == null || nose == null) {
        return "Face is too blurry or obscured. Please try again.";
      }

      // If all checks pass
      return null;

    } catch (e) {
      return "Error processing image: $e";
    }
  }

  static void dispose() {
    _faceDetector.close();
  }
}