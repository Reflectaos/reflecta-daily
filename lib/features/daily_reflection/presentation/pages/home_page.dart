import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navyBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text('¿Cómo estuvo tu día?',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.white, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Text('Cuéntame, y juntos lo reflexionamos.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.grey300)),
              const Spacer(),
              ElevatedButton(
                onPressed: () => context.push(AppRoutes.reflection),
                child: const Text('Comenzar mi reflexión'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
