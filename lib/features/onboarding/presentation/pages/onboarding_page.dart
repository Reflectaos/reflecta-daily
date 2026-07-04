import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../profile/presentation/providers/profile_provider.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});
  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final _pageCtrl = PageController();
  final _nameCtrl = TextEditingController();
  int _current = 0;

  final _pages = const [
    _OnboardingData(
      emoji: '✨',
      title: 'Bienvenido a Reflecta Daily',
      body: 'Tu espejo espiritual diario. Un lugar donde la fe y la tecnologia se unen para guiarte cada dia.',
    ),
    _OnboardingData(
      emoji: '📖',
      title: 'Cuéntame tu dia',
      body: 'Escribe o habla sobre lo que viviste. La IA te devuelve una reflexion profunda, un versiculo biblico y un plan de accion.',
    ),
    _OnboardingData(
      emoji: '🎯',
      title: 'Construye un habito',
      body: 'Cada reflexion queda guardada. Ve tu racha crecer y mira como Dios trabaja en tu historia dia a dia.',
    ),
  ];

  @override
  void dispose() {
    _pageCtrl.dispose();
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    final name = _nameCtrl.text.trim();
    if (name.isNotEmpty) {
      await ref.read(profileServiceProvider).saveProfile(name);
      ref.invalidate(profileProvider);
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);
    if (mounted) context.go(AppRoutes.home);
  }

  void _next() {
    if (_current < _pages.length) {
      _pageCtrl.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _current == _pages.length;
    return Scaffold(
      backgroundColor: AppColors.navyBlue,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _DotsIndicator(count: _pages.length + 1, current: _current),
            const SizedBox(height: 32),
            Expanded(
              child: PageView(
                controller: _pageCtrl,
                onPageChanged: (i) => setState(() => _current = i),
                children: [
                  ..._pages.map((p) => _PageContent(data: p)),
                  _NamePage(controller: _nameCtrl),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: ElevatedButton(
                onPressed: isLastPage ? _finish : _next,
                child: Text(isLastPage ? 'Empezar mi camino' : 'Continuar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingData {
  final String emoji;
  final String title;
  final String body;
  const _OnboardingData({required this.emoji, required this.title, required this.body});
}

class _PageContent extends StatelessWidget {
  final _OnboardingData data;
  const _PageContent({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(data.emoji, style: const TextStyle(fontSize: 72)),
          const SizedBox(height: 32),
          Text(data.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.white, fontWeight: FontWeight.w800)),
          const SizedBox(height: 16),
          Text(data.body,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.grey300, height: 1.7)),
        ],
      ),
    );
  }
}

class _NamePage extends StatelessWidget {
  final TextEditingController controller;
  const _NamePage({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('👤', style: TextStyle(fontSize: 72)),
          const SizedBox(height: 32),
          Text('Como te llamas?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.white, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          Text('Quiero llamarte por tu nombre cada vez que reflexionemos juntos.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.grey300, height: 1.7)),
          const SizedBox(height: 32),
          TextField(
            controller: controller,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            style: const TextStyle(color: AppColors.white),
            decoration: InputDecoration(
              hintText: 'Tu nombre',
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
      ),
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  final int count;
  final int current;
  const _DotsIndicator({required this.count, required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width:  i == current ? 24 : 8,
        height: 8,
        decoration: BoxDecoration(
          color: i == current ? AppColors.gold : AppColors.navyLight,
          borderRadius: BorderRadius.circular(4),
        ),
      )),
    );
  }
}
