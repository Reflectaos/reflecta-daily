import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_theme.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navyBlue,
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        title: Text('Acerca de',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
        child: Column(
          children: [
            _HeroCard(context),
            const SizedBox(height: 16),
            _QuoteCard(context),
            const SizedBox(height: 16),
            _InfoGrid(context),
            const SizedBox(height: 16),
            _BookCard(context),
            const SizedBox(height: 16),
            _AppCard(context),
            const SizedBox(height: 16),
            _FooterCard(context),
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
      ),
      child: Column(
        children: [
          Container(
            width: 80, height: 80,
            decoration: const BoxDecoration(
              color: AppColors.gold,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text('CS',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppColors.navyBlue, fontWeight: FontWeight.w800)),
            ),
          ),
          const SizedBox(height: 16),
          Text('Carlos Sandoval',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.white, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text('Escritor · Creador de contenido · Fundador de Reflecta AI',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.grey300),
            textAlign: TextAlign.center),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8, runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [
              _Badge('Reflecta Daily'),
              _Badge('Autor publicado'),
              _Badge('Desarrollado con IA'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _QuoteCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.navyLight,
        borderRadius: BorderRadius.circular(16),
        border: const Border(left: BorderSide(color: AppColors.gold, width: 3)),
      ),
      child: Text(
        '"Si con una sola frase puedo tocar un corazón y acercarlo más a Dios, entonces estoy cumpliendo mi llamado."',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: AppColors.grey100, fontStyle: FontStyle.italic, height: 1.7),
      ),
    );
  }

  Widget _InfoGrid(BuildContext context) {
    final items = [
      (Icons.favorite_outline, 'Misión',
        'Mensajero con propósito. Conectar de corazón a corazón y dejar una huella que trascienda el tiempo.'),
      (Icons.auto_awesome_outlined, 'Visión',
        'Herramientas de IA que combinan tecnología avanzada con valores bíblicos para guiar a jóvenes.'),
      (Icons.menu_book_outlined, 'Inspiración',
        'Inspirado en la Palabra de Dios. Escribe con honestidad desde las trincheras de la vida real.'),
      (Icons.track_changes_outlined, 'Enfoque',
        'Crecimiento personal, fe real, finanzas sanas y propósito claro conectado con Dios.'),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.1,
      children: items.map((item) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.navyLight,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(item.$1, color: AppColors.gold, size: 20),
            const SizedBox(height: 8),
            Text(item.$2,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.gold, letterSpacing: 0.8, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Expanded(
              child: Text(item.$3,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.grey300, height: 1.5),
                overflow: TextOverflow.fade),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _BookCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.navyLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 52, height: 68,
            decoration: BoxDecoration(
              color: AppColors.navyBlue,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.gold.withOpacity(0.3)),
            ),
            child: const Icon(Icons.menu_book, color: AppColors.gold, size: 26),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Volver a Empezar',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.white, fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text('Cómo salir de las deudas, recuperar tu propósito y convertirte en la persona que tu familia necesita.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.grey300, height: 1.5)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.gold.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.gold.withOpacity(0.4)),
                  ),
                  child: Text('Libro publicado · PDF digital',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.gold, fontSize: 11)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _AppCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.navyLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.info_outline, color: AppColors.gold, size: 16),
            const SizedBox(width: 6),
            Text('SOBRE REFLECTA DAILY',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.gold, letterSpacing: 0.8, fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 12),
          Text(
            'Reflecta Daily es la primera herramienta de Reflecta AI — una plataforma diseñada para jóvenes cristianos que buscan crecer en disciplina, conocimiento y propósito.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.grey100, height: 1.6)),
        ],
      ),
    );
  }

  Widget _FooterCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.navyLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _FooterItem(context, 'Proyecto', 'Reflecta AI'),
              _FooterItem(context, 'Versión', 'MVP v1.0'),
              _FooterItem(context, 'Año', '2026'),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: AppColors.navyBlue),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => launchUrl(Uri.parse('https://reflecta.zone')),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.language, color: AppColors.gold, size: 16),
                const SizedBox(width: 6),
                Text('reflecta.zone',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.gold, decoration: TextDecoration.underline,
                    decorationColor: AppColors.gold)),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text('Desarrollado con IA · © 2026 Carlos Sandoval',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.grey600),
            textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _FooterItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey600)),
        const SizedBox(height: 2),
        Text(value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.white, fontWeight: FontWeight.w700)),
      ],
    );
  }

  Widget _Badge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.gold.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.gold.withOpacity(0.35)),
      ),
      child: Text(text,
        style: const TextStyle(color: AppColors.gold, fontSize: 12)),
    );
  }
}
