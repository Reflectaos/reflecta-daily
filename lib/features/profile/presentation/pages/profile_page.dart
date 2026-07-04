import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../providers/profile_provider.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});
  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final _nameCtrl = TextEditingController();
  bool _initialized = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user     = ref.watch(authServiceProvider).currentUser;
    final profile  = ref.watch(profileProvider);
    final streak   = ref.watch(streakProvider);
    final notifier = ref.watch(profileNotifierProvider);

    profile.whenData((data) {
      if (!_initialized && data != null) {
        _nameCtrl.text = data['name'] ?? user?.displayName ?? '';
        _initialized = true;
      }
    });

    return Scaffold(
      backgroundColor: AppColors.navyBlue,
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        title: Text('Mi perfil',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_outlined, color: AppColors.grey300),
            onPressed: () => ref.read(authNotifierProvider.notifier).signOut(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
        child: Column(
          children: [
            _AvatarSection(user: user),
            const SizedBox(height: 24),
            _StreakCard(streak: streak),
            const SizedBox(height: 16),
            _NameField(controller: _nameCtrl),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () => context.push(AppRoutes.notifications),
              icon: const Icon(Icons.notifications_outlined, size: 18, color: AppColors.gold),
              label: const Text('Recordatorio diario', style: TextStyle(color: AppColors.gold)),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 52),
                side: const BorderSide(color: AppColors.gold),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: notifier.loading ? null : () async {
                await ref.read(profileNotifierProvider.notifier).save(_nameCtrl.text.trim());
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Perfil guardado'),
                      backgroundColor: AppColors.navyLight,
                      duration: Duration(seconds: 2),
                    ),
                  );
                  ref.invalidate(profileProvider);
                  await Future.delayed(const Duration(seconds: 2));
                  if (mounted) context.go(AppRoutes.home);
                }
              },
              child: notifier.loading
                ? const SizedBox(width: 20, height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.navyBlue))
                : const Text('Guardar perfil'),
            ),
          ],
        ),
      ),
    );
  }
}

class _AvatarSection extends StatelessWidget {
  final dynamic user;
  const _AvatarSection({required this.user});

  @override
  Widget build(BuildContext context) {
    final photoUrl = user?.photoURL ?? '';
    return Column(
      children: [
        Container(
          width: 88, height: 88,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.gold, width: 2),
          ),
          child: ClipOval(
            child: photoUrl.isNotEmpty
              ? Image.network(photoUrl, fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => _initials(context, user?.displayName))
              : _initials(context, user?.displayName),
          ),
        ),
        const SizedBox(height: 12),
        Text(user?.email ?? '',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey300)),
      ],
    );
  }

  Widget _initials(BuildContext context, String? name) {
    final initials = (name ?? 'U').trim().split(' ')
      .take(2).map((w) => w.isNotEmpty ? w[0].toUpperCase() : '').join();
    return Container(
      color: AppColors.gold,
      child: Center(
        child: Text(initials,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.navyBlue, fontWeight: FontWeight.w800)),
      ),
    );
  }
}

class _StreakCard extends StatelessWidget {
  final AsyncValue<int> streak;
  const _StreakCard({required this.streak});

  @override
  Widget build(BuildContext context) {
    final days = streak.valueOrNull ?? 0;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.navyLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$days',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: AppColors.gold, fontWeight: FontWeight.w800, height: 1)),
              Text('dias seguidos',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.grey300)),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Racha activa',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.grey300)),
              const SizedBox(height: 6),
              Row(
                children: List.generate(days.clamp(0, 7), (i) => Container(
                  width: 10, height: 10,
                  margin: const EdgeInsets.only(left: 3),
                  decoration: BoxDecoration(
                    color: AppColors.gold,
                    borderRadius: BorderRadius.circular(3),
                  ),
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NameField extends StatelessWidget {
  final TextEditingController controller;
  const _NameField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tu nombre',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey300)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: const TextStyle(color: AppColors.white),
          decoration: InputDecoration(
            hintText: 'Como te llamas?',
            hintStyle: const TextStyle(color: AppColors.grey600),
            prefixIcon: const Icon(Icons.person_outline, color: AppColors.grey600),
            filled: true,
            fillColor: AppColors.navyLight,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.gold, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
