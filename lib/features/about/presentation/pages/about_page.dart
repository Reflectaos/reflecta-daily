import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
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
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AppBrandCard(context),
            const SizedBox(height: 16),
            _CreatorCard(context),
            const SizedBox(height: 16),
            _QuoteCard(context),
            const SizedBox(height: 16),
            _BookCard(context),
            const SizedBox(height: 16),
            _InfoCard(context),
            const SizedBox(height: 24),
            _AIDisclaimer(context),
          ],
        ),
      ),
    );
  }

  Widget _AppBrandCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.navyLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.gold.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Container(
            width: 72, height: 72,
            decoration: BoxDecoration(
              color: AppColors.gold,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.auto_awesome, color: AppColors.navyBlue, size: 36),
          ),
          const SizedBox(height: 12),
          Text('Reflecta Daily',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.white, fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text('Tu espejo espiritual diario',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.grey300)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.gold.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.gold.withOpacity(0.4)),
            ),
            child: Text('MVP v1.0 · 2026',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.gold, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _CreatorCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.navyLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.person_outline, color: AppColors.gold, size: 16),
            const SizedBox(width: 6),
            Text('CREADOR Y DISEÑADOR',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.gold, letterSpacing: 0.8, fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 16),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: 56, height: 56,
              decoration: BoxDecoration(
                color: AppColors.gold,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text('CS',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.navyBlue, fontWeight: FontWeight.w800)),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Carlos Sandoval',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.white, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text('Escritor · Creador de contenido',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.grey300)),
                  const SizedBox(height: 8),
                  Wrap(spacing: 6, runSpacing: 6, children: [
                    _Chip('Autor publicado'),
                    _Chip('Reflecta AI'),
                    _Chip('Fe & propósito'),
                  ]),
                ],
              ),
            ),
          ]),
          const SizedBox(height: 16),
          Text(
            'Escritor y creador de contenido, pero sobre todo un mensajero con propósito. '
            'Cree profundamente en el poder transformador de las palabras para sanar heridas, '
            'despertar conciencias y guiar vidas hacia una mejor versión.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.grey100, height: 1.6)),
        ],
      ),
    );
  }

  Widget _QuoteCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.navyLight,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: AppColors.gold, width: 3)),
      ),
      child: Text(
        '"Si con una sola frase puedo tocar un corazón y acercarlo más a Dios, '
        'entonces estoy cumpliendo mi llamado."',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: AppColors.white, fontStyle: FontStyle.italic, height: 1.6)),
    );
  }

  Widget _BookCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.navyLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.menu_book_outlined, color: AppColors.gold, size: 16),
            const SizedBox(width: 6),
            Text('LIBRO PUBLICADO',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.gold, letterSpacing: 0.8, fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 12),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: 44, height: 60,
              decoration: BoxDecoration(
                color: AppColors.navyBlue,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.gold.withOpacity(0.4)),
              ),
              child: const Icon(Icons.book, color: AppColors.gold, size: 22),
            ),
            const SizedBox(width: 14),
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
                      color: AppColors.gold.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.gold.withOpacity(0.3)),
                    ),
                    child: Text('PDF Digital',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.gold)),
                  ),
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _InfoCard(BuildContext context) {
    final items = [
      ['Proyecto', 'Reflecta AI — Reflecta Daily'],
      ['Versión', 'MVP v1.0'],
      ['Año', '2026'],
      ['Plataforma', 'Web · Mobile (Flutter)'],
      ['IA', 'Groq — llama-3.3-70b'],
    ];
    return Container(
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
            Text('INFO DEL PROYECTO',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.gold, letterSpacing: 0.8, fontWeight: FontWeight.w700)),
          ]),
          const SizedBox(height: 12),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item[0],
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey300)),
                Text(item[1],
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.white, fontWeight: FontWeight.w600)),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _AIDisclaimer(BuildContext context) {
    return Center(
      child: Column(children: [
        const Icon(Icons.auto_awesome, color: AppColors.gold, size: 16),
        const SizedBox(height: 6),
        Text('Desarrollado con IA · Diseñado con propósito',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey600)),
        const SizedBox(height: 4),
        Text('© 2026 Carlos Sandoval · Reflecta AI',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey600)),
      ]),
    );
  }

  Widget _Chip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.gold.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.gold.withOpacity(0.35)),
      ),
      child: Text(label,
        style: const TextStyle(color: AppColors.gold, fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }
}
