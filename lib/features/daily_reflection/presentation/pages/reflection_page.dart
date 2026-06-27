import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';

class ReflectionPage extends StatefulWidget {
  const ReflectionPage({super.key});
  @override
  State<ReflectionPage> createState() => _ReflectionPageState();
}

class _ReflectionPageState extends State<ReflectionPage> {
  final _controller = TextEditingController();
  bool _isListening = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleVoice() => setState(() => _isListening = !_isListening);

  void _submit() {
    if (_controller.text.trim().length < AppConstants.minReflectionChars) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cuéntame un poco más sobre tu día 🙏')),
      );
      return;
    }
    context.push(AppRoutes.result, extra: {'userInput': _controller.text.trim()});
  }

  @override
  Widget build(BuildContext context) {
    final chars = _controller.text.length;
    return Scaffold(
      backgroundColor: AppColors.navyBlue,
      appBar: AppBar(
        backgroundColor: AppColors.navyBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => context.pop(),
        ),
        title: Text('Mi reflexión',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.white)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DateChip(),
              const SizedBox(height: 12),
              Text('¿Qué pasó hoy?',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.grey300)),
              const SizedBox(height: 8),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.navyLight,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    controller: _controller,
                    maxLines: null,
                    expands: true,
                    maxLength: AppConstants.maxReflectionChars,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.white),
                    decoration: InputDecoration(
                      hintText: 'Hoy tuve una conversación difícil...',
                      hintStyle: TextStyle(color: AppColors.grey600),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(16),
                      counterText: '',
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _VoiceButton(isListening: _isListening, onTap: _toggleVoice),
                  Text('$chars / ${AppConstants.maxReflectionChars}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey600)),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: chars >= AppConstants.minReflectionChars ? _submit : null,
                icon: const Icon(Icons.auto_awesome, size: 18),
                label: const Text('Obtener mi reflexión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final days = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
    final months = ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun',
                    'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'];
    final label = '${days[now.weekday - 1]}, ${now.day} ${months[now.month - 1]}';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.navyLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.calendar_today_outlined, size: 12, color: AppColors.grey300),
          const SizedBox(width: 6),
          Text(label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey300)),
        ],
      ),
    );
  }
}

class _VoiceButton extends StatelessWidget {
  final bool isListening;
  final VoidCallback onTap;
  const _VoiceButton({required this.isListening, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: isListening ? AppColors.gold : AppColors.navyLight,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isListening ? Icons.mic : Icons.mic_none_outlined,
              color: isListening ? AppColors.navyBlue : AppColors.gold,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            isListening ? 'Escuchando...' : 'Habla en lugar de escribir',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isListening ? AppColors.gold : AppColors.grey600),
          ),
        ],
      ),
    );
  }
}
