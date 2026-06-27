import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/daily_reflection/presentation/pages/home_page.dart';
import '../../features/daily_reflection/presentation/pages/reflection_page.dart';
import '../../features/daily_reflection/presentation/pages/result_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';

abstract class AppRoutes {
  static const login      = '/login';
  static const onboarding = '/onboarding';
  static const home       = '/';
  static const reflection = '/reflection';
  static const result     = '/result';
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: AppRoutes.home,
    redirect: (context, state) {
      final isLoggedIn = authState.valueOrNull != null;
      final isAuthRoute = state.matchedLocation == AppRoutes.login;
      if (!isLoggedIn && !isAuthRoute) return AppRoutes.login;
      if (isLoggedIn && isAuthRoute)  return AppRoutes.home;
      return null;
    },
    routes: [
      GoRoute(path: AppRoutes.login,      builder: (c, s) => const LoginPage()),
      GoRoute(path: AppRoutes.onboarding, builder: (c, s) => const OnboardingPage()),
      GoRoute(path: AppRoutes.home,       builder: (c, s) => const HomePage()),
      GoRoute(path: AppRoutes.reflection, builder: (c, s) => const ReflectionPage()),
      GoRoute(path: AppRoutes.result,     builder: (c, s) =>
        ResultPage(data: s.extra as Map<String, dynamic>? ?? {})),
    ],
  );
});
