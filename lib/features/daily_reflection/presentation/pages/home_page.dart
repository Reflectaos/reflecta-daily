import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).valueOrNull;
    final displayName = user?.displayName?.split(' ').first
        ?? user?.email?.split('@').first
        ?? 'amigo';

    return Scaffold(
      backgroundColor: AppColors.navyBlue,
      body: SafeArea(
        child: Column(
          children: [
            _Header(name: displayName, ref: ref),
            const SizedBox(height: 20),
            _StreakCard(),
            const Spacer(),
            _GreetingSection(),
            const Spacer(),
            _StartButton(),
            _BottomNav(),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String name;
  final WidgetRef ref;
  const _Header({required this.name, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Buenos días',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.grey300)),
            Text('$name ✨',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.white, fontWeight: FontWeight.w800)),
          ]),
          GestureDetector(
            onTap: () => context.push(AppRoutes.about),
            child: const CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.navyLight,
              child: Icon(Icons.person_outline, color: AppColors.grey300, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.navyLight,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('7',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppColors.gold, fontWeight: FontWeight.w800, height: 1)),
            Text('días seguidos',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey300)),
          ]),
          const Spacer(),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text('Racha activa',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey300)),
            const SizedBox(height: 6),
            Row(children: List.generate(7, (i) => Container(
              width: 10, height: 10,
              margin: const EdgeInsets.only(left: 3),
              decoration: BoxDecoration(color: AppColors.gold, borderRadius: BorderRadius.circular(3)),
            ))),
          ]),
        ]),
      ),
    );
  }
}

class _GreetingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('¿Cómo estuvo tu día?',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: AppColors.white, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text('Cuéntame, y juntos lo reflexionamos.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.grey300)),
      ]),
    );
  }
}

class _StartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
      child: ElevatedButton.icon(
        onPressed: () => context.push(AppRoutes.reflection),
        icon: const Icon(Icons.edit_outlined, size: 18),
        label: const Text('Comenzar mi reflexión'),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.navyLight)),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        _NavItem(icon: Icons.home_outlined,     active: true,  onTap: () {}),
        _NavItem(icon: Icons.menu_book_outlined, active: false, onTap: () {}),
        _NavItem(icon: Icons.person_outline,     active: false,
          onTap: () => context.push(AppRoutes.about)),
      ]),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final bool active;
  final VoidCallback onTap;
  const _NavItem({required this.icon, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, color: active ? AppColors.gold : AppColors.grey600, size: 24),
        if (active)
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 4, height: 4,
            decoration: const BoxDecoration(color: AppColors.gold, shape: BoxShape.circle),
          ),
      ]),
    );
  }
}
