import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/daily_reflection/presentation/pages/home_page.dart';
import '../../features/daily_reflection/presentation/pages/reflection_page.dart';
import '../../features/daily_reflection/presentation/pages/result_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';

abstract class AppRoutes {
  static const onboarding = '/onboarding';
  static const login      = '/login';
  static const home       = '/';
  static const reflection = '/reflection';
  static const result     = '/result';
}

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(path: AppRoutes.onboarding, builder: (c, s) => const OnboardingPage()),
      GoRoute(path: AppRoutes.login,      builder: (c, s) => const LoginPage()),
      GoRoute(path: AppRoutes.home,       builder: (c, s) => const HomePage()),
      GoRoute(path: AppRoutes.reflection, builder: (c, s) => const ReflectionPage()),
      GoRoute(path: AppRoutes.result,     builder: (c, s) => ResultPage(data: s.extra as Map<String, dynamic>? ?? {})),
    ],
  );
});
