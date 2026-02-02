import 'dart:io'; // Required for File
import 'dart:ui'; // Required for PathMetric
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart'; // Required package

class ImageUploadGrid extends StatefulWidget {
  const ImageUploadGrid({super.key, required this.images});

  final List<File?> images;
  @override
  State<ImageUploadGrid> createState() => _ImageUploadGridState();
}

class _ImageUploadGridState extends State<ImageUploadGrid> {
  // Store images for the 4 slots. Null means empty.
  List<File?> get _images => widget.images;
  final ImagePicker _picker = ImagePicker();

  // Function to pick image
  Future<void> _pickImage(int index, ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _images[index] = File(pickedFile.path);
          widget.images[index] = File(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  // Show dialog to choose Camera or Gallery
  void _showPickerOptions(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1C1C1E),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.white),
                title: const Text(
                  'Gallery',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(index, ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera, color: Colors.white),
                title: const Text(
                  'Camera',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(index, ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 16.h,
            childAspectRatio: 1.0,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return _PhotoUploadCard(
              isMain: index == 0,
              imageFile: _images[index],
              onTap: () => _showPickerOptions(context, index),
              onRemove: () {
                setState(() {
                  _images[index] = null;
                });
              },
            );
          },
        ),
      ],
    );
  }
}

class _PhotoUploadCard extends StatelessWidget {
  final bool isMain;
  final File? imageFile;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const _PhotoUploadCard({
    required this.isMain,
    required this.imageFile,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    // If an image is selected, show the image
    if (imageFile != null) {
      return Stack(
        children: [
          // The Image itself
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              image: DecorationImage(
                image: FileImage(imageFile!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Remove Button (Top Right)
          Positioned(
            top: 4.h,
            right: 4.w,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                padding: EdgeInsets.all(4.r),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: Colors.white, size: 18.sp),
              ),
            ),
          ),
          // "Main Photo" Label if needed over the image
          if (isMain)
            Positioned(
              bottom: 8.h,
              left: 0.w,
              right: 0.w,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    "Main Photo",
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ),
              ),
            ),
        ],
      );
    }

    // If NO image, show the Dashed Border Upload UI
    return CustomPaint(
      foregroundPainter: _DashedBorderPainter(
        color: Colors.white.withValues(alpha: 0.3),
        strokeWidth: 1.5.w,
        gap: 6.0.w,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xBB2C2C2E),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20.r),
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isMain) ...[
                  // Main Photo Style
                  Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: Color(0xFF00E676),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x4000E676),
                          blurRadius: 10.r,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(Icons.add, color: Colors.black, size: 28.sp),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "Main Photo",
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ] else ...[
                  // Secondary Photo Style
                  Icon(
                    Icons.add,
                    color: Colors.white.withValues(alpha: 0.3),
                    size: 28.sp,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// CUSTOM PAINTER (Unchanged)
// ---------------------------------------------------------------------------
class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;

  _DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.gap = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(20.r),
    );

    final Path path = Path()..addRRect(rrect);
    final Path dashPath = Path();
    double distance = 0.0;

    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + gap),
          Offset.zero,
        );
        distance += (gap * 2);
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
