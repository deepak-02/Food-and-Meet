import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food/router/router.dart';
import 'package:food/theme/app_theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔒 Lock orientation
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // 1. SET THE SIZE CALCULATED FROM YOUR EMULATOR
      designSize: const Size(411.4, 914.3),

      // 2. ENSURE TEXT ADAPTS (Crucial for accessibility)
      minTextAdapt: true,

      // 3. ALLOW SPLIT SCREEN (Good for foldable support later)
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.dark,
          routerConfig: appRouter,
        );
      },
    );
  }
}
