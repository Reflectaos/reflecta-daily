import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../profile/presentation/providers/profile_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user    = ref.watch(authServiceProvider).currentUser;
    final profile = ref.watch(profileProvider);
    final streak  = ref.watch(streakProvider);
    final name    = profile.valueOrNull?['name'] ?? user?.displayName ?? 'amigo';
    final days    = streak.valueOrNull ?? 0;

    return Scaffold(
      backgroundColor: AppColors.navyBlue,
      body: SafeArea(
        child: Column(
          children: [
            _Header(name: name, ref: ref)
              .animate().fadeIn(duration: 400.ms).slideY(begin: -0.2, end: 0),
            const SizedBox(height: 20),
            _StreakCard(days: days)
              .animate().fadeIn(delay: 150.ms, duration: 400.ms).slideY(begin: 0.2, end: 0),
            const Spacer(),
            _GreetingSection()
              .animate().fadeIn(delay: 300.ms, duration: 400.ms).slideY(begin: 0.2, end: 0),
            const Spacer(),
            _StartButton()
              .animate().fadeIn(delay: 450.ms, duration: 400.ms).slideY(begin: 0.3, end: 0),
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

  String _greeting() {
    final h = DateTime.now().hour;
    if (h < 12) return 'Buenos dias';
    if (h < 18) return 'Buenas tardes';
    return 'Buenas noches';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(_greeting(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.grey300)),
            Text('$name ✨',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.white, fontWeight: FontWeight.w800)),
          ]),
          Row(children: [
            IconButton(
              icon: const Icon(Icons.info_outline, color: AppColors.grey300),
              onPressed: () => context.push(AppRoutes.about),
            ),
            GestureDetector(
              onTap: () => context.push(AppRoutes.profile),
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.navyLight,
                child: Icon(Icons.person_outline, color: AppColors.grey300, size: 18),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  final int days;
  const _StreakCard({required this.days});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColors.navyLight, borderRadius: BorderRadius.circular(16)),
        child: Row(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('$days',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppColors.gold, fontWeight: FontWeight.w800, height: 1)),
            Text('dias seguidos',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey300)),
          ]),
          const Spacer(),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text('Racha activa',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey300)),
            const SizedBox(height: 6),
            Row(
              children: List.generate(days.clamp(0, 7), (i) => Container(
                width: 10, height: 10,
                margin: const EdgeInsets.only(left: 3),
                decoration: BoxDecoration(color: AppColors.gold, borderRadius: BorderRadius.circular(3)),
              ).animate(delay: (i * 80).ms).fadeIn().scale()),
            ),
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
        Text('Como estuvo tu dia?',
          style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: AppColors.white, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text('Cuentame, y juntos lo reflexionamos.',
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
        label: const Text('Comenzar mi reflexion'),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.navyLight))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(icon: Icons.home_outlined,      active: true,  onTap: () {}),
          _NavItem(icon: Icons.menu_book_outlined, active: false, onTap: () => context.push(AppRoutes.history)),
          _NavItem(icon: Icons.person_outline,     active: false, onTap: () => context.push(AppRoutes.profile)),
        ],
      ),
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
