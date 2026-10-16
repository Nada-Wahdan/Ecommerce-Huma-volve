import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/sign_up_screen.dart';
import '../../features/details/screens/product_details_screen.dart';
import '../../features/main_navigation/screens/main_navigation_screen.dart';
import '../../features/splash/screens/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/signup', builder: (context, state) => const SignUpScreen()),
    GoRoute(
      path: '/home',
      builder: (context, state) => const MainNavigationScreen(),
    ),
    GoRoute(
      path: '/products/:id',
      builder: (context, state) {
        final productId = int.tryParse(state.pathParameters['id'] ?? '');

        if (productId == null) {
          return const _InvalidProductRoute();
        }

        return ProductDetailsScreen(productId: productId);
      },
    ),
  ],
);

class _InvalidProductRoute extends StatelessWidget {
  const _InvalidProductRoute();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Invalid product link')));
  }
}
