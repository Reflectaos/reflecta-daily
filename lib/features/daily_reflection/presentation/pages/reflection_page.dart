import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';
import '../providers/reflection_provider.dart';

class ReflectionPage extends ConsumerStatefulWidget {
  const ReflectionPage({super.key});
  @override
  ConsumerState<ReflectionPage> createState() => _ReflectionPageState();
}

class _ReflectionPageState extends ConsumerState<ReflectionPage> {
  final _controller = TextEditingController();
  final _speech     = SpeechToText();

  bool _isListening    = false;
  bool _speechReady    = false;
  String _liveWords    = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    final available = await _speech.initialize(
      onError:  (e) => setState(() => _isListening = false),
      onStatus: (s) {
        if (s == 'done' || s == 'notListening') {
          setState(() => _isListening = false);
        }
      },
    );
    setState(() => _speechReady = available);
  }

  Future<void> _toggleVoice() async {
    if (!_speechReady) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Micrófono no disponible en este dispositivo')),
      );
      return;
    }

    if (_isListening) {
      await _speech.stop();
      setState(() => _isListening = false);
    } else {
      setState(() { _isListening = true; _liveWords = ''; });
      await _speech.listen(
        localeId: 'es_MX',
        listenFor: const Duration(minutes: 2),
        pauseFor:  const Duration(seconds: 4),
        onResult: (result) {
          setState(() {
            _liveWords = result.recognizedWords;
            _controller.text = _liveWords;
            _controller.selection = TextSelection.fromPosition(
              TextPosition(offset: _controller.text.length),
            );
          });
        },
      );
    }
  }

  Future<void> _submit() async {
    final text = _controller.text.trim();
    if (text.length < AppConstants.minReflectionChars) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cuéntame un poco más sobre tu día 🙏')),
      );
      return;
    }
    if (_isListening) await _speech.stop();
    await ref.read(reflectionProvider.notifier).generate(text);
    if (mounted) context.push(AppRoutes.result, extra: {'userInput': text});
  }

  @override
  void dispose() {
    _speech.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state     = ref.watch(reflectionProvider);
    final isLoading = state.status == ReflectionStatus.loading;
    final chars     = _controller.text.length;

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

              // Textarea
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: AppColors.navyLight,
                    borderRadius: BorderRadius.circular(16),
                    border: _isListening
                      ? Border.all(color: AppColors.gold, width: 2)
                      : Border.all(color: Colors.transparent, width: 2),
                  ),
                  child: Stack(
                    children: [
                      TextField(
                        controller: _controller,
                        maxLines:   null,
                        expands:    true,
                        maxLength:  AppConstants.maxReflectionChars,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.white),
                        decoration: InputDecoration(
                          hintText: _isListening
                            ? 'Escuchando... habla ahora'
                            : 'Hoy tuve una conversación difícil...',
                          hintStyle: TextStyle(
                            color: _isListening ? AppColors.gold.withOpacity(0.6) : AppColors.grey600),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(16),
                          counterText: '',
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                      // Indicador de escucha
                      if (_isListening)
                        Positioned(
                          top: 10, right: 10,
                          child: _PulsingDot(),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _VoiceButton(
                    isListening: _isListening,
                    speechReady: _speechReady,
                    onTap: _toggleVoice,
                  ),
                  Text('$chars / ${AppConstants.maxReflectionChars}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey600)),
                ],
              ),
              const SizedBox(height: 16),

              ElevatedButton.icon(
                onPressed: isLoading || chars < AppConstants.minReflectionChars ? null : _submit,
                icon: isLoading
                  ? const SizedBox(width: 18, height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.navyBlue))
                  : const Icon(Icons.auto_awesome, size: 18),
                label: Text(isLoading ? 'Generando tu reflexión...' : 'Obtener mi reflexión'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Widgets auxiliares ────────────────────────────────────

class _PulsingDot extends StatefulWidget {
  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _anim = Tween(begin: 0.4, end: 1.0).animate(_ctrl);
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _anim,
      child: Container(
        width: 10, height: 10,
        decoration: const BoxDecoration(color: AppColors.gold, shape: BoxShape.circle),
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final now    = DateTime.now();
    final days   = ['Lun','Mar','Mié','Jue','Vie','Sáb','Dom'];
    final months = ['Ene','Feb','Mar','Abr','May','Jun','Jul','Ago','Sep','Oct','Nov','Dic'];
    final label  = '${days[now.weekday - 1]}, ${now.day} ${months[now.month - 1]}';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: AppColors.navyLight, borderRadius: BorderRadius.circular(20)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        const Icon(Icons.calendar_today_outlined, size: 12, color: AppColors.grey300),
        const SizedBox(width: 6),
        Text(label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.grey300)),
      ]),
    );
  }
}

class _VoiceButton extends StatelessWidget {
  final bool isListening;
  final bool speechReady;
  final VoidCallback onTap;
  const _VoiceButton({
    required this.isListening,
    required this.speechReady,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 40, height: 40,
          decoration: BoxDecoration(
            color: isListening ? AppColors.gold : AppColors.navyLight,
            shape: BoxShape.circle,
          ),
          child: Icon(
            isListening ? Icons.mic : Icons.mic_none_outlined,
            color: isListening ? AppColors.navyBlue : (speechReady ? AppColors.gold : AppColors.grey600),
            size: 20,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          isListening
            ? 'Toca para detener'
            : speechReady
              ? 'Habla en lugar de escribir'
              : 'Micrófono no disponible',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: isListening ? AppColors.gold : AppColors.grey600),
        ),
      ]),
    );
  }
}
