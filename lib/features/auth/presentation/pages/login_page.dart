import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/auth_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailCtrl    = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _isRegister    = false;
  bool _obscure       = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submitEmail() async {
    final email    = _emailCtrl.text.trim();
    final password = _passwordCtrl.text.trim();
    if (email.isEmpty || password.isEmpty) return;
    final notifier = ref.read(authNotifierProvider.notifier);
    if (_isRegister) {
      await notifier.registerWithEmail(email, password);
    } else {
      await notifier.signInWithEmail(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authNotifierProvider);
    final authUser = ref.watch(authStateProvider);

    // Redirigir si ya está autenticado
    authUser.whenData((user) {
      if (user != null && mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go(AppRoutes.home);
        });
      }
    });

    final isLoading = state.status == AuthStatus.loading;

    return Scaffold(
      backgroundColor: AppColors.navyBlue,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo / título
              Center(
                child: Column(children: [
                  Container(
                    width: 72, height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.gold,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.auto_awesome, color: AppColors.navyBlue, size: 36),
                  ),
                  const SizedBox(height: 16),
                  Text('Reflecta Daily',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: AppColors.white, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Text('Tu espejo espiritual diario',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.grey300)),
                ]),
              ),
              const SizedBox(height: 48),

              // Google button
              _GoogleButton(
                isLoading: isLoading,
                onPressed: () => ref.read(authNotifierProvider.notifier).signInWithGoogle(),
              ),

              const SizedBox(height: 20),
              Row(children: [
                const Expanded(child: Divider(color: AppColors.navyLight, thickness: 1)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text('o', style: TextStyle(color: AppColors.grey600)),
                ),
                const Expanded(child: Divider(color: AppColors.navyLight, thickness: 1)),
              ]),
              const SizedBox(height: 20),

              // Email field
              TextField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: AppColors.white),
                decoration: InputDecoration(
                  hintText: 'tu@correo.com',
                  hintStyle: const TextStyle(color: AppColors.grey600),
                  prefixIcon: const Icon(Icons.mail_outline, color: AppColors.grey600),
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
              const SizedBox(height: 12),

              // Password field
              TextField(
                controller: _passwordCtrl,
                obscureText: _obscure,
                style: const TextStyle(color: AppColors.white),
                decoration: InputDecoration(
                  hintText: 'Contraseña',
                  hintStyle: const TextStyle(color: AppColors.grey600),
                  prefixIcon: const Icon(Icons.lock_outline, color: AppColors.grey600),
                  suffixIcon: IconButton(
                    icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: AppColors.grey600),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
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
              const SizedBox(height: 8),

              // Error
              if (state.error != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(state.error!,
                    style: const TextStyle(color: Color(0xFFE53935), fontSize: 13)),
                ),

              const SizedBox(height: 8),

              // Submit button
              ElevatedButton(
                onPressed: isLoading ? null : _submitEmail,
                child: isLoading
                  ? const SizedBox(width: 20, height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.navyBlue))
                  : Text(_isRegister ? 'Crear cuenta' : 'Iniciar sesión'),
              ),
              const SizedBox(height: 16),

              // Toggle register/login
              Center(
                child: TextButton(
                  onPressed: () => setState(() => _isRegister = !_isRegister),
                  child: Text(
                    _isRegister
                      ? '¿Ya tienes cuenta? Inicia sesión'
                      : '¿No tienes cuenta? Regístrate',
                    style: const TextStyle(color: AppColors.gold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoogleButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  const _GoogleButton({required this.isLoading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 52),
        side: const BorderSide(color: AppColors.navyLight, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        backgroundColor: AppColors.navyLight,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('G', style: TextStyle(
          color: AppColors.white, fontSize: 18, fontWeight: FontWeight.w700)),
        const SizedBox(width: 10),
        const Text('Continuar con Google',
          style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w600)),
      ]),
    );
  }
}
