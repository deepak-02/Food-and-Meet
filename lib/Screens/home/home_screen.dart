import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/app_theme.dart';
import '../../widgets/starting_soon_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  // Variables for the PageView and Indicator
  int _currentIndex = 0;
  final PageController _pageController = PageController(viewportFraction: 0.95);
  late List<Map<String, dynamic>> _generatedCards;

  // Initialize the random number generator
  final Random _random = Random();

  // Predefined lists to pick random text from
  final List<String> _titles = [
    "Shifu's Momos",
    "Dragon Wok",
    "Spicy Corner",
    "The Noodle Bowl",
    "Bao Bar"
  ];

  final List<String> _subtitles = [
    "Panampilly Nagar",
    "Kakkanad",
    "Edappally",
    "Fort Kochi",
    "Marine Drive"
  ];

  final List<String> _foods = [
    "assets/images/ramen.png",
    "assets/images/food1.jpg",
    "assets/images/food2.jpg",
    "assets/images/food3.jpg",
    "assets/images/food4.jpg",
    "assets/images/food5.jpg",
    "assets/images/food6.jpg",
    "assets/images/food7.jpg",
    "assets/images/food8.jpg",
    "assets/images/food9.jpg",
    "assets/images/food10.jpg",
  ];

  final List<String> _times = ["6:30 PM", "7:00 PM", "7:45 PM", "8:15 PM", "9:00 PM"];
  final List<String> _genders = ["male", "female", "any"];

  @override
  void initState() {
    super.initState();
    // 1. Generate the random data ONCE when the screen loads
    _generatedCards = List.generate(10, (index) {
      final int maxPeople = _random.nextInt(5) + 2;
      return {
        'image': _foods[_random.nextInt(_foods.length)],
        'title': _titles[_random.nextInt(_titles.length)],
        'subtitle': _subtitles[_random.nextInt(_subtitles.length)],
        'distance': double.parse((_random.nextDouble() * 8 + 0.5).toStringAsFixed(1)),
        'time': _times[_random.nextInt(_times.length)],
        'maximum': maxPeople,
        'current': _random.nextInt(maxPeople) + 1,
        'rating': double.parse((_random.nextDouble() * 1.5 + 3.5).toStringAsFixed(1)),
        'genderPreference': _genders[_random.nextInt(_genders.length)],
      };
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Precache all the images we just generated so they load instantly on scroll
    for (var card in _generatedCards) {
      precacheImage(AssetImage(card['image']), context);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppTheme.accent.withValues(alpha: 0.05),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Column(
              children: [

                // Profile bar section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 24.sp,
                          backgroundColor: AppTheme.accent,
                          child: CircleAvatar(
                            radius: 22.sp,
                            backgroundColor: Colors.grey[300],
                            child: Padding(
                              padding: EdgeInsets.all(8.sp),
                              child: Icon(
                                Icons.person,
                                size: 24.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.sp),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 250.sp,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      size: 14.sp,
                                      color: Colors.grey[600],
                                    ),
                                    Text(
                                      "Location",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.accent.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Stack(
                          children: [
                            const Icon(Icons.notifications),
                            Positioned(
                              top: 0,
                              right: 2,
                              child: Container(
                                width: 8.sp,
                                height: 8.sp,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        color: AppTheme.accent,
                        iconSize: 26.sp,
                        onPressed: () {
                          debugPrint('Notification icon tapped!');
                        },
                      ),
                    ),


                  ],
                ),

                // Search bar section
                SizedBox(height: 16.sp),
                Container(
                  padding: EdgeInsets.all(16.sp),
                  // height: 56.h,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppTheme.accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(30.sp),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        size: 26.sp,
                        color: AppTheme.accent,
                      ),
                      SizedBox(width: 8.sp),
                      Text(
                        "Search",
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: AppTheme.text2,
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(height: 16.sp),

                // Starting Soon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Starting Soon",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8.sp),
                            Container(
                              padding: EdgeInsets.all(4.sp),
                              decoration: BoxDecoration(
                                color: AppTheme.accent,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Meetups starting within 2hours",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppTheme.text3,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),

                    Text(
                      "See All",
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppTheme.accent,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.sp),


                SizedBox(
                  height: 420.h,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _generatedCards.length,
                      pageSnapping: false,
                      physics: const BouncingScrollPhysics(),
                    onPageChanged: (index) {
                      // Update the state so the dots redraw
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final cardData = _generatedCards[index];
                      return StartingSoonCard(
                        image: cardData['image'],
                        title: cardData['title'],
                        subtitle: cardData['subtitle'],
                        distance: cardData['distance'],
                        distanceUnit: "km",
                        time: cardData['time'],
                        maximum: cardData['maximum'],
                        current: cardData['current'],
                        rating: cardData['rating'],
                        genderPreference: cardData['genderPreference'],
                      );
                    },
                  ),
                ),

                SizedBox(height: 16.h),

                // 3. The Animated Dot Indicator
                DraggableDotIndicator(
                  itemCount: _generatedCards.length,
                  currentIndex: _currentIndex,
                  pageController: _pageController,
                ),

                SizedBox(height: 24.h),


              ],
            ),
          ),
        ),
      ),
    );
  }
}

