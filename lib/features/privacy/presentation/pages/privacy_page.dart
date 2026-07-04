import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

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
        title: Text('Privacidad y confidencialidad',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeroCard(context),
            const SizedBox(height: 16),
            _PolicyCard(context,
              icon: Icons.lock_outline,
              title: 'Tus reflexiones son privadas',
              body: 'Todo lo que escribes o hablas en Reflecta Daily es estrictamente tuyo. Nadie mas, incluyendo al equipo de Reflecta, tiene acceso a tus reflexiones personales.',
            ),
            const SizedBox(height: 12),
            _PolicyCard(context,
              icon: Icons.storage_outlined,
              title: 'Tus datos son solo tuyos',
              body: 'Tus reflexiones se guardan de forma segura en tu cuenta personal de Firebase. Solo tu, con tu usuario autenticado, puedes acceder a ellas. No existen copias publicas ni compartidas.',
            ),
            const SizedBox(height: 12),
            _PolicyCard(context,
              icon: Icons.share_outlined,
              title: 'No compartimos tu informacion',
              body: 'Reflecta AI no vende, comparte ni transfiere tu informacion personal a terceros. Tu nombre, correo y reflexiones jamas seran usados con fines comerciales ni publicitarios.',
            ),
            const SizedBox(height: 12),
            _PolicyCard(context,
              icon: Icons.psychology_outlined,
              title: 'La IA no guarda tu conversacion',
              body: 'Cuando envias tu reflexion a la IA (Groq), el texto se procesa en el momento y no se almacena en los servidores de IA. Cada reflexion es una conversacion nueva y aislada.',
            ),
            const SizedBox(height: 12),
            _PolicyCard(context,
              icon: Icons.verified_user_outlined,
              title: 'Autenticacion segura',
              body: 'Usamos Firebase Authentication de Google para proteger tu cuenta. Tus credenciales estan cifradas y nunca las almacenamos directamente en nuestros sistemas.',
            ),
            const SizedBox(height: 12),
            _PolicyCard(context,
              icon: Icons.delete_outline,
              title: 'Derecho a eliminar tus datos',
              body: 'En cualquier momento puedes solicitar la eliminacion completa de tu cuenta y todas tus reflexiones escribiendo a privacidad@reflecta.zone.',
            ),
            const SizedBox(height: 24),
            _CommitmentCard(context),
            const SizedBox(height: 16),
            Center(
              child: Text('reflecta.zone · privacidad@reflecta.zone',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.grey600)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _HeroCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.navyLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.gold.withOpacity(0.3)),
      ),
      child: Column(children: [
        const Icon(Icons.shield_outlined, color: AppColors.gold, size: 48),
        const SizedBox(height: 16),
        Text('Tu privacidad es sagrada',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.white, fontWeight: FontWeight.w800)),
        const SizedBox(height: 10),
        Text(
          'Reflecta Daily es un espacio seguro y confidencial. Lo que compartes aqui es entre tu y Dios.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.grey300, height: 1.6)),
      ]),
    );
  }

  Widget _PolicyCard(BuildContext context, {
    required IconData icon,
    required String title,
    required String body,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.navyLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.gold.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.gold, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.white, fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                Text(body,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.grey300, height: 1.6)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _CommitmentCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.navyLight,
        borderRadius: BorderRadius.circular(16),
        border: const Border(left: BorderSide(color: AppColors.gold, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nuestro compromiso',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.gold, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(
            'Creamos Reflecta Daily como un espacio de crecimiento espiritual autentico. Jamas traicionaremos la confianza que depositas en nosotros al compartir los momentos mas intimos de tu dia.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.grey100, height: 1.7, fontStyle: FontStyle.italic)),
          const SizedBox(height: 10),
          Text('— Carlos Sandoval, Fundador de Reflecta AI',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.grey600)),
        ],
      ),
    );
  }
}
