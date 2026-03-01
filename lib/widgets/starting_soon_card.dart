import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_theme.dart';

class StartingSoonCard extends StatelessWidget {
  const StartingSoonCard({
    super.key, this.image, this.title, this.subtitle, this.distance, this.distanceUnit, this.time, this.maximum, this.current, this.rating, this.genderPreference,
  });

  final String? image;
  final String? title;
  final String? subtitle;
  final double? distance;
  final String? distanceUnit;
  final String? time;
  final int? maximum;
  final int? current;
  final double? rating;
  final String? genderPreference;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.r),
      child: Container(
        width: 340.w,
        decoration: BoxDecoration(
          color: AppTheme.secondary.withValues(alpha: 0.01),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: AppTheme.accent.withValues(alpha: 0.4),
            width: 1.5.w,
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.accent.withValues(alpha: 0.05),
              blurRadius: 20.r,
              spreadRadius: 2.r,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Half: Image & Badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(19.r),
                    topRight: Radius.circular(19.r),
                  ),
                  child: Image.asset(
                    image ?? 'assets/images/ramen.png', // Replace with your image
                    height: 200.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    // 1. Prevents the image from flashing/clearing while scrolling
                    gaplessPlayback: true,
                    // 2. Forces Flutter to decode the image at a smaller resolution.
                    // 600 is a safe number for a 200h widget on high-density (retina) screens.
                    cacheHeight: 600,
                  ),
                ),
                // Badge


                Positioned(
                  bottom: 12.h,
                  left: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.access_time_outlined,
                          color: AppTheme.accent,
                          size: 16.sp,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          genderPreference == "male" || genderPreference == "female" ? '$time  |  ' : time ?? '0:00 PM',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),

                        if(genderPreference == "male")
                          Icon(
                            Icons.male,
                            color: AppTheme.accent,
                            size: 16.sp,
                          ),
                        if(genderPreference == "female")
                          Icon(
                            Icons.female,
                            color: AppTheme.accent,
                            size: 16.sp,
                          ),


                      ],
                    ),
                  ),
                ),

              ],
            ),

            // Bottom Half: Details
            Padding(
              padding: EdgeInsets.all(20.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Rating Row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title ?? "Title",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            height: 1.2.h,
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children:  [
                          Text(
                            '${rating ?? 0}',
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 18.sp,
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  // Subtitle Row
                  Text(
                    "${subtitle ?? 'Subtitle'} • ${distance ?? 0} ${distanceUnit ?? 'km'}",
                    style: TextStyle(
                      color: AppTheme.text3,
                      fontSize: 15.sp,
                    ),
                  ),


                  SizedBox(height: 20.h),

                  // Join Table Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // height: 27.h,
                        // width: 27.h,
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.inputBackground.withValues(alpha: 0.5),
                        ),
                        child: Text(
                          "${current ?? 0}/${maximum ?? 0}",
                          style: TextStyle(
                            color: AppTheme.text1,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(
                        // width: double.infinity,
                        height: 56.h,
                        child: OutlinedButton(
                          onPressed: () {

                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: AppTheme.accent.withValues(alpha: 0.05),
                            side: BorderSide(color: AppTheme.accent, width: 2.w),
                            shape: const StadiumBorder(),
                          ),
                          child: Text(
                            "View Table",
                            style: TextStyle(
                              color: AppTheme.accent,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class DraggableDotIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final PageController pageController;

  const DraggableDotIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Ensures the empty space between dots is also draggable
      behavior: HitTestBehavior.opaque,

      // Handles the drag/scrubbing motion
      onHorizontalDragUpdate: (details) {
        _handleDragOrTap(context, details.localPosition.dx, isDragging: true);
      },

      // Handles a simple tap
      onTapUp: (details) {
        _handleDragOrTap(context, details.localPosition.dx, isDragging: false);
      },

      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        child: Row(
          mainAxisSize: MainAxisSize.min, // Keeps the hit-box tight around the dots
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            itemCount,
                (index) => AnimatedContainer(
              // Faster animation for dragging responsiveness
              duration: const Duration(milliseconds: 150),
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              height: 8.h,
              width: currentIndex == index ? 24.w : 8.w,
              decoration: BoxDecoration(
                color: currentIndex == index
                    ? AppTheme.accent
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleDragOrTap(BuildContext context, double dx, {required bool isDragging}) {
    // Get the total width of the dot row
    final box = context.findRenderObject() as RenderBox;
    final double width = box.size.width;

    // Calculate which index the finger is currently over
    int targetIndex = ((dx / width) * itemCount).clamp(0, itemCount - 1).toInt();

    // Only update if we actually moved to a new dot
    if (targetIndex != currentIndex) {
      if (isDragging) {
        // Fast animation for real-time scrubbing
        pageController.animateToPage(
          targetIndex,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      } else {
        // Standard animation for a simple tap
        pageController.animateToPage(
          targetIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }
}