import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/notif_provider.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notifProvider);

    return Scaffold(
      backgroundColor: AppColors.navyBlue,
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => context.pop(),
        ),
        title: Text('Recordatorio diario',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _InfoCard(context),
            const SizedBox(height: 20),
            _ToggleCard(context, ref, state),
            const SizedBox(height: 16),
            if (state.enabled) _TimeCard(context, ref, state),
            const Spacer(),
            if (state.enabled) _SaveButton(context, ref, state),
          ],
        ),
      ),
    );
  }

  Widget _InfoCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.navyLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gold.withOpacity(0.3)),
      ),
      child: Column(children: [
        const Text('🔔', style: TextStyle(fontSize: 36)),
        const SizedBox(height: 12),
        Text('Recordatorio diario',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.white, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Text(
          'Activa un recordatorio para reflexionar cada dia. La constancia es la clave del crecimiento espiritual.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.grey300, height: 1.6)),
      ]),
    );
  }

  Widget _ToggleCard(BuildContext context, WidgetRef ref, NotifState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.navyLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(children: [
        const Icon(Icons.notifications_outlined, color: AppColors.gold, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Activar recordatorio',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.white)),
            Text(state.enabled ? 'Recordatorio activo' : 'Sin recordatorio',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: state.enabled ? AppColors.gold : AppColors.grey600)),
          ]),
        ),
        Switch(
          value: state.enabled,
          onChanged: (val) => ref.read(notifProvider.notifier).toggle(val),
          activeColor: AppColors.gold,
          activeTrackColor: AppColors.gold.withOpacity(0.3),
          inactiveThumbColor: AppColors.grey600,
          inactiveTrackColor: AppColors.navyBlue,
        ),
      ]),
    );
  }

  Widget _TimeCard(BuildContext context, WidgetRef ref, NotifState state) {
    return GestureDetector(
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: state.time,
          builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              timePickerTheme: TimePickerThemeData(
                backgroundColor: AppColors.navyLight,
                hourMinuteColor: AppColors.navyBlue,
                hourMinuteTextColor: AppColors.white,
                dayPeriodColor: AppColors.navyBlue,
                dayPeriodTextColor: AppColors.gold,
                dialBackgroundColor: AppColors.navyBlue,
                dialHandColor: AppColors.gold,
                dialTextColor: AppColors.white,
                entryModeIconColor: AppColors.gold,
              ),
              colorScheme: const ColorScheme.dark(
                primary: AppColors.gold,
                onPrimary: AppColors.navyBlue,
                surface: AppColors.navyLight,
                onSurface: AppColors.white,
              ),
            ),
            child: child!,
          ),
        );
        if (picked != null) {
          ref.read(notifProvider.notifier).setTime(picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.navyLight,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(children: [
          const Icon(Icons.access_time_outlined, color: AppColors.gold, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Hora del recordatorio',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.white)),
              Text('Toca para cambiar la hora',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey600)),
            ]),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.gold.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.gold.withOpacity(0.4)),
            ),
            child: Text(
              _formatTime(state.time),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.gold, fontWeight: FontWeight.w700),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _SaveButton(BuildContext context, WidgetRef ref, NotifState state) {
    return ElevatedButton.icon(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Recordatorio guardado para las \${_formatTime(state.time)}',
            ),
            backgroundColor: AppColors.navyLight,
          ),
        );
        context.pop();
      },
      icon: const Icon(Icons.check, size: 18),
      label: const Text('Guardar recordatorio'),
    );
  }

  String _formatTime(TimeOfDay t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '\$h:\$m';
  }
}
