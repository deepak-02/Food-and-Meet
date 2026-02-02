import 'package:go_router/go_router.dart';

import '../Screens/auth/login_screen.dart';
import '../Screens/auth/register_screen.dart';
import '../Screens/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),

    // Future registration flow
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
  ],
);
