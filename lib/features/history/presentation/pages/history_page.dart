import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../daily_reflection/presentation/providers/firestore_provider.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stream = ref.watch(reflectionsStreamProvider);

    return Scaffold(
      backgroundColor: AppColors.navyBlue,
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => context.pop(),
        ),
        title: Text('Mis reflexiones',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.white)),
      ),
      body: stream.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.gold)),
        error: (e, _) => Center(
          child: Text('Error al cargar reflexiones',
            style: TextStyle(color: AppColors.grey300))),
        data: (reflections) {
          if (reflections.isEmpty) {
            return _EmptyState();
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
            itemCount: reflections.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, i) => _ReflectionCard(
              data: reflections[i],
              onTap: () => _showDetail(context, reflections[i]),
            ),
          );
        },
      ),
    );
  }

  void _showDetail(BuildContext context, Map<String, dynamic> data) {
    final actions = (data['actionPlan'] as List<dynamic>?)?.cast<String>() ?? [];
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.navyLight,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        expand: false,
        builder: (_, ctrl) => SingleChildScrollView(
          controller: ctrl,
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40, height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.grey600,
                    borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 20),
              _DetailChip(data['createdAt']),
              const SizedBox(height: 16),
              _DetailSection(Icons.visibility_outlined, 'REFLEXIÓN', data['reflection'] ?? ''),
              const SizedBox(height: 12),
              _VerseSection(data['verse'] ?? '', data['verseReference'] ?? ''),
              const SizedBox(height: 12),
              _DetailSection(Icons.lightbulb_outline, 'INSIGHT ESPIRITUAL', data['spiritualInsight'] ?? ''),
              const SizedBox(height: 12),
              _ActionSection(actions),
              const SizedBox(height: 12),
              if ((data['userInput'] ?? '').isNotEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.navyBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
# ── Pantalla de historial ─────────────────────────────────
mkdir -p lib/features/history/presentation/pages

cat > lib/features/history/presentation/pages/history_page.dart << 'EOF'
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../daily_reflection/presentation/providers/firestore_provider.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stream = ref.watch(reflectionsStreamProvider);

    return Scaffold(
      backgroundColor: AppColors.navyBlue,
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => context.pop(),
        ),
        title: Text('Mis reflexiones',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.white)),
      ),
      body: stream.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.gold)),
        error: (e, _) => Center(
          child: Text('Error al cargar reflexiones',
            style: TextStyle(color: AppColors.grey300))),
        data: (reflections) {
          if (reflections.isEmpty) {
            return _EmptyState();
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
            itemCount: reflections.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, i) => _ReflectionCard(
              data: reflections[i],
              onTap: () => _showDetail(context, reflections[i]),
            ),
          );
        },
      ),
    );
  }

  void _showDetail(BuildContext context, Map<String, dynamic> data) {
    final actions = (data['actionPlan'] as List<dynamic>?)?.cast<String>() ?? [];
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.navyLight,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        expand: false,
        builder: (_, ctrl) => SingleChildScrollView(
          controller: ctrl,
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40, height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.grey600,
                    borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 20),
              _DetailChip(data['createdAt']),
              const SizedBox(height: 16),
              _DetailSection(Icons.visibility_outlined, 'REFLEXIÓN', data['reflection'] ?? ''),
              const SizedBox(height: 12),
              _VerseSection(data['verse'] ?? '', data['verseReference'] ?? ''),
              const SizedBox(height: 12),
              _DetailSection(Icons.lightbulb_outline, 'INSIGHT ESPIRITUAL', data['spiritualInsight'] ?? ''),
              const SizedBox(height: 12),
              _ActionSection(actions),
              const SizedBox(height: 12),
              if ((data['userInput'] ?? '').isNotEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.navyBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('LO QUE ESCRIBISTE',
                        style: TextStyle(
                          color: AppColors.grey600, fontSize: 11,
                          fontWeight: FontWeight.w700, letterSpacing: 0.8)),
                      const SizedBox(height: 6),
                      Text(data['userInput'],
                        style: TextStyle(color: AppColors.grey300, fontSize: 13, height: 1.5)),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ── Widgets ───────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.menu_book_outlined, color: AppColors.gold, size: 56),
        const SizedBox(height: 20),
        Text('Aun no tienes reflexiones',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.white)),
        const SizedBox(height: 8),
        Text('Comienza tu primer diario espiritual hoy',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.grey300)),
      ]),
    );
  }
}

class _ReflectionCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onTap;
  const _ReflectionCard({required this.data, required this.onTap});

  String _formatDate(dynamic ts) {
    if (ts == null) return '';
    try {
      final dt = (ts as Timestamp).toDate();
      final months = ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic'];
      return '${dt.day} ${months[dt.month - 1]} ${dt.year}';
    } catch (_) { return ''; }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.navyLight,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  const Icon(Icons.calendar_today_outlined,
                    size: 12, color: AppColors.gold),
                  const SizedBox(width: 6),
                  Text(_formatDate(data['createdAt']),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.gold, fontWeight: FontWeight.w600)),
                ]),
                const Icon(Icons.chevron_right, color: AppColors.grey600, size: 18),
              ],
            ),
            const SizedBox(height: 10),
            Text(data['reflection'] ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.grey100, height: 1.5)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.gold.withOpacity(0.12),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.gold.withOpacity(0.3)),
              ),
              child: Text(data['verseReference'] ?? '',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.gold, fontSize: 11)),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailChip extends StatelessWidget {
  final dynamic timestamp;
  const _DetailChip(this.timestamp);

  String _formatDate() {
    if (timestamp == null) return '';
    try {
      final dt = (timestamp as Timestamp).toDate();
      final months = ['Enero','Febrero','Marzo','Abril','Mayo','Junio',
        'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'];
      return '${dt.day} de ${months[dt.month - 1]} de ${dt.year}';
    } catch (_) { return ''; }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.navyBlue,
        borderRadius: BorderRadius.circular(20)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.calendar_today_outlined, size: 12, color: AppColors.gold),
        const SizedBox(width: 6),
        Text(_formatDate(),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey300)),
      ]),
    );
  }
}

class _DetailSection extends StatelessWidget {
  final IconData icon;
  final String label;
  final String content;
  const _DetailSection(this.icon, this.label, this.content);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.navyBlue,
        borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(icon, color: AppColors.gold, size: 14),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(
            color: AppColors.gold, fontSize: 11,
            fontWeight: FontWeight.w700, letterSpacing: 0.8)),
        ]),
        const SizedBox(height: 8),
        Text(content, style: TextStyle(
          color: AppColors.grey100, fontSize: 14, height: 1.6)),
      ]),
    );
  }
}

class _VerseSection extends StatelessWidget {
  final String verse;
  final String reference;
  const _VerseSection(this.verse, this.reference);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.navyBlue,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.gold.withOpacity(0.3))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Icon(Icons.menu_book_outlined, color: AppColors.gold, size: 14),
          const SizedBox(width: 6),
          const Text('VERSÍCULO', style: TextStyle(
            color: AppColors.gold, fontSize: 11,
            fontWeight: FontWeight.w700, letterSpacing: 0.8)),
        ]),
        const SizedBox(height: 8),
        Text(verse, style: const TextStyle(
          color: AppColors.white, fontSize: 14,
          fontStyle: FontStyle.italic, height: 1.5)),
        const SizedBox(height: 4),
        Text(reference, style: const TextStyle(
          color: AppColors.grey300, fontSize: 12)),
      ]),
    );
  }
}

class _ActionSection extends StatelessWidget {
  final List<String> actions;
  const _ActionSection(this.actions);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.navyBlue,
        borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(children: [
          Icon(Icons.track_changes_outlined, color: AppColors.gold, size: 14),
          SizedBox(width: 6),
          Text('PLAN DE ACCIÓN', style: TextStyle(
            color: AppColors.gold, fontSize: 11,
            fontWeight: FontWeight.w700, letterSpacing: 0.8)),
        ]),
        const SizedBox(height: 8),
        ...actions.map((a) => Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              margin: const EdgeInsets.only(top: 5, right: 8),
              width: 5, height: 5,
              decoration: const BoxDecoration(
                color: AppColors.gold, shape: BoxShape.circle)),
            Expanded(child: Text(a, style: const TextStyle(
              color: AppColors.grey100, fontSize: 14, height: 1.5))),
          ]),
        )),
      ]),
    );
  }
}
