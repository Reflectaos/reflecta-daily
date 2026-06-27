import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

class ResultPage extends StatelessWidget {
  final Map<String, dynamic> data;
  const ResultPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navyBlue,
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => context.pop(),
        ),
        title: Text('Tu reflexión',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
        child: Column(
          children: [
            _ReflectionCard(
              icon: Icons.visibility_outlined,
              label: 'Reflexión',
              content: 'Dios permite pruebas laborales para moldear tu carácter. Tu reacción ante la presión revela tu nivel de madurez espiritual.',
            ),
            const SizedBox(height: 12),
            _VerseCard(
              verse: '"Todo lo puedo en Cristo que me fortalece."',
              reference: 'Filipenses 4:13',
            ),
            const SizedBox(height: 12),
            _ReflectionCard(
              icon: Icons.lightbulb_outline,
              label: 'Insight espiritual',
              content: 'El conflicto laboral no es una señal de fracaso. Es una oportunidad de mostrar la gracia de Dios en espacios seculares.',
            ),
            const SizedBox(height: 12),
            _ActionPlanCard(
              actions: [
                'Ora por tu jefe esta noche con intención real',
                'Responde con calma mañana, antes de reaccionar',
                'Lee Proverbios 15 esta semana',
              ],
            ),
            const SizedBox(height: 24),
            _SaveButton(),
          ],
        ),
      ),
    );
  }
}

class _ReflectionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String content;
  const _ReflectionCard({required this.icon, required this.label, required this.content});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(icon, color: AppColors.gold, size: 16),
            const SizedBox(width: 6),
            Text(label.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.gold, letterSpacing: 0.8, fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 8),
          Text(content,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.grey100, height: 1.6)),
        ],
      ),
    );
  }
}

class _VerseCard extends StatelessWidget {
  final String verse;
  final String reference;
  const _VerseCard({required this.verse, required this.reference});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.navyLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gold.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.menu_book_outlined, color: AppColors.gold, size: 16),
            const SizedBox(width: 6),
            Text('VERSÍCULO',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.gold, letterSpacing: 0.8, fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 10),
          Text(verse,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.white, fontStyle: FontStyle.italic, height: 1.5)),
          const SizedBox(height: 6),
          Text(reference,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey300)),
        ],
      ),
    );
  }
}

class _ActionPlanCard extends StatelessWidget {
  final List<String> actions;
  const _ActionPlanCard({required this.actions});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.track_changes_outlined, color: AppColors.gold, size: 16),
            const SizedBox(width: 6),
            Text('PLAN DE ACCIÓN',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.gold, letterSpacing: 0.8, fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 10),
          ...actions.map((a) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 6, right: 10),
                  width: 6, height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.gold, shape: BoxShape.circle),
                ),
                Expanded(
                  child: Text(a,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.grey100, height: 1.5)),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.bookmark_border, size: 18, color: AppColors.gold),
      label: const Text('Guardar reflexión', style: TextStyle(color: AppColors.gold)),
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 52),
        side: const BorderSide(color: AppColors.gold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}
