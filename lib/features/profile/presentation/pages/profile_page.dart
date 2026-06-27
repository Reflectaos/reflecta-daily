import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider).valueOrNull;

    return Scaffold(
      backgroundColor: AppColors.navyBlue,
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        title: Text('Perfil',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
        child: Column(
          children: [
            _UserCard(user: user),
            const SizedBox(height: 20),
            const _Divider(label: 'CREADO POR'),
            const SizedBox(height: 16),
            const _CreatorCard(),
            const SizedBox(height: 20),
            const _Divider(label: 'ACERCA DE REFLECTA'),
            const SizedBox(height: 16),
            const _AboutCard(),
            const SizedBox(height: 24),
            const _SignOutButton(),
          ],
        ),
      ),
    );
  }
}

// ── Tarjeta del usuario autenticado ──────────────────────
class _UserCard extends StatelessWidget {
  final dynamic user;
  const _UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    final name  = user?.displayName ?? 'Usuario';
    final email = user?.email ?? '';
    final initials = name.trim().isNotEmpty
      ? name.trim().split(' ').take(2).map((w) => w[0].toUpperCase()).join()
      : 'U';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.navyLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: AppColors.gold,
            backgroundImage: user?.photoURL != null
              ? NetworkImage(user!.photoURL!) : null,
            child: user?.photoURL == null
              ? Text(initials,
                  style: const TextStyle(
                    color: AppColors.navyBlue,
                    fontWeight: FontWeight.w800,
                    fontSize: 18))
              : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.white, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(email,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.grey300)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Tarjeta del creador ───────────────────────────────────
class _CreatorCard extends StatelessWidget {
  const _CreatorCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.navyLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gold.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          // Header azul marino
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: AppColors.navyBlue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.gold,
                  child: Text('CS',
                    style: const TextStyle(
                      color: AppColors.navyBlue,
                      fontWeight: FontWeight.w800,
                      fontSize: 16)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Carlos Sandoval',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.white, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 4),
                      Text('Escritor · Creador · Fundador Reflecta AI',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.grey300)),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Quote
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.navyBlue,
                borderRadius: BorderRadius.circular(10),
                border: Border(left: BorderSide(color: AppColors.gold, width: 3)),
              ),
              child: Text(
                '"Si con una sola frase puedo tocar un corazón y acercarlo más a Dios, entonces estoy cumpliendo mi llamado."',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.grey100,
                  fontStyle: FontStyle.italic,
                  height: 1.6),
              ),
            ),
          ),

          // Info chips
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Wrap(
              spacing: 8, runSpacing: 8,
              children: [
                _Chip(icon: Icons.book_outlined, label: 'Autor: Volver a Empezar'),
                _Chip(icon: Icons.favorite_outline, label: 'Misión: conectar corazones'),
                _Chip(icon: Icons.auto_awesome_outlined, label: 'Desarrollado con IA'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Chip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.navyBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 13, color: AppColors.gold),
        const SizedBox(width: 5),
        Text(label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.grey300, fontSize: 11)),
      ]),
    );
  }
}

// ── Acerca de la app ──────────────────────────────────────
class _AboutCard extends StatelessWidget {
  const _AboutCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.navyLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _AboutRow(icon: Icons.auto_awesome, label: 'App', value: 'Reflecta Daily'),
          _AboutRow(icon: Icons.tag, label: 'Versión', value: 'MVP v1.0 · 2026'),
          _AboutRow(icon: Icons.language, label: 'Web', value: 'reflecta.study'),
          _AboutRow(icon: Icons.psychology_outlined, label: 'IA', value: 'Groq · llama-3.3-70b'),
          _AboutRow(icon: Icons.code, label: 'Stack', value: 'Flutter + Firebase', last: true),
        ],
      ),
    );
  }
}

class _AboutRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool last;
  const _AboutRow({required this.icon, required this.label, required this.value, this.last = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(children: [
            Icon(icon, size: 16, color: AppColors.gold),
            const SizedBox(width: 10),
            Text(label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey300)),
            const Spacer(),
            Text(value,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.white, fontWeight: FontWeight.w600)),
          ]),
        ),
        if (!last)
          const Divider(height: 1, color: AppColors.navyBlue),
      ],
    );
  }
}

// ── Helpers visuales ──────────────────────────────────────
class _Divider extends StatelessWidget {
  final String label;
  const _Divider({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Expanded(child: Divider(color: AppColors.navyLight, thickness: 1)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.grey600, fontSize: 10, letterSpacing: 0.8)),
      ),
      const Expanded(child: Divider(color: AppColors.navyLight, thickness: 1)),
    ]);
  }
}

class _SignOutButton extends ConsumerWidget {
  const _SignOutButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton.icon(
      onPressed: () => ref.read(authNotifierProvider.notifier).signOut(),
      icon: const Icon(Icons.logout, size: 18, color: AppColors.grey300),
      label: const Text('Cerrar sesión', style: TextStyle(color: AppColors.grey300)),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 52),
        side: const BorderSide(color: AppColors.navyLight),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
